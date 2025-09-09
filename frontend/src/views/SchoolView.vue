<template>
    <section class="hero-section">
        <!-- Header Navigation -->
        <header class="navbar-overlay">
            <div class="content-container">
                <!-- Desktop Navigation -->
                <nav class="d-flex justify-content-between align-items-start header-nav d-none d-md-flex">
                    <!-- Left Logo - Витязь -->
                    <div class="logo-left" @click="goToHome">
                            <img src="@/assets/logo-vityaz.svg" alt="Витязь" class="logo-vityaz">
                    </div>

                    <!-- Center Navigation -->
                    <div class="nav-right_wrapper d-flex align-items-center">
                        <div class="header-nav_wrapper d-flex gap-5 align-items-start"
                            style="margin-right: 55px;transform: translateY(6px);">
                            <div class="header-nav_item dropdown-container p-0" ref="dropdownRef">
                                <div class="p-0 school-link">
                                    <a href="#" class="header-nav_link p-0" @click.prevent="toggleDropdown">
                                        команда
                                        <span class="dropdown-icon" :class="{ 'open': isDropdownOpen }">
                                            <svg width="12" height="8" viewBox="0 0 12 8" fill="none"
                                                xmlns="http://www.w3.org/2000/svg">
                                                <path d="M1 1.5L6 6.5L11 1.5" stroke="currentColor" stroke-width="1.5"
                                                    stroke-linecap="round" stroke-linejoin="round" />
                                            </svg>
                                        </span>
                                    </a>
                                </div>

                                <!-- Dropdown Menu -->
                                <div class="dropdown-menu-custom" :class="{ 'show': isDropdownOpen }"
                                    @click.stop="$event.preventDefault()">
                                    <ul class="dropdown-list">
                                        <li><a href="#" class="dropdown-link" @click.prevent="goToTeam">состав</a></li>
                                        <li><a href="#" class="dropdown-link"
                                                @click.prevent="goToSchedule">тренировки</a></li>
                                        <li><a href="#" class="dropdown-link" @click.prevent="goToTrophies">зал
                                                славы</a></li>
                                    </ul>
                                </div>
                            </div>
                            <div class="header-nav_item p-0">
                                <a href="#" class="p-0 school-link" @click.prevent="scrollToMatches">матчи</a>
                            </div>
                            <div class="header-nav_item p-0">
                                <a href="#" class="p-0 school-link" @click.prevent="scrollToSponsors">спонсоры</a>
                            </div>
                            <div class="header-nav_item p-0 text-left">
                                <a class="p-0 school-link" href="#" @click.prevent="goToSchool">
                                    <span class="school-line" style="color: #fff;font-size: 12px;font-weight: 500;line-height: 14px;text-decoration: none;text-transform: uppercase;letter-spacing: 0.7px;">детское</span>
                                    <span class="school-line" style="color: #fff;font-size: 12px;font-weight: 500;line-height: 14px;text-decoration: none;text-transform: uppercase;letter-spacing: 0.7px;">регби</span>
                                </a>
                            </div>
                        </div>
                        <div class="icon-wrapper d-flex gap-3" style="margin-right: 45px;">
                            <div class="header-icon">
                                <a href="https://t.me/rugbyprm" target="_blank" rel="noopener noreferrer">
                                    <img src="@/assets/footer-icon_tg.svg" alt="телеграм">
                                </a>
                            </div>
                            <div class="header-icon">
                                <a href="https://vk.com/vityaz_rugby" target="_blank" rel="noopener noreferrer">
                                    <img src="@/assets/footer-icon_vk.svg" alt="вконтакте">
                                </a>
                            </div>
                            <div class="header-icon">
                                <a href="mailto:region59@rugby.ru" target="_blank" rel="noopener noreferrer">
                                    <img src="@/assets/footer-icon_mail.svg" alt="почта">
                                </a>
                            </div>
                        </div>
                        <div class="logo-right">
                            <img src="@/assets/logo-regby-permskiy-krai.svg" alt="Регби Пермского края"
                                style="width: 135px;" class="logo-regby">
                        </div>
                    </div>
                </nav>

                <!-- Mobile Navigation -->
                <nav class="mobile-header-nav d-flex d-md-none">
                    <!-- Top Row: Logos -->
                    <div class="mobile-top-row d-flex justify-content-between align-items-center w-100 mb-3">
                        <div class="mobile-logo-left">
                            <img src="@/assets/logo-vityaz_mobile.svg" alt="Витязь" class="mobile-logo-vityaz">
                        </div>
                        <div class="mobile-logo-right">
                            <img src="@/assets/logo-regby-permskiy-krai.svg" alt="Регби Пермского края"
                                class="mobile-logo-regby">
                        </div>
                    </div>

                    <!-- Bottom Row: Social Icons + Burger -->
                    <div class="mobile-bottom-row d-flex justify-content-between align-items-end w-100">
                        <!-- Social Icons -->
                        <div class="mobile-social-icons d-flex flex-column gap-3">
                            <a href="https://t.me/rugbyprm" target="_blank" rel="noopener noreferrer"
                                class="mobile-social-link">
                                <img src="@/assets/footer-icon_tg.svg" alt="телеграм" class="mobile-social-icon">
                            </a>
                            <a href="https://vk.com/vityaz_rugby" target="_blank" rel="noopener noreferrer"
                                class="mobile-social-link">
                                <img src="@/assets/footer-icon_vk.svg" alt="вконтакте" class="mobile-social-icon">
                            </a>
                            <a href="mailto:region59@rugby.ru" target="_blank" rel="noopener noreferrer"
                                class="mobile-social-link">
                                <img src="@/assets/footer-icon_mail.svg" alt="почта" class="mobile-social-icon">
                            </a>
                        </div>

                        <!-- Burger Menu -->
                        <div class="mobile-burger-menu" ref="mobileBurgerRef">
                            <button @click="toggleMobileMenu" class="burger-button"
                                :class="{ 'active': isMobileMenuOpen }">
                                <span class="burger-line"></span>
                                <span class="burger-line"></span>
                                <span class="burger-line"></span>
                            </button>

                            <!-- Mobile Navigation Menu -->
                            <div class="mobile-nav-menu" :class="{ 'show': isMobileMenuOpen }">
                                <ul class="mobile-nav-list">
                                    <li><a href="#" @click.prevent="goToTrophiesMobile" class="mobile-nav-link">зал
                                            славы</a></li>
                                    <li><a href="#" @click.prevent="goToScheduleMobile"
                                            class="mobile-nav-link">тренировки</a></li>
                                    <li><a href="#" @click.prevent="goToTeamMobile" class="mobile-nav-link">команда</a>
                                    </li>
                                    <li><a href="#" @click.prevent="scrollToMatchesMobile"
                                            class="mobile-nav-link">матчи</a></li>
                                    <li><a href="#" @click.prevent="scrollToSponsorsMobile"
                                            class="mobile-nav-link">спонсоры</a></li>
                                    <li><a href="#" @click.prevent="goToSchoolMobile"
                                            class="mobile-nav-link">детское<br>регби</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </nav>
            </div>
        </header>

        <!-- Hero Background Image -->
        <div class="hero-image">
            <img src="/images/hero-images-2.jpg" alt="Команда Витязь" class="hero-bg">
        </div>
    </section>
    <section class="match-day">
        <div class="content-container">
                        <div class="section-header-wrapper mb-5">
                <div class="section-item section-item--left">
                    ДЕТСКОЕ
                </div>
                <div class="section-title">
                    ШКОЛЫ РЕГБИ
                </div>
                <div class="section-item section-item--right">
                    РЕГБИ
                </div>
            </div>
        </div>
        <div class="school-wrapper">
            <div class="schools-container">
                <!-- Левая колонка -->
                <div class="schools-column schools-column--left">
                    <template v-for="school in leftColumnSchools" :key="school.id">
                        <div class="school-item">
                            <h3 class="school-name">{{ school.name }}</h3>
                            <div class="school-locations">
                                <template v-for="location in school.location_set" :key="location.id">
                                    <div class="school-location">
                                        <template v-if="parseLocationInfo(location.info).address">
                                            <p class="location-address">{{ parseLocationInfo(location.info).address }}</p>
                                        </template>
                                        <template v-if="parseLocationInfo(location.info).contact">
                                            <p class="location-contact">{{ parseLocationInfo(location.info).contact }}</p>
                                        </template>
                                        <template v-if="parseLocationInfo(location.info).phone">
                                            <p class="location-phone">{{ parseLocationInfo(location.info).phone }}</p>
                                        </template>
                                    </div>
                                </template>
                            </div>
                        </div>
                    </template>
                </div>

                <!-- Правая колонка -->
                <div class="schools-column schools-column--right">
                    <template v-for="school in rightColumnSchools" :key="school.id">
                        <div class="school-item">
                            <h3 class="school-name">{{ school.name }}</h3>
                            <div class="school-locations">
                                <template v-for="location in school.location_set" :key="location.id">
                                    <div class="school-location">
                                        <template v-if="parseLocationInfo(location.info).address">
                                            <p class="location-address">{{ parseLocationInfo(location.info).address }}</p>
                                        </template>
                                        <template v-if="parseLocationInfo(location.info).contact">
                                            <p class="location-contact">{{ parseLocationInfo(location.info).contact }}</p>
                                        </template>
                                        <template v-if="parseLocationInfo(location.info).phone">
                                            <p class="location-phone">{{ parseLocationInfo(location.info).phone }}</p>
                                        </template>
                                    </div>
                                </template>
                            </div>
                        </div>
                    </template>
                </div>
            </div>
        </div>
    </section>
    <div class="news-item-full" style="margin-bottom: 150px;">
        <div class="news-item_photo">
            <img class="news-item_photo-img" src="/images/children_full.png" alt="Детская сборная регби">
        </div>
        <div class="news-item_description" style="padding-top: 50px; padding-right: 80px;">
            <div class="news-item_header">
                <div class="news-item_title" style="color: #fff;">
                    Детско-юношеские команды Федерации регби Пермского края
                </div>
            </div>
            <div class="news-item_text" style="color: #fff; max-width: 440px;">
                В сезоне 2025/2026 детско-юношеские команды Пермского края активно участвуют в региональных,
                межрегиональных и всероссийских турнирах и первенствах в дисциплине регби и тэг-регби. <br>
                Сборные команды Пермского края регулярно становятся победителями и призерами всероссийских соревнований
                по регби и тэг-регби. Федерация регби Пермского края поддерживает детско-юношеские команды,
                организовывает сборы, мастер классы и выездные мероприятия. Команды Пермского края обеспечиваются
                экипировкой и спортивным снаряжением. Все <br> детско-юношеские секции по регби и тэг-регби на территории
                Пермского края предоставляют возможность тренироваться бесплатно.

            </div>
        </div>
    </div>

    <AppFooter />
