#!/bin/bash

# Скрипт для настройки среды разработки

echo "🛠️  Настройка среды разработки Django + Vue..."

# Проверяем Python
if ! command -v python3 &> /dev/null; then
    echo "❌ Python3 не найден. Установите Python 3.8+"
    exit 1
fi

# Проверяем Node.js
if ! command -v node &> /dev/null; then
    echo "❌ Node.js не найден. Установите Node.js 16+"
    exit 1
fi

echo "✅ Python и Node.js найдены"

# Настройка Django
echo "🐍 Настройка Django..."
cd backend

# Создаем виртуальное окружение если его нет
if [ ! -d "../venv" ]; then
    echo "📦 Создаем виртуальное окружение..."
    cd ..
    python3 -m venv venv
    cd backend
fi

# Активируем виртуальное окружение и устанавливаем зависимости
echo "📦 Устанавливаем зависимости Django..."
source ../venv/bin/activate
pip install -r ../requirements.txt

# Применяем миграции
echo "🗄️  Применяем миграции..."
python3 manage.py migrate

# Возвращаемся в корень
cd ..

# Настройка Vue
echo "⚡ Настройка Vue..."
cd frontend

# Устанавливаем зависимости
echo "📦 Устанавливаем зависимости Vue..."
npm install

cd ..

echo "🎉 Среда разработки настроена!"
echo ""
echo "Для запуска в режиме разработки:"
echo "  1. Django API (в одном терминале):"
echo "     cd backend && source ../venv/bin/activate && python3 manage.py runserver"
echo ""
echo "  2. Vue frontend (в другом терминале):"
echo "     cd frontend && npm run dev"
echo ""
echo "Для production сборки:"
echo "  ./build_frontend.sh"
