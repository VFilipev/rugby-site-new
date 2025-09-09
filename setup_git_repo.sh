#!/bin/bash

# Скрипт для настройки git репозитория с полным проектом Rugby Site
# Использование: ./setup_git_repo.sh <your-repo-url>

set -e

# Цвета для вывода
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

# Проверяем аргументы
if [ $# -eq 0 ]; then
    error "Укажите URL репозитория: ./setup_git_repo.sh <your-repo-url>"
    echo ""
    echo "Примеры:"
    echo "  ./setup_git_repo.sh https://github.com/username/rugby-site.git"
    echo "  ./setup_git_repo.sh git@github.com:username/rugby-site.git"
    exit 1
fi

REPO_URL=$1
PROJECT_NAME="rugby-site"

log "🚀 Настройка git репозитория для Rugby Site..."
log "URL репозитория: $REPO_URL"

# Проверяем, что мы в корневой директории проекта
if [ ! -f "requirements.txt" ] || [ ! -d "backend" ] || [ ! -d "frontend" ]; then
    error "Убедитесь, что вы находитесь в корневой директории проекта Rugby Site"
    error "Должны быть файлы: requirements.txt, папки: backend/, frontend/"
    exit 1
fi

# Проверяем наличие git
if ! command -v git &> /dev/null; then
    error "Git не установлен. Установите git и повторите попытку."
    exit 1
fi

log "1. Инициализация git репозитория..."
if [ -d ".git" ]; then
    warn "Git репозиторий уже инициализирован"
    info "Текущие удаленные репозитории:"
    git remote -v
    echo ""
    read -p "Продолжить? (y/n): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        log "Отменено пользователем"
        exit 0
    fi
else
    git init
    log "Git репозиторий инициализирован"
fi

log "2. Настройка удаленного репозитория..."
if git remote get-url origin &> /dev/null; then
    CURRENT_URL=$(git remote get-url origin)
    if [ "$CURRENT_URL" != "$REPO_URL" ]; then
        warn "Текущий URL: $CURRENT_URL"
        warn "Новый URL: $REPO_URL"
        read -p "Заменить URL? (y/n): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            git remote set-url origin "$REPO_URL"
            log "URL обновлен"
        fi
    else
        log "URL уже настроен правильно"
    fi
else
    git remote add origin "$REPO_URL"
    log "Удаленный репозиторий добавлен"
fi

log "3. Проверка .gitignore..."
if [ ! -f ".gitignore" ]; then
    warn ".gitignore не найден, создаем базовый..."
    cat > .gitignore << 'EOF'
# Python
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
wheels/
*.egg-info/
.installed.cfg
*.egg
MANIFEST

# Django
*.log
local_settings.py
db.sqlite3
db.sqlite3-journal
backend/staticfiles/
backend/media/

# Node.js
node_modules/
npm-debug.log*
yarn-debug.log*
yarn-error.log*
frontend/dist/

# IDE
.vscode/
.idea/
*.swp
*.swo
*~

# OS
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
ehthumbs.db
Thumbs.db

# Environment
.env
.env.local
.env.production
.env.staging
venv/
ENV/
env.bak/
venv.bak/
EOF
    log ".gitignore создан"
else
    log ".gitignore уже существует"
fi

log "4. Добавление файлов в git..."
git add .

log "5. Проверка статуса..."
git status

echo ""
info "Файлы, которые будут добавлены в репозиторий:"
git diff --cached --name-only | head -20
if [ $(git diff --cached --name-only | wc -l) -gt 20 ]; then
    echo "... и еще $(($(git diff --cached --name-only | wc -l) - 20)) файлов"
fi

echo ""
read -p "Продолжить коммит? (y/n): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    log "Отменено пользователем"
    exit 0
fi

log "6. Создание коммита..."
git commit -m "Initial commit: Complete Rugby Site project

- Django backend with API endpoints
- Vue.js frontend with dynamic content
- Deployment scripts and configuration
- Nginx configuration
- Documentation and setup guides

Features:
- Schools and locations management
- Events and news system
- Matches and tournaments
- Team management
- Admin interface"

log "7. Отправка в репозиторий..."
git push -u origin main

log "✅ Git репозиторий настроен успешно!"
log ""
log "📋 Что дальше:"
log "1. На сервере: git clone $REPO_URL"
log "2. На сервере: cd rugby-site && ./deploy.sh"
log "3. На сервере: sudo ./nginx_setup.sh"
log "4. Запустить Django: cd backend && python manage.py runserver --settings=rugby_backend.settings_production"
log ""
log "🌐 Ваш проект готов к деплою!"
log "📖 Документация: README_DEPLOY.md, NGINX_SETUP.md"