</template>

<script setup>
import { ref, onMounted, onUnmounted, computed } from 'vue'
import { useRouter } from 'vue-router'
import MatchCarousel from '@/components/MatchCarousel.vue'
import AppFooter from '@/components/AppFooter.vue'
import { Schools } from '@/api'

const schoolsList = ref([])

const getSchoolsList = async () => {
    const response = await Schools.getList()
    schoolsList.value = response
}

// Вычисляемые свойства для разделения школ на колонки
const leftColumnSchools = computed(() => {
    return schoolsList.value.filter(school => school.order % 2 === 1)
})

const rightColumnSchools = computed(() => {
    return schoolsList.value.filter(school => school.order % 2 === 0)
})

// Функция для парсинга информации о локации
const parseLocationInfo = (info) => {
    if (!info) return { address: '', contact: '', phone: '' }

    const lines = info.split('\r\n').filter(line => line.trim())
    const result = { address: '', contact: '', phone: '' }

    lines.forEach(line => {
        const trimmedLine = line.trim()
        // Проверяем, является ли строка телефоном (содержит +7 или 8)
        if (trimmedLine.match(/^[+]?[78]/) || trimmedLine.match(/^\d{3}/)) {
            result.phone = trimmedLine
        }
        // Проверяем, является ли строка адресом (содержит г., мкр., район и т.д.)
        else if (trimmedLine.includes('г.') || trimmedLine.includes('мкр.') ||
                 trimmedLine.includes('район') || trimmedLine.includes('с.') ||
                 trimmedLine.includes('п.') || trimmedLine.includes('д.')) {
            result.address = trimmedLine
        }
        // Остальное считаем контактом
        else {
            result.contact = trimmedLine
        }
    })

    return result
}
// Router
const router = useRouter()

