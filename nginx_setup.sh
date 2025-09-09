#!/bin/bash

# Скрипт для настройки Nginx для Rugby Site
# Запустите с правами sudo: sudo ./nginx_setup.sh

set -e

# Цвета для вывода
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
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

# Проверяем права sudo
if [ "$EUID" -ne 0 ]; then
    error "Запустите скрипт с правами sudo: sudo ./nginx_setup.sh"
    exit 1
fi

log "🔧 Настройка Nginx для Rugby Site..."

# Получаем путь к проекту
PROJECT_PATH=$(pwd)
log "Путь к проекту: $PROJECT_PATH"

# 1. Устанавливаем Nginx (если не установлен)
log "1. Проверка установки Nginx..."
if ! command -v nginx &> /dev/null; then
    log "Установка Nginx..."
    apt update
    apt install -y nginx
else
    log "Nginx уже установлен"
fi

# 2. Создаем конфигурацию сайта
log "2. Создание конфигурации Nginx..."
NGINX_CONFIG="/etc/nginx/sites-available/rugbyperm.ru"

# Создаем конфигурацию с правильным путем к проекту
cat > $NGINX_CONFIG << EOF
server {
    listen 80;
    server_name rugbyperm.ru www.rugbyperm.ru;

    # Перенаправление на HTTPS (раскомментируйте после настройки SSL)
    # return 301 https://\$server_name\$request_uri;

    # Временная конфигурация для HTTP (до настройки SSL)
    location / {
        proxy_pass http://127.0.0.1:8000;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
        proxy_connect_timeout 30s;
        proxy_send_timeout 30s;
        proxy_read_timeout 30s;
    }

    # Статические файлы Django
    location /static/ {
        alias $PROJECT_PATH/backend/staticfiles/;
        expires 1y;
        add_header Cache-Control "public, immutable";
    }

    # Медиа файлы (загруженные пользователями)
    location /media/ {
        alias $PROJECT_PATH/backend/media/;
        expires 1y;
        add_header Cache-Control "public";
    }

    # Логи
    access_log /var/log/nginx/rugbyperm.ru.access.log;
    error_log /var/log/nginx/rugbyperm.ru.error.log;
}
EOF

log "Конфигурация создана: $NGINX_CONFIG"

# 3. Активируем сайт
log "3. Активация сайта..."
ln -sf $NGINX_CONFIG /etc/nginx/sites-enabled/
log "Сайт активирован"

# 4. Удаляем дефолтную конфигурацию (если есть)
if [ -f "/etc/nginx/sites-enabled/default" ]; then
    log "Удаление дефолтной конфигурации..."
    rm /etc/nginx/sites-enabled/default
fi

# 5. Проверяем конфигурацию
log "4. Проверка конфигурации Nginx..."
nginx -t

if [ $? -eq 0 ]; then
    log "✅ Конфигурация Nginx корректна"
else
    error "❌ Ошибка в конфигурации Nginx"
    exit 1
fi

# 6. Перезапускаем Nginx
log "5. Перезапуск Nginx..."
systemctl restart nginx
systemctl enable nginx

log "✅ Nginx настроен и запущен!"

# 7. Показываем статус
log "6. Статус сервисов:"
systemctl status nginx --no-pager -l

log ""
log "🎉 Настройка Nginx завершена!"
log ""
log "📋 Что дальше:"
log "1. Убедитесь, что домен rugbyperm.ru указывает на ваш сервер"
log "2. Запустите Django: cd backend && python manage.py runserver --settings=rugby_backend.settings_production"
log "3. Для HTTPS установите SSL сертификат (Let's Encrypt):"
log "   sudo apt install certbot python3-certbot-nginx"
log "   sudo certbot --nginx -d rugbyperm.ru -d www.rugbyperm.ru"
log ""
log "🌐 Ваш сайт будет доступен по адресу: http://rugbyperm.ru"
log "📊 Логи Nginx: /var/log/nginx/rugbyperm.ru.*.log"
