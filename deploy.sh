#!/bin/bash

# Скрипт для деплоя проекта Rugby Site
# Использование: ./deploy.sh

set -e  # Остановить выполнение при ошибке

echo "🚀 Начинаем деплой проекта Rugby Site..."

# Цвета для вывода
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Функция для вывода сообщений
log() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Проверяем, что мы в корневой директории проекта
if [ ! -f "requirements.txt" ]; then
    error "Файл requirements.txt не найден. Убедитесь, что вы находитесь в корневой директории проекта."
    exit 1
fi

log "1. Активация виртуального окружения..."
if [ -d "venv" ]; then
    source venv/bin/activate
    log "Виртуальное окружение активировано"
else
    warn "Виртуальное окружение не найдено. Создаем новое..."
    python3 -m venv venv
    source venv/bin/activate
    log "Виртуальное окружение создано и активировано"
fi

log "2. Установка зависимостей Python..."
pip install --upgrade pip
pip install -r requirements.txt

log "3. Сборка фронтенда..."
cd frontend
npm install
npm run build
cd ..

log "4. Копирование статических файлов фронтенда в Django..."
# Создаем директорию для статических файлов фронтенда
mkdir -p backend/static/frontend
# Копируем собранные файлы
cp -r frontend/dist/* backend/static/frontend/

log "5. Применение миграций Django..."
cd backend
python manage.py makemigrations
python manage.py migrate

log "6. Сбор статических файлов Django..."
python manage.py collectstatic --noinput

cd ..

log "✅ Деплой завершен успешно!"
log ""
log "Для запуска в режиме разработки:"
log "  cd backend && python manage.py runserver"
log ""
log "Для запуска в продакшене:"
log "  cd backend && python manage.py runserver --settings=rugby_backend.settings_production"
log ""
log "Админка доступна по адресу: http://localhost:8000/admin/"
log "Логин: admin, Пароль: admin123"
log ""
warn "⚠️  Не забудьте изменить пароль админа и настройки безопасности в продакшене!"