// Dropdown state
const isDropdownOpen = ref(false)
const dropdownRef = ref(null)

// Mobile menu state
const isMobileMenuOpen = ref(false)
const mobileBurgerRef = ref(null)


// Toggle dropdown function
const toggleDropdown = (event) => {
    event.stopPropagation()
    isDropdownOpen.value = !isDropdownOpen.value
}

// Close dropdown when clicking outside
const closeDropdown = (event) => {
    if (dropdownRef.value && !dropdownRef.value.contains(event.target)) {
        isDropdownOpen.value = false
    }
}

// Mobile menu functions
const toggleMobileMenu = () => {
    isMobileMenuOpen.value = !isMobileMenuOpen.value
}

// Функция плавной прокрутки к секции матчей
const scrollToMatches = () => {
    router.push('/#matches-section')
}

// Функция плавной прокрутки к секции спонсоров
const scrollToSponsors = () => {
    router.push('/#sponsors-section')
}

// Функция перехода к школе регби
const goToSchool = () => {
    router.push('/school')
}

// Функция перехода к команде
const goToTeam = () => {
    isDropdownOpen.value = false
    router.push('/team')
}

// Функция перехода к трофеям
const goToTrophies = () => {
    isDropdownOpen.value = false
    router.push('/trophies')
}

// Функция перехода к расписанию
const goToSchedule = () => {
    isDropdownOpen.value = false
    router.push('/schedule')
}

// Функция перехода на главную страницу
const goToHome = () => {
    router.push('/')
}

// Mobile navigation functions
const goToTrophiesMobile = () => {
    isMobileMenuOpen.value = false
    router.push('/trophies')
}

const goToTeamMobile = () => {
    isMobileMenuOpen.value = false
    router.push('/team')
}

const goToScheduleMobile = () => {
    isMobileMenuOpen.value = false
    router.push('/schedule')
}

const scrollToMatchesMobile = () => {
    isMobileMenuOpen.value = false
    router.push('/#matches-section')
}

const scrollToSponsorsMobile = () => {
    isMobileMenuOpen.value = false
    router.push('/#sponsors-section')
}

