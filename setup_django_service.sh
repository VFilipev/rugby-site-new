#!/bin/bash

# Скрипт для настройки Django как systemd сервиса
# Запустите с правами sudo: sudo ./setup_django_service.sh

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

# Проверяем права sudo
if [ "$EUID" -ne 0 ]; then
    error "Запустите скрипт с правами sudo: sudo ./setup_django_service.sh"
    exit 1
fi

log "🔧 Настройка Django как systemd сервиса..."

# Получаем путь к проекту
PROJECT_PATH=$(pwd)
log "Путь к проекту: $PROJECT_PATH"

# Проверяем, что мы в корневой директории проекта
if [ ! -f "requirements.txt" ] || [ ! -d "backend" ]; then
    error "Убедитесь, что вы находитесь в корневой директории проекта Rugby Site"
    exit 1
fi

# 1. Создаем systemd сервис
log "1. Создание systemd сервиса..."
SERVICE_FILE="/etc/systemd/system/rugby-site.service"

# Создаем сервис с правильным путем к проекту
cat > $SERVICE_FILE << EOF
[Unit]
Description=Rugby Site Django Application
After=network.target

[Service]
Type=exec
User=www-data
Group=www-data
WorkingDirectory=$PROJECT_PATH/backend
Environment=DJANGO_SETTINGS_MODULE=rugby_backend.settings_production
ExecStart=$PROJECT_PATH/venv/bin/python manage.py runserver 127.0.0.1:8008
ExecReload=/bin/kill -HUP \$MAINPID
Restart=always
RestartSec=3

# Логирование
StandardOutput=journal
StandardError=journal
SyslogIdentifier=rugby-site

# Безопасность
NoNewPrivileges=true
PrivateTmp=true
ProtectSystem=strict
ProtectHome=true
ReadWritePaths=$PROJECT_PATH/backend/media
ReadWritePaths=$PROJECT_PATH/backend/logs

[Install]
WantedBy=multi-user.target
EOF

log "Сервис создан: $SERVICE_FILE"

# 2. Настраиваем права доступа
log "2. Настройка прав доступа..."
chown -R www-data:www-data "$PROJECT_PATH"
chmod -R 755 "$PROJECT_PATH"
chmod -R 777 "$PROJECT_PATH/backend/media"
chmod -R 777 "$PROJECT_PATH/backend/logs"

# 3. Перезагружаем systemd
log "3. Перезагрузка systemd..."
systemctl daemon-reload

# 4. Включаем автозапуск
log "4. Включение автозапуска..."
systemctl enable rugby-site

# 5. Запускаем сервис
log "5. Запуск сервиса..."
systemctl start rugby-site

# 6. Проверяем статус
log "6. Проверка статуса..."
sleep 2
systemctl status rugby-site --no-pager -l

# 7. Показываем логи
log "7. Последние логи сервиса:"
journalctl -u rugby-site --no-pager -l -n 10

log ""
log "✅ Django сервис настроен и запущен!"
log ""
log "📋 Управление сервисом:"
log "  Статус:     sudo systemctl status rugby-site"
log "  Запуск:     sudo systemctl start rugby-site"
log "  Остановка:  sudo systemctl stop rugby-site"
log "  Перезапуск: sudo systemctl restart rugby-site"
log "  Логи:       sudo journalctl -u rugby-site -f"
log ""
log "🌐 Ваш сайт доступен по адресу: http://rugbyperm.ru"
log "📊 Логи Django: $PROJECT_PATH/backend/logs/django.log"
log "📊 Логи systemd: sudo journalctl -u rugby-site"
