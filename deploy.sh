#!/bin/bash

# 🚀 Универсальный скрипт деплоя Django + Vue приложения
# Автор: AI Assistant
# Версия: 2.0

set -e  # Остановка при любой ошибке

# Цвета для вывода
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Функции для цветного вывода
log_info() { echo -e "${BLUE}ℹ️  $1${NC}"; }
log_success() { echo -e "${GREEN}✅ $1${NC}"; }
log_warning() { echo -e "${YELLOW}⚠️  $1${NC}"; }
log_error() { echo -e "${RED}❌ $1${NC}"; }

# Проверка окружения
check_requirements() {
    log_info "Проверяем системные требования..."

    # Проверяем Python
    if ! command -v python3 &> /dev/null; then
        log_error "Python3 не найден. Установите Python 3.8+"
        exit 1
    fi

    # Проверяем Node.js
    if ! command -v node &> /dev/null; then
        log_error "Node.js не найден. Установите Node.js 16+"
        exit 1
    fi

    # Проверяем npm
    if ! command -v npm &> /dev/null; then
        log_error "npm не найден. Установите npm"
        exit 1
    fi

    log_success "Системные требования проверены"
}

# Проверка и создание виртуального окружения
setup_venv() {
    log_info "Настройка виртуального окружения Python..."

    if [ ! -d "venv" ]; then
        log_info "Создаем виртуальное окружение..."
        python3 -m venv venv
    fi

    source venv/bin/activate

    # Обновляем pip
    pip install --upgrade pip

    # Устанавливаем зависимости
    if [ -f "requirements.txt" ]; then
        log_info "Устанавливаем Python зависимости..."
        pip install -r requirements.txt
    else
        log_error "Файл requirements.txt не найден!"
        exit 1
    fi

    log_success "Виртуальное окружение настроено"
}

# Проверка и установка Node.js зависимостей
setup_node() {
    log_info "Настройка Node.js окружения..."

    cd frontend

    if [ ! -d "node_modules" ]; then
        log_info "Устанавливаем Node.js зависимости..."
        npm install
    else
        log_info "Обновляем Node.js зависимости..."
        npm ci
    fi

    cd ..
    log_success "Node.js окружение настроено"
}

# Сборка Vue приложения
build_frontend() {
    log_info "Сборка Vue приложения..."

    cd frontend

    # Очищаем старую сборку
    if [ -d "../backend/static/frontend" ]; then
        rm -rf ../backend/static/frontend
        log_info "Очищена старая сборка"
    fi

    # Собираем приложение
    npm run build:django

    cd ..

    # Проверяем что сборка прошла успешно
    if [ -f "backend/static/frontend/index.html" ]; then
        log_success "Vue приложение собрано успешно"
    else
        log_error "Ошибка сборки Vue приложения!"
        exit 1
    fi
}

# Проверка и применение миграций Django
handle_migrations() {
    log_info "Проверка миграций Django..."

    cd backend
    source ../venv/bin/activate

    # Проверяем есть ли неприменённые миграции
    if python3 manage.py showmigrations --plan | grep -q "\[ \]"; then
        log_warning "Найдены неприменённые миграции. Применяем..."
        python3 manage.py migrate
        log_success "Миграции применены"
    else
        log_success "Все миграции уже применены"
    fi

    cd ..
}

# Сбор статических файлов Django
collect_static() {
    log_info "Сбор статических файлов Django..."

    cd backend
    source ../venv/bin/activate

    python3 manage.py collectstatic --noinput

    cd ..
    log_success "Статические файлы собраны"
}

# Проверка systemd демона (если существует)
check_daemon() {
    SERVICE_NAME="rugby-site"

    if systemctl list-unit-files | grep -q "${SERVICE_NAME}.service"; then
        log_info "Проверяем статус демона ${SERVICE_NAME}..."

        if systemctl is-active --quiet $SERVICE_NAME; then
            log_success "Демон ${SERVICE_NAME} активен"

            # Спрашиваем нужно ли перезапустить
            read -p "Перезапустить демон? (y/N): " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                log_info "Перезапускаем демон..."
                sudo systemctl restart $SERVICE_NAME
                sleep 2

                if systemctl is-active --quiet $SERVICE_NAME; then
                    log_success "Демон перезапущен успешно"
                else
                    log_error "Ошибка перезапуска демона"
                    systemctl status $SERVICE_NAME --no-pager
                fi
            fi
        else
            log_warning "Демон ${SERVICE_NAME} неактивен"
            read -p "Запустить демон? (y/N): " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                sudo systemctl start $SERVICE_NAME
                if systemctl is-active --quiet $SERVICE_NAME; then
                    log_success "Демон запущен успешно"
                else
                    log_error "Ошибка запуска демона"
                fi
            fi
        fi
    else
        log_info "Демон ${SERVICE_NAME} не найден - запуск в режиме разработки"
    fi
}

# Проверка работы приложения
health_check() {
    log_info "Проверка работы приложения..."

    # Проверяем доступность на localhost:8000
    if curl -s -f http://127.0.0.1:8000 > /dev/null; then
        log_success "Приложение доступно на http://127.0.0.1:8000"
    else
        log_warning "Приложение недоступно на стандартном порту"
        log_info "Возможно, нужно запустить сервер вручную:"
        log_info "cd backend && source ../venv/bin/activate && python3 manage.py runserver"
    fi
}

# Показ финальной информации
show_summary() {
    echo
    log_success "🎉 Деплой завершён!"
    echo
    echo "📋 Что было сделано:"
    echo "  ✓ Проверены системные требования"
    echo "  ✓ Настроено виртуальное окружение Python"
    echo "  ✓ Установлены/обновлены Node.js зависимости"
    echo "  ✓ Собрано Vue приложение"
    echo "  ✓ Проверены и применены миграции Django"
    echo "  ✓ Собраны статические файлы"
    echo "  ✓ Проверен статус демона"
    echo
    echo "🌐 Доступ к приложению:"
    echo "  • Основное приложение: http://127.0.0.1:8000"
    echo "  • Django админка: http://127.0.0.1:8000/admin/"
    echo "  • API: http://127.0.0.1:8000/api/"
    echo
    echo "🛠️  Для разработки:"
    echo "  • Frontend dev: cd frontend && npm run dev"
    echo "  • Backend dev: cd backend && source ../venv/bin/activate && python3 manage.py runserver"
    echo
}

# Основная функция
main() {
    echo "🚀 Запуск универсального деплоя Django + Vue приложения"
    echo "=================================================="
    echo

    # Проверяем что мы в корневой директории проекта
    if [ ! -f "requirements.txt" ] || [ ! -d "frontend" ] || [ ! -d "backend" ]; then
        log_error "Скрипт должен запускаться из корневой директории проекта!"
        log_error "Убедитесь что есть: requirements.txt, frontend/, backend/"
        exit 1
    fi

    # Выполняем все этапы деплоя
    check_requirements
    setup_venv
    setup_node
    build_frontend
    handle_migrations
    collect_static
    check_daemon
    health_check
    show_summary
}

# Обработка сигналов
trap 'log_error "Деплой прерван пользователем"; exit 1' INT TERM

# Запуск основной функции
main "$@"