const goToSchoolMobile = () => {
    isMobileMenuOpen.value = false
    router.push('/school')
}




// Глобальный обработчик клика для закрытия меню
const handleGlobalClick = (event) => {
    closeDropdown(event)

    // Закрываем мобильное меню при клике вне его
    if (mobileBurgerRef.value && !mobileBurgerRef.value.contains(event.target)) {
        isMobileMenuOpen.value = false
    }
}

// Функция для установки правильной высоты viewport на мобильных устройствах
const setVhProperty = () => {
    const vh = window.innerHeight * 0.01
    document.documentElement.style.setProperty('--vh', `${vh}px`)
}

// Добавляем и удаляем глобальный обработчик клика
onMounted(async () => {
    document.addEventListener('click', handleGlobalClick)

    // Устанавливаем правильную высоту viewport
    setVhProperty()
    window.addEventListener('resize', setVhProperty)

    // Загружаем данные о школах
    await getSchoolsList()
})

onUnmounted(() => {
    document.removeEventListener('click', handleGlobalClick)
    window.removeEventListener('resize', setVhProperty)
})
</script>

<style>
.news-item_photo{
    height: 615px;
    max-height: 615px;
}

.news-item_photo-img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    object-position: center;
}
.news-item-full {
    background-color: #28223C;
    display: flex;
    width: 100%;
    gap: 50px;
}
.news-item_photo,
.news-item_description {
    width: calc(50% - 25px);
    flex: 0 0 calc(50% - 25px);
}
.news-item_title {
    color: #28223C;
    font-size: 22px;
    font-weight: 600;
    line-height: 26px;
    max-width: 430px;
}
.news-item_text {
    margin-top: 30px;
    color: #28223C;
    font-size: 16px;
    line-height: 25px;
}
.footer-title_sponsors {
    margin-bottom: 33px;
}

.footer-title_contacts {
    margin-bottom: 20px;
}

.contact-item_text {
    margin-left: 14px;
}

.contact-link {
    color: white;
    text-decoration: none;
    transition: color 0.3s ease;
}

.contact-link:hover {
    color: #ED1B26;
}

.header-icon a {
    display: inline-block;
    transition: transform 0.3s ease;
}

.header-icon a:hover {
    transform: scale(1.1);
}

.footer-container {
    margin: 0 auto;
    width: 1280px;
    max-width: 1280px;
    padding-top: 75px;
    padding-bottom: 75px;
}

.footer-wrapper {
    background-color: #28223C;
    color: white;
}

.container-logo {
    display: flex;
    justify-content: space-around;
}

#app {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

/* Global reset for full width hero */
body {
    margin: 0 !important;
    padding: 0 !important;
    overflow-x: hidden;
}

html {
    margin: 0;
    padding: 0;
}
</style>

<style scoped>
/* Rossika font загружен глобально в main.css */

.section-item {
    color: #28223C;
    font-size: 14px;
}

.section-title {
    color: #28223C;
    font-size: 57px;
    font-family: 'Rossika';
    letter-spacing: -0.02em;
}

.header-nav {
    padding-top: 40px;
}

/* Left Logo Section */
.logo-left {
    display: flex;
    color: white;
}

.logo-vityaz {
    width: 227px;
    height: auto;
    margin-top: 38px;
    filter: brightness(0) invert(1);
}
.logo-vityaz:hover {
    cursor: pointer;
}

/* Hero Section */
.hero-section {
    position: relative;
    width: 100%;
    height: 100vh;
    height: calc(var(--vh, 1vh) * 100); /* Fallback для старых браузеров */
    height: 100dvh; /* Современное свойство для мобильных устройств */
    overflow: hidden;
}

.hero-image {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
}

.hero-bg {
    width: 100%;
    height: 100%;
    object-fit: cover;
    object-position: center;
}

/* Content container */
.content-container {
    width: 100%;
    max-width: 1280px;
    margin: 0 auto;
    position: relative;
    overflow: visible;
}

/* Header Overlay */
.navbar-overlay {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    z-index: 10;
    width: 100%;
    background: linear-gradient(180deg, rgba(0, 0, 0, 0.8) 0%, rgba(0, 0, 0, 0.4) 50%, transparent 100%);
}

/* Left Logo Section */
.logo-left {
    display: flex;
    color: white;
}

.header-nav_item a {
    color: #fff;
    font-size: 12px;
    font-weight: 500;
    line-height: 14px;
    text-decoration: none;
    text-transform: uppercase;
    letter-spacing: 0.7px;
}

.header-nav_link {
    color: #fff;
    font-size: 12px;
    font-weight: 500;
    line-height: 19.2px;
    text-decoration: none;
    text-transform: uppercase;
    display: inline-flex;
    align-items: center;
    gap: 8px;
    letter-spacing: 0.7px;
}

.school-link {
    display: flex;
    flex-direction: column;
    gap: 0px;
    line-height: 1;
    align-items: flex-start;
}

.school-line {
    display: block;
}

