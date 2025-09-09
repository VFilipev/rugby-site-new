# 🔧 Настройка Nginx для Rugby Site

## 🚀 Автоматическая настройка

### 1. Запустите скрипт настройки:
```bash
sudo ./nginx_setup.sh
```

Этот скрипт:
- Установит Nginx (если не установлен)
- Создаст конфигурацию для `rugbyperm.ru`
- Активирует сайт
- Проверит и перезапустит Nginx

## 🔧 Ручная настройка

### 1. Установка Nginx:
```bash
sudo apt update
sudo apt install nginx
```

### 2. Создание конфигурации:
```bash
sudo nano /etc/nginx/sites-available/rugbyperm.ru
```

Вставьте содержимое из файла `nginx.conf`, заменив `/path/to/rugby-site/` на реальный путь к проекту.

### 3. Активация сайта:
```bash
sudo ln -s /etc/nginx/sites-available/rugbyperm.ru /etc/nginx/sites-enabled/
sudo rm /etc/nginx/sites-enabled/default  # Удаляем дефолтную конфигурацию
```

### 4. Проверка и перезапуск:
```bash
sudo nginx -t
sudo systemctl restart nginx
sudo systemctl enable nginx
```

## 🔒 Настройка HTTPS (SSL)

### 1. Установка Certbot:
```bash
sudo apt install certbot python3-certbot-nginx
```

### 2. Получение SSL сертификата:
```bash
sudo certbot --nginx -d rugbyperm.ru -d www.rugbyperm.ru
```

### 3. Автоматическое обновление:
```bash
sudo crontab -e
# Добавьте строку:
0 12 * * * /usr/bin/certbot renew --quiet
```

## 📋 Конфигурация Nginx

### Основные настройки:
- **Порт 80**: HTTP (временно, до настройки SSL)
- **Порт 443**: HTTPS (после настройки SSL)
- **Статические файлы**: `/static/` → `backend/staticfiles/`
- **Медиа файлы**: `/media/` → `backend/media/`
- **Прокси**: Все остальные запросы → Django на порту 8000

### Оптимизация:
- **Кэширование статики**: 1 год
- **Gzip сжатие**: Включено
- **Безопасность**: HSTS, безопасные заголовки

## 🐛 Решение проблем

### Ошибка "502 Bad Gateway":
```bash
# Проверьте, что Django запущен
ps aux | grep python
# Запустите Django
cd backend && python manage.py runserver --settings=rugby_backend.settings_production
```

### Ошибка "Permission denied":
```bash
# Проверьте права на файлы
sudo chown -R www-data:www-data /path/to/rugby-site/backend/staticfiles/
sudo chown -R www-data:www-data /path/to/rugby-site/backend/media/
```

### Ошибка конфигурации:
```bash
# Проверьте синтаксис
sudo nginx -t
# Посмотрите логи
sudo tail -f /var/log/nginx/error.log
```

## 📊 Мониторинг

### Логи Nginx:
```bash
# Доступ к сайту
sudo tail -f /var/log/nginx/rugbyperm.ru.access.log

# Ошибки
sudo tail -f /var/log/nginx/rugbyperm.ru.error.log

# Общие логи
sudo tail -f /var/log/nginx/error.log
```

### Статус сервисов:
```bash
# Статус Nginx
sudo systemctl status nginx

# Статус Django
ps aux | grep python
```

## 🔧 Дополнительные настройки

### Ограничение скорости:
```nginx
location / {
    limit_req zone=api burst=20 nodelay;
    proxy_pass http://127.0.0.1:8000;
    # ... остальные настройки
}
```

### Блокировка ботов:
```nginx
location / {
    if ($http_user_agent ~* (bot|crawler|spider)) {
        return 403;
    }
    proxy_pass http://127.0.0.1:8000;
    # ... остальные настройки
}
```

## 📈 Производительность

### Рекомендации:
1. **Включите gzip** в основной конфигурации Nginx
2. **Настройте кэширование** для статических файлов
3. **Используйте CDN** для изображений
4. **Настройте мониторинг** (например, UptimeRobot)

### Проверка производительности:
```bash
# Тест скорости
curl -w "@curl-format.txt" -o /dev/null -s "http://rugbyperm.ru"

# Проверка сжатия
curl -H "Accept-Encoding: gzip" -I http://rugbyperm.ru
```

---

## 🎯 Итоговая последовательность:

1. **На сервере**: `sudo ./nginx_setup.sh`
2. **Запустить Django**: `python manage.py runserver --settings=rugby_backend.settings_production`
3. **Настроить SSL**: `sudo certbot --nginx -d rugbyperm.ru -d www.rugbyperm.ru`
4. **Проверить**: Открыть http://rugbyperm.ru

**Готово! Ваш сайт работает через Nginx! 🚀**
