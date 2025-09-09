# 🏉 Rugby Site - Инструкция по деплою

## 📋 Требования

- Python 3.8+
- Node.js 16+
- npm или yarn

## 🚀 Быстрый деплой

### 1. Клонирование и подготовка

```bash
# Клонируйте репозиторий
git clone <your-repo-url>
cd rugby-site

# Запустите скрипт деплоя
./deploy.sh
```

### 2. Ручной деплой

Если автоматический скрипт не работает, выполните команды вручную:

```bash
# 1. Создание и активация виртуального окружения
python3 -m venv venv
source venv/bin/activate  # Linux/Mac
# или
venv\Scripts\activate     # Windows

# 2. Установка зависимостей Python
pip install -r requirements.txt

# 3. Сборка фронтенда
cd frontend
npm install
npm run build
cd ..

# 4. Копирование статических файлов
mkdir -p backend/static/frontend
cp -r frontend/dist/* backend/static/frontend/

# 5. Настройка Django
cd backend
python manage.py makemigrations
python manage.py migrate
python manage.py collectstatic --noinput

# 6. Создание суперпользователя
python manage.py createsuperuser
```

## 🌐 Запуск

### Режим разработки
```bash
cd backend
python manage.py runserver
```

### Продакшен
```bash
cd backend
python manage.py runserver --settings=rugby_backend.settings_production
```

## 🔧 Настройка для продакшена

### 1. Обновите настройки домена

Отредактируйте файл `backend/rugby_backend/settings_production.py`:

```python
ALLOWED_HOSTS = [
    'your-domain.com',
    'www.your-domain.com',
]

CORS_ALLOWED_ORIGINS = [
    "https://your-domain.com",
    "https://www.your-domain.com",
]
```

### 2. Настройте переменные окружения

Создайте файл `.env` в корне проекта:

```env
SECRET_KEY=your-secret-key-here
DEBUG=False
```

### 3. Настройте веб-сервер

#### Nginx конфигурация:

```nginx
server {
    listen 80;
    server_name your-domain.com www.your-domain.com;

    location /static/ {
        alias /path/to/rugby-site/backend/staticfiles/;
    }

    location /media/ {
        alias /path/to/rugby-site/backend/media/;
    }

    location / {
        proxy_pass http://127.0.0.1:8000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

#### Gunicorn для продакшена:

```bash
pip install gunicorn
gunicorn --bind 0.0.0.0:8000 rugby_backend.wsgi_production:application
```

## 📁 Структура проекта

```
rugby-site/
├── backend/                 # Django backend
│   ├── api/                # API приложение
│   ├── rugby_backend/      # Настройки Django
│   ├── static/             # Статические файлы
│   ├── media/              # Загруженные файлы
│   └── db.sqlite3         # База данных
├── frontend/               # Vue.js frontend
│   ├── src/               # Исходный код
│   └── dist/              # Собранные файлы
├── requirements.txt        # Python зависимости
├── deploy.sh              # Скрипт деплоя
└── README_DEPLOY.md       # Эта инструкция
```

## 🔐 Безопасность

### Обязательно для продакшена:

1. **Измените SECRET_KEY** в `settings_production.py`
2. **Создайте нового суперпользователя** с надежным паролем
3. **Настройте HTTPS** (раскомментируйте соответствующие настройки)
4. **Ограничьте ALLOWED_HOSTS** только вашими доменами
5. **Отключите DEBUG** в продакшене

### Рекомендации:

- Используйте PostgreSQL вместо SQLite для продакшена
- Настройте резервное копирование базы данных
- Используйте CDN для статических файлов
- Настройте мониторинг и логирование

## 🐛 Решение проблем

### Ошибка "No module named 'django'"
```bash
source venv/bin/activate
pip install -r requirements.txt
```

### Ошибка "npm: command not found"
Установите Node.js: https://nodejs.org/

### Ошибка "Permission denied"
```bash
chmod +x deploy.sh
```

### Проблемы с CORS
Проверьте настройки `CORS_ALLOWED_ORIGINS` в `settings_production.py`

## 📞 Поддержка

При возникновении проблем проверьте:

1. Логи Django: `backend/logs/django.log`
2. Логи веб-сервера (Nginx/Apache)
3. Консоль браузера для ошибок фронтенда

## 🎯 API Endpoints

- `/api/matches/` - Матчи
- `/api/tournaments/` - Турниры
- `/api/events/` - События
- `/api/players/` - Игроки
- `/api/schools/` - Школы
- `/api/school-locations/` - Локации школ
- `/admin/` - Админка Django

---

**Удачного деплоя! 🏉**