.header-icon a {
    display: inline-block;
    transition: transform 0.3s ease;
}

.header-icon a:hover {
    transform: scale(1.1);
}

/* Dropdown Container */
.dropdown-container {
    display: flex;
    align-items: center;
    gap: 10px;
    position: relative;
}

.dropdown-icon {
    display: inline-flex;
    align-items: center;
    transition: transform 0.3s ease;
    opacity: 1;
    position: relative;
    top: 1px;
}

.dropdown-icon svg {
    stroke: currentColor;
    transition: transform 0.3s ease;
}

/* Dropdown icon animation */
.dropdown-icon.open {
    transform: rotate(180deg);
}

/* Dropdown Menu */
.dropdown-menu-custom {
    position: absolute;
    top: 100%;
    left: 0;
    margin-top: 15px;
    min-width: 200px;
    opacity: 0;
    visibility: hidden;
    transform: translateY(-10px);
    transition: all 0.3s ease;
    z-index: 1000;
}

.dropdown-menu-custom.show {
    opacity: 1;
    visibility: visible;
    transform: translateY(0);
}

.dropdown-list {
    list-style: none;
    margin: 0;
    padding: 0;
}

.dropdown-list li {
    margin: 8px 0;
}

.dropdown-link {
    display: block;
    color: white;
    text-decoration: none;
    font-size: 14px;
    font-weight: 400;
    letter-spacing: 0.5px;
    line-height: 1.2;
    text-transform: uppercase;
    transition: color 0.3s ease;
}

.dropdown-link:hover {
    color: #ccc;
}

/* Right Logo */
.logo-right {
    display: flex;
    align-items: center;
}

.logo-regby {
    height: 80px;
    width: auto;
}

/* Responsive Design */
@media (max-width: 767.98px) {
    .header-nav {
        padding-top: 20px;
        padding-left: 20px;
        padding-right: 20px;
    }

    .content-container {
        padding: 0 20px;
    }

    /* Скрываем десктопную навигацию полностью на мобильных */
    .header-nav.d-none.d-md-flex {
        display: none !important;
    }

    /* Показываем мобильную навигацию */
    .mobile-header-nav.d-flex.d-md-none {
        display: flex !important;
    }

    /* Стили для мобильной навигации */
    .mobile-header-nav {
        flex-direction: column;
        padding: 20px;
        position: relative;
        height: 100vh;
        height: calc(var(--vh, 1vh) * 100); /* Fallback для старых браузеров */
        height: 100dvh; /* Современное свойство для мобильных устройств */
    }

    .mobile-top-row {
        margin-bottom: 20px;
    }

    .mobile-logo-vityaz {
        width: 104px;
        height: auto;
    }

    .mobile-logo-regby {
        height: 74px;
        width: auto;
    }

    .mobile-bottom-row {
        position: absolute;
        bottom: 50px;
        left: 0;
        right: 0;
        padding: 0 30px;
        display: flex;
        justify-content: space-between;
        align-items: flex-end;
    }

    .mobile-social-icons {
        display: flex;
        flex-direction: column;
        gap: 20px;
    }

    .mobile-social-icon {
        width: 20px;
        height: 20px;
        transition: transform 0.3s ease;
    }

    .mobile-social-link:hover .mobile-social-icon {
        transform: scale(1.1);
    }

    /* Burger Menu */
    .mobile-burger-menu {
        position: relative;
    }

    .burger-button {
        background: none;
        border: none;
        cursor: pointer;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        width: 32px;
        height: 25px;
        position: relative;
    }

    .burger-line {
        width: 24px;
        height: 2px;
        background-color: white;
        transition: all 0.3s ease;
        position: absolute;
        border-radius: 1px;
    }

    .burger-line:nth-child(1) {
        transform: translateY(-6px);
    }

    .burger-line:nth-child(2) {
        transform: translateY(0);
    }

    .burger-line:nth-child(3) {
        transform: translateY(6px);
    }

    .burger-button.active .burger-line:nth-child(1) {
        transform: rotate(45deg);
    }

    .burger-button.active .burger-line:nth-child(2) {
        opacity: 0;
    }

    .burger-button.active .burger-line:nth-child(3) {
        transform: rotate(-45deg);
    }

    /* Mobile Navigation Menu */
    .mobile-nav-menu {
        position: absolute;
        bottom: 100%;
        right: 0;
        opacity: 0;
        visibility: hidden;
        transform: translateY(10px);
        transition: all 0.3s ease;
        z-index: 9999;
        margin-bottom: 10px;
        min-width: 160px;
    }

    .mobile-nav-menu.show {
        opacity: 1;
        visibility: visible;
        transform: translateY(0);
    }

    .mobile-nav-list {
        list-style: none;
        margin: 0;
        padding: 0;
        display: flex;
        flex-direction: column;
        gap: 15px;
    }

    .mobile-nav-list li {
        margin: 0;
    }

    .mobile-nav-link {
        display: block;
        color: white;
        text-decoration: none;
        font-size: 16px;
        font-weight: 400;
        text-align: right;
        transition: all 0.3s ease;
        padding: 0;
    }

    .mobile-nav-link:hover {
        color: #ED1B26;
    }
}

