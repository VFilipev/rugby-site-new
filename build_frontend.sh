#!/bin/bash

# Скрипт для сборки Vue приложения и интеграции с Django

echo "🚀 Начинаем сборку Vue приложения..."

# Переходим в директорию frontend
cd frontend

# Проверяем наличие node_modules
if [ ! -d "node_modules" ]; then
    echo "📦 Устанавливаем зависимости..."
    npm install
fi

# Собираем проект
echo "🔨 Собираем Vue приложение..."
npm run build:django

# Возвращаемся в корневую директорию
cd ..

# Проверяем что сборка прошла успешно
if [ -f "backend/static/frontend/index.html" ]; then
    echo "✅ Сборка Vue приложения завершена успешно!"
    echo "📁 Статические файлы размещены в: backend/static/frontend/"

    # Собираем статику Django
    echo "📦 Собираем статику Django..."
    cd backend
    python3 manage.py collectstatic --noinput
    cd ..

    echo "🎉 Интеграция Vue + Django готова!"
    echo ""
    echo "Для запуска Django сервера выполните:"
    echo "  cd backend"
    echo "  source ../venv/bin/activate"
    echo "  python3 manage.py runserver"
    echo ""
    echo "Приложение будет доступно по адресу: http://127.0.0.1:8000"
else
    echo "❌ Ошибка сборки Vue приложения!"
    exit 1
fi
