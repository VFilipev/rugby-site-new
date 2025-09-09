# Интеграция Django + Vue.js

Этот проект настроен для работы Django бэкенда с Vue.js фронтендом. После сборки Vue приложения статические файлы автоматически импортируются в Django.

## 🚀 Быстрый старт

### Первоначальная настройка
```bash
# Клонируйте репозиторий и перейдите в директорию
cd rugby-site

# Запустите скрипт настройки среды разработки
./dev_setup.sh
```

### Production сборка
```bash
# Соберите Vue приложение и интегрируйте с Django
./build_frontend.sh

# Запустите Django сервер
cd backend
source ../venv/bin/activate
python3 manage.py runserver
```

Приложение будет доступно по адресу: http://127.0.0.1:8000

## 🛠️ Режимы работы

### 1. Режим разработки (Development)
В режиме разработки Vue и Django работают на разных портах с проксированием API:

**Терминал 1 - Django API:**
```bash
cd backend
source ../venv/bin/activate
python3 manage.py runserver
# Доступно на http://127.0.0.1:8000
```

**Терминал 2 - Vue Frontend:**
```bash
cd frontend
npm run dev
# Доступно на http://127.0.0.1:8080
```

### 2. Production режим
В production режиме Django обслуживает собранное Vue приложение:

```bash
# Сборка Vue приложения
cd frontend
npm run build:django

# Или используйте удобный скрипт
./build_frontend.sh

# Запуск Django
cd backend
source ../venv/bin/activate
python3 manage.py runserver
# Всё доступно на http://127.0.0.1:8000
```

## 📁 Структура проекта

```
rugby-site/
├── frontend/                 # Vue.js приложение
│   ├── src/                 # Исходники Vue
│   ├── dist/                # Временная сборка (игнорируется)
│   ├── vite.config.js       # Конфигурация Vite
│   └── package.json
├── backend/                 # Django приложение
│   ├── static/              # Статические файлы
│   │   └── frontend/        # 🎯 Сюда собирается Vue приложение
│   ├── staticfiles/         # Собранная статика Django
│   ├── rugby_backend/       # Настройки Django
│   └── manage.py
├── venv/                    # Виртуальное окружение Python
├── build_frontend.sh        # 🚀 Скрипт production сборки
├── dev_setup.sh            # 🛠️ Скрипт настройки среды разработки
└── requirements.txt
```

## ⚙️ Как это работает

### 1. Конфигурация Vite (frontend/vite.config.js)
```javascript
export default defineConfig({
  base: process.env.NODE_ENV === 'production' ? '/static/frontend/' : '/',
  build: {
    outDir: '../backend/static/frontend',  // Сборка прямо в Django
    // ...
  }
})
```

### 2. Настройки Django (backend/rugby_backend/settings.py)
```python
# Статические файлы
STATIC_URL = '/static/'
STATICFILES_DIRS = [
    BASE_DIR / 'static',  # Включаем директорию с Vue приложением
]

# Шаблоны
TEMPLATES = [{
    'DIRS': [
        BASE_DIR / 'static/frontend',  # Для index.html Vue приложения
    ],
}]
```

### 3. URL маршрутизация (backend/rugby_backend/urls.py)
```python
urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/', include('api.urls')),
    # Vue.js приложение обслуживает все остальные маршруты
    path('', TemplateView.as_view(template_name='index.html'), name='vue_app'),
]

# Обслуживание статических файлов в development
if settings.DEBUG:
    from django.contrib.staticfiles.urls import staticfiles_urlpatterns
    urlpatterns += staticfiles_urlpatterns()
```

## 🔧 Команды

### Vue команды
```bash
cd frontend
npm run dev          # Режим разработки
npm run build        # Обычная сборка
npm run build:django # Сборка для Django с сообщением
npm run preview      # Предпросмотр сборки
```

### Django команды
```bash
cd backend
source ../venv/bin/activate
python3 manage.py runserver      # Запуск сервера
python3 manage.py collectstatic  # Сбор статики
python3 manage.py migrate        # Применение миграций
```

### Удобные скрипты
```bash
./dev_setup.sh       # Первоначальная настройка
./build_frontend.sh  # Production сборка и запуск
```

## 🐛 Устранение проблем

### Проблема: Статические файлы не загружаются
**Решение:**
1. Убедитесь что Vue приложение собрано: `./build_frontend.sh`
2. Проверьте что Django статика собрана: `python3 manage.py collectstatic`
3. Убедитесь что в `settings.py` правильно настроены `STATICFILES_DIRS`

### Проблема: API запросы не работают
**Решение:**
1. В режиме разработки: проверьте настройки proxy в `vite.config.js`
2. В production: убедитесь что Django API доступно на том же домене

### Проблема: Vue маршруты не работают
**Решение:**
1. Убедитесь что в Django URLs есть fallback на Vue приложение
2. Проверьте что `index.html` доступен в `TEMPLATES['DIRS']`

## 📝 Дополнительные заметки

- Vue приложение использует History API роутинг
- Django обслуживает API на `/api/` и админку на `/admin/`
- Все остальные маршруты обрабатываются Vue.js
- В production все статические файлы обслуживаются Django
- CORS настроен для разработки на портах 5173, 3000, 8080

## 🎯 Рекомендации

1. **Для разработки**: используйте режим разработки с двумя серверами
2. **Для тестирования**: используйте `./build_frontend.sh`
3. **Для деплоя**: настройте веб-сервер (nginx) для обслуживания статики
4. **Для CI/CD**: добавьте `./build_frontend.sh` в пайплайн сборки