/* Match day section */
.match-day {
    width: 100%;
    margin-top: 60px;
}

.event-section {
    width: 100%;
    margin-top: 100px;
    margin-bottom: 100px;
    position: relative;
    overflow: visible;
}

/* News Section Styles */
.news-container {
    display: flex;
    flex-direction: column;
    gap: 60px;
    width: 100%;
}

.news-item {
    display: flex;
    gap: 100px;
    align-items: flex-start;
    width: 100%;
}

.news-photo {
    flex: 0 0 590px;
    height: 278px;
    overflow: hidden;
}

.news-image {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: transform 0.3s ease;
}

.news-item:hover .news-image {
    transform: scale(1.05);
}

.news-description {
    flex: 1;
    display: flex;
    flex-direction: column;
    gap: 20px;
    padding: 20px 0;
}

.news-title {
    font-size: 22px;
    font-weight: 700;
    color: #28223C;
    line-height: 1.2;
    letter-spacing: -0.01em;
}

.news-text {
    font-size: 16px;
    color: #666;
    line-height: 1.6;
    font-weight: 400;
}

/* Responsive Design for News */
@media (max-width: 1024px) {
    .news-item {
        flex-direction: column !important;
        gap: 25px;
    }

    .news-photo {
        flex: none;
        width: 100%;
        height: 250px;
    }

    .news-title {
        font-size: 28px;
    }

    .news-text {
        font-size: 16px;
    }
}

@media (max-width: 768px) {
    .news-container {
        gap: 40px;
    }

    .news-photo {
        height: 200px;
    }

    .news-title {
        font-size: 24px;
    }

    .news-text {
        font-size: 15px;
    }

    .news-description {
        gap: 15px;
        padding: 10px 0;
    }
}

/* Mobile Styles */
@media (max-width: 767.98px) {
    .hero-section {
        height: 100vh;
        height: calc(var(--vh, 1vh) * 100); /* Fallback для старых браузеров */
        height: 100dvh; /* Современное свойство для мобильных устройств */
    }

    .content-container {
        padding: 0 20px;
    }

    /* Mobile Header Navigation */
    .mobile-header-nav {
        flex-direction: column;
        padding: 20px;
        position: relative;
        height: 100vh;
        height: calc(var(--vh, 1vh) * 100); /* Fallback для старых браузеров */
        height: 100dvh; /* Современное свойство для мобильных устройств */
    }

    .mobile-top-row {
        margin-bottom: 20px;
    }

    .mobile-logo-vityaz {
        width: 104px;
        height: auto;
    }

    .mobile-logo-regby {
        height: 74px;
        width: auto;
    }

    .mobile-bottom-row {
        position: absolute;
        bottom: 50px;
        left: 0;
        right: 0;
        padding: 0 30px;
        display: flex;
        justify-content: space-between;
        align-items: flex-end;
    }

    .mobile-social-icons {
        display: flex;
        flex-direction: column;
        gap: 20px;
    }

    .mobile-social-icon {
        width: 20px;
        height: 20px;
        transition: transform 0.3s ease;
    }

    .mobile-social-link:hover .mobile-social-icon {
        transform: scale(1.1);
    }

    /* Burger Menu */
    .mobile-burger-menu {
        position: relative;
    }

    .burger-button {
        background: none;
        border: none;
        cursor: pointer;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        width: 32px;
        height: 25px;
        position: relative;
    }

    .burger-line {
        width: 24px;
        height: 2px;
        background-color: white;
        transition: all 0.3s ease;
        position: absolute;
        border-radius: 1px;
    }

    .burger-line:nth-child(1) {
        transform: translateY(-6px);
    }

    .burger-line:nth-child(2) {
        transform: translateY(0);
    }

    .burger-line:nth-child(3) {
        transform: translateY(6px);
    }

    .burger-button.active .burger-line:nth-child(1) {
        transform: rotate(45deg);
    }

    .burger-button.active .burger-line:nth-child(2) {
        opacity: 0;
    }

    .burger-button.active .burger-line:nth-child(3) {
        transform: rotate(-45deg);
    }

    /* Mobile Navigation Menu */
    .mobile-nav-menu {
        position: absolute;
        bottom: 100%;
        right: 0;
        opacity: 0;
        visibility: hidden;
        transform: translateY(10px);
        transition: all 0.3s ease;
        z-index: 9999;
        margin-bottom: 10px;
        min-width: 160px;
    }

    .mobile-nav-menu.show {
        opacity: 1;
        visibility: visible;
        transform: translateY(0);
    }

    .mobile-nav-list {
        list-style: none;
        margin: 0;
        padding: 0;
        display: flex;
        flex-direction: column;
        gap: 15px;
    }

    .mobile-nav-list li {
        margin: 0;
    }

    .mobile-nav-link {
        display: block;
        color: white;
        text-decoration: none;
        font-size: 16px;
        font-weight: 400;
        text-align: right;
        transition: all 0.3s ease;
        padding: 0;
    }

    .mobile-nav-link:hover {
        color: #ED1B26;
    }

    /* Section titles mobile */
    .section-title {
        font-size: 40px;
    }

    .section-item {
        font-size: 16px;
    }

    .section-header-wrapper {
        margin-bottom: 40px !important;
        display: flex !important;
        justify-content: center !important;
        grid-template-columns: none !important;
    }

    /* Скрываем боковые элементы на мобильных */
    .section-item--left,
    .section-item--right {
        display: none !important;
    }

    /* Mobile Schools List */
    .school-wrapper {
        padding: 30px 0 50px 0;
    }

    .schools-container {
        display: block;
        max-width: 100%;
        padding: 0 20px;
    }

    .schools-column {
        width: 100%;
        max-width: 100%;
        display: block;
        margin-bottom: 0;
    }

    .school-item {
        max-width: 100%;
        margin-bottom: 40px;
    }

    .school-item:last-child {
        border-bottom: none;
    }

    .school-name {
        font-size: 18px;
        margin-bottom: 15px;
        line-height: 1.2;
    }

    .location-address,
    .location-contact,
    .location-phone {
        font-size: 14px;
        line-height: 1.3;
    }

    .location-address {
        margin-bottom: 3px;
    }

    .location-contact {
        margin-bottom: 2px;
    }

    .location-phone {
        margin-bottom: 8px;
    }

    /* Mobile News Section */
    .news-item-full {
        flex-direction: column;
        margin-bottom: 0px !important;
        gap: 0;
    }

    .news-item_photo,
    .news-item_description {
        width: 100%;
        flex: none;
    }

    /* В мобильной версии меняем порядок: текст сверху, фото снизу */
    .news-item_description {
        order: 1;
        padding: 40px 30px 50px 30px !important;
    }

    .news-item_photo {
        order: 2;
        height: 294px;
    }

    .news-item_title {
        font-size: 18px !important;
        line-height: 1.11;
        margin-bottom: 20px;
        font-weight: 700;
    }

    .news-item_text {
        font-size: 14px !important;
        line-height: 1.43;
        max-width: none !important;
    }
}

/* Small Mobile Styles */
@media (max-width: 480px) {
    .header-nav {
        padding-top: 30px;
        padding-left: 15px;
        padding-right: 15px;
    }

    .content-container {
        padding: 0 15px;
    }

    .logo-vityaz-mobile {
        height: 120px;
    }

    .mobile-section-title {
        font-size: 32px;
    }

    .school-name {
        font-size: 16px;
    }

    .location-address,
    .location-contact,
    .location-phone {
        font-size: 13px;
    }

    .news-item_description {
        padding: 35px 15px !important;
    }

    .news-item_title {
        font-size: 18px !important;
        width: 250px;
    }

    .news-item_text {
        width: 250px;
        font-size: 13px !important;
    }
}

/* Arrow styles */
.last-news-item {
    position: relative;
}

.arrow-container {
    position: absolute;
    bottom: 20px;
    right: 20px;
    z-index: 10;
    cursor: pointer;
}

.arrow-icon {
    width: 26px;
    height: 16px;
    transition: transform 0.3s ease;
    fill: #28223C;
}

.arrow-container:hover .arrow-icon {
    transform: translateX(3px) scale(1.1);
}

/* News Animation Styles */
.news-item {
    transition: all 0.8s cubic-bezier(0.25, 0.46, 0.45, 0.94);
}

.news-hidden {
    opacity: 0;
    filter: blur(3px);
}

.news-hidden .news-photo {
    transform: scale(0.9);
}

.news-hidden .news-description {
    transform: translateY(30px);
}

.animate-in-left {
    animation: slideInLeft 0.8s cubic-bezier(0.25, 0.46, 0.45, 0.94) forwards;
}

.animate-in-right {
    animation: slideInRight 0.8s cubic-bezier(0.25, 0.46, 0.45, 0.94) forwards;
}

@keyframes slideInLeft {
    from {
        opacity: 0;
        transform: translateX(-100px);
        filter: blur(3px);
    }

    to {
        opacity: 1;
        transform: translateX(0);
        filter: blur(0);
    }
}

@keyframes slideInRight {
    from {
        opacity: 0;
        transform: translateX(100px);
        filter: blur(3px);
    }

    to {
        opacity: 1;
        transform: translateX(0);
        filter: blur(0);
    }
}

/* Дополнительные эффекты для фото и текста */
.news-photo {
    transition: transform 0.8s cubic-bezier(0.25, 0.46, 0.45, 0.94);
}

.news-description {
    transition: transform 0.8s cubic-bezier(0.25, 0.46, 0.45, 0.94);
}

.section-header-wrapper {
    display: grid;
    grid-template-columns: 1fr auto 1fr;
    align-items: center;
    height: 60px;
}

.section-item--left {
    justify-self: start;
}

.section-title {
    justify-self: center;
}

.section-item--right {
    justify-self: end;
}

/* Schools Section */
.school-wrapper {
    background-color: #FFFFFF;
    padding: 60px 0 80px 0;
    width: 100%;
}

.schools-container {
    max-width: 1280px;
    margin: 0 auto;
    display: grid;
    grid-template-columns: 390px 390px;
    column-gap: 270px;
    row-gap: 40px;
    justify-content: center;
    position: relative;
    padding-top: 20px;
    grid-template-rows: repeat(7, auto);
}

.schools-column {
    width: 390px;
    max-width: 390px;
    display: contents;
}

.schools-column--left {
    grid-column: 1;
}

.schools-column--right {
    grid-column: 2;
}

/* Позиционирование элементов по строкам для выравнивания */
.schools-column--left .school-item:nth-child(1) {
    grid-column: 1;
    grid-row: 1;
}

.schools-column--left .school-item:nth-child(2) {
    grid-column: 1;
    grid-row: 2;
}

.schools-column--left .school-item:nth-child(3) {
    grid-column: 1;
    grid-row: 3;
}

.schools-column--left .school-item:nth-child(4) {
    grid-column: 1;
    grid-row: 4;
}

.schools-column--left .school-item:nth-child(5) {
    grid-column: 1;
    grid-row: 5;
}

.schools-column--left .school-item:nth-child(6) {
    grid-column: 1;
    grid-row: 6;
}

.schools-column--left .school-item:nth-child(7) {
    grid-column: 1;
    grid-row: 7;
}

.schools-column--right .school-item:nth-child(1) {
    grid-column: 2;
    grid-row: 1;
}

.schools-column--right .school-item:nth-child(2) {
    grid-column: 2;
    grid-row: 2;
}

.schools-column--right .school-item:nth-child(3) {
    grid-column: 2;
    grid-row: 3;
}

.schools-column--right .school-item:nth-child(4) {
    grid-column: 2;
    grid-row: 4;
}

.schools-column--right .school-item:nth-child(5) {
    grid-column: 2;
    grid-row: 5;
}

.schools-column--right .school-item:nth-child(6) {
    grid-column: 2;
    grid-row: 6;
}

.school-item {
    max-width: 390px;
    margin-bottom: 0;
    display: flex;
    flex-direction: column;
    position: relative;
}

.school-name {
    color: #28223C;
    font-size: 20px;
    font-weight: 700;
    line-height: 1.3;
    margin: 0 0 20px 0;
    font-family: 'Golos Text', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
}

.school-locations {
    display: flex;
    flex-direction: column;
    gap: 15px;
}

.school-location {
    margin-bottom: 0;
}

.location-address {
    color: #28223C;
    font-size: 16px;
    font-weight: 400;
    line-height: 1.4;
    margin: 0 0 5px 0;
    font-family: 'Golos Text', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
}

.location-contact {
    color: #28223C;
    font-size: 16px;
    font-weight: 400;
    line-height: 1.4;
    margin: 0 0 3px 0;
    font-family: 'Golos Text', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
}

.location-phone {
    color: #28223C;
    font-size: 16px;
    font-weight: 400;
    line-height: 1.4;
    margin: 0 0 10px 0;
    font-family: 'Golos Text', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
}

/* Responsive Design for Schools */
@media (max-width: 1024px) {
    .schools-container {
        grid-template-columns: 1fr;
        grid-template-rows: auto;
        gap: 30px;
        justify-content: center;
        padding: 0 20px;
    }

    .schools-column {
        width: 100%;
        max-width: 600px;
        display: block;
        justify-self: center;
    }

    .schools-column--left,
    .schools-column--right {
        grid-column: 1;
    }

    /* Сброс позиционирования для мобильных */
    .schools-column--left .school-item,
    .schools-column--right .school-item {
        grid-column: unset;
        grid-row: unset;
    }
}

@media (max-width: 768px) {
    .school-wrapper {
        padding: 40px 0 60px 0;
    }

    .schools-container {
        padding: 0 20px;
    }

    .schools-column {
        max-width: 100%;
    }

    .school-name {
        font-size: 18px;
    }

    .location-address,
    .location-contact,
    .location-phone {
        font-size: 15px;
    }
}

@media (max-width: 480px) {
    .school-wrapper {
        padding: 30px 0 50px 0;
    }

    .schools-container {
        padding: 0 15px;
    }

    .school-name {
        font-size: 16px;
        margin-bottom: 15px;
    }

    .location-address,
    .location-contact,
    .location-phone {
        font-size: 14px;
    }

    .school-item {
        margin-bottom: 35px;
    }
}

.logo-link {
    display: inline-block;
    transition: transform 0.3s ease;
    cursor: pointer;
}

.logo-link:hover {
    transform: scale(1.05);
}

.logo-vityaz {
    display: block;
    max-width: 100%;
    height: auto;
}
</style>
