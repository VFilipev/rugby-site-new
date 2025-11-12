<template>
    <!-- Hero Section with Header Overlay -->
    <section class="hero-section">
        <!-- Header Navigation -->
        <header class="navbar-overlay">
            <div class="content-container">
                <!-- Desktop Navigation -->
                <nav class="d-flex justify-content-between align-items-start header-nav d-none d-md-flex">
                    <!-- Left Logo - Витязь -->
                    <div class="logo-left">
                        <img src="@/assets/logo-vityaz-old.svg" alt="Витязь" class="logo-vityaz">
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
                                    <span class="school-line"
                                        style="color: #fff;font-size: 12px;font-weight: 500;line-height: 14px;text-decoration: none;text-transform: uppercase;letter-spacing: 0.7px;">детское</span>
                                    <span class="school-line"
                                        style="color: #fff;font-size: 12px;font-weight: 500;line-height: 14px;text-decoration: none;text-transform: uppercase;letter-spacing: 0.7px;">регби</span>
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
                    <div class="mobile-top-row d-flex justify-content-between w-100 mb-3">
                        <div class="mobile-logo-left">
                            <img src="@/assets/logo-vityaz-old.svg" alt="Витязь" class="mobile-logo-vityaz">
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
                                    <li><a href="#" @click.prevent="goToMenTeamMobile" class="mobile-nav-link">мужской
                                            состав</a>
                                    </li>
                                    <li><a href="#" @click.prevent="goToWomenTeamMobile" class="mobile-nav-link">женский
                                            состав</a>
                                    </li>
                                    <li><a href="#" @click.prevent="goToSchoolMobile" class="mobile-nav-link">детское
                                            регби</a></li>
                                    <li><a href="#" @click.prevent="goToScheduleMobile"
                                            class="mobile-nav-link">тренировки</a></li>
                                    <li><a href="#" @click.prevent="goToTrophiesMobile" class="mobile-nav-link">зал
                                            славы</a></li>
                                    <li><a href="#" @click.prevent="scrollToSponsorsMobile"
                                            class="mobile-nav-link">спонсоры</a></li>
                                    <li><a href="#" @click.prevent="scrollToMatchesMobile"
                                            class="mobile-nav-link">матчи</a></li>

                                </ul>
                            </div>
                        </div>
                    </div>
                </nav>
            </div>
        </header>

        <!-- Hero Background Image -->
        <div class="hero-image">
            <!-- Placeholder Image - WebP с fallback -->
            <picture v-show="!isVideoReady" class="hero-placeholder">
                <source srcset="/video/first-frame.webp" type="image/webp">
                <img src="/video/first-frame.png" alt="Команда Витязь" class="hero-bg">
            </picture>
            <!-- Video -->
            <video v-show="isVideoReady" ref="heroVideo" class="hero-bg hero-video" autoplay muted loop playsinline
                preload="auto" @loadeddata="onVideoLoaded" @error="onVideoError" @canplay="onVideoCanPlay">
                <source src="/video/output.webm" type="video/webm">
                <!-- Fallback to image if video fails -->
                <img src="/video/first-frame.png" alt="Команда Витязь" class="hero-bg">
            </video>
        </div>
    </section>
    <section class="match-day" id="matches-section">
        <div class="content-container">
            <div class="section-header-wrapper">
                <div class="section-item section-item--left text-footer">
                    СЕЗОН
                </div>
                <div class="section-title">
                    МАТЧИ
                </div>
                <div class="section-item section-item--right">
                    2025
                </div>
            </div>
        </div>
        <MatchCarousel />
    </section>
    <section class="event-section">
        <div class="content-container">
            <div class="section-header-wrapper" style="margin-bottom: 115px;">
                <div class="section-item section-item--left">
                    СЕЗОН
                </div>
                <div class="section-title">
                    СОБЫТИЯ
                </div>
                <div class="section-item section-item--right">
                    2025
                </div>
            </div>
            <EventHomePage />
        </div>
    </section>
    <section class="sponsor-section" id="sponsors-section">
        <div class="content-container">
            <div class="section-header-wrapper" style="margin-bottom: 100px;">
                <div class="section-item section-item--left">
                    <a href="#" @click.prevent="openSponsorModal" class="sponsor-link">СТАТЬ СПОНСОРОМ</a>
                </div>
                <div class="section-title">
                    СПОНСОРЫ
                </div>
                <div class="section-item section-item--right">
                    ПЕРМСКИЙ КРАЙ
                </div>
            </div>
            <div class="container-logo" style="margin-bottom: 100px;">
                <!-- TODO ДОБАВИТЬ ДЛЯ СПОНСОРОВ API-->
                <!-- <template v-for="sponsor in sponsorsList" :key="sponsor.id">
                    <div class="logo-1">
                        <a :href="sponsor.url" target="_blank" rel="noopener noreferrer">
                            <img :src="sponsor.logo_url" :alt="sponsor.name" style="max-height: 114px">
                        </a>
                    </div>
                </template> -->

                <div class="logo-1">
                    <a href="https://www.eurochem.ru/" target="_blank" rel="noopener noreferrer" @click="openEuroChem">
                        <img src="@/assets/eurochem_logo.png" style="max-height: 114px" alt="Лого Еврохим">
                    </a>
                </div>
                <div class="logo-2">
                    <a href="https://rugby.ru/" target="_blank" rel="noopener noreferrer" @click="openRugbyRussia">
                        <img src="@/assets/regby_rossii_logo.svg" alt="Лого Пермский край">
                    </a>
                </div>
            </div>

            <!-- Кнопка "стать спонсором" для мобильной версии -->
            <div class="mobile-sponsor-btn" @click="openSponsorModal">
                СТАТЬ СПОНСОРОМ!
            </div>
        </div>
    </section>
    <AppFooter />

    <!-- Floating Button -->
    <FloatingButton />

    <!-- Модальное окно спонсора -->
    <SponsorModal :is-open="isSponsorModalOpen" @close="closeSponsorModal" />

</template>

<script setup>
import { ref, onMounted, onUnmounted } from 'vue'
import MatchCarousel from '@/components/MatchCarousel.vue'
import AppFooter from '@/components/AppFooter.vue'
import SponsorModal from '@/components/SponsorModal.vue'
import EventHomePage from '@/components/EventHomePage.vue'
import FloatingButton from '@/components/FloatingButton.vue'
import { useNavigation } from '@/composables/useNavigation'
import { Sponsors } from '@/api'

// Navigation composable
const {
    isDropdownOpen,
    dropdownRef,
    isMobileMenuOpen,
    mobileBurgerRef,
    toggleDropdown,
    toggleMobileMenu,
    goToTeam,
    goToTrophies,
    goToSchedule,
    goToSchool,
    goToEvents,
    scrollToMatches,
    scrollToSponsors,
    goToMenTeamMobile,
    goToWomenTeamMobile,
    scrollToMatchesMobile,
    scrollToSponsorsMobile,
    goToSchoolMobile,
    goToScheduleMobile,
    goToTrophiesMobile
} = useNavigation()

// Video state
const isVideoReady = ref(false)
const heroVideo = ref(null)

const sponsorsList = ref([])
const getSponsorsList = async () => {
    const response = await Sponsors.getList()
    sponsorsList.value = response
}
// Sponsor modal state
const isSponsorModalOpen = ref(false)



// Video functions
const onVideoLoaded = () => {

}

const onVideoCanPlay = () => {
    // Добавляем небольшую задержку для плавного перехода
    setTimeout(() => {
        isVideoReady.value = true
    }, 100)
}

const onVideoError = (error) => {
    console.warn('Video failed to load:', error)
    // Оставляем изображение если видео не загрузилось
    isVideoReady.value = false
}



// Sponsor modal functions
const openSponsorModal = () => {
    isSponsorModalOpen.value = true
}

const closeSponsorModal = () => {
    isSponsorModalOpen.value = false
}

// Функция принудительного открытия EuroChem в новом окне
const openEuroChem = (event) => {
    event.preventDefault()
    window.open('https://www.eurochem.ru/', '_blank', 'noopener,noreferrer')
}

// Функция принудительного открытия Rugby Russia в новом окне
const openRugbyRussia = (event) => {
    event.preventDefault()
    window.open('https://rugby.ru/', '_blank', 'noopener,noreferrer')
}


// Обработчик клавиши Escape для закрытия модального окна
const handleKeyDown = (event) => {
    if (event.key === 'Escape') {
        if (isSponsorModalOpen.value) {
            closeSponsorModal()
        }
    }
}

// Функция для установки правильной высоты viewport на мобильных устройствах
const setVhProperty = () => {
    const vh = window.innerHeight * 0.01
    document.documentElement.style.setProperty('--vh', `${vh}px`)
}

// Добавляем и удаляем глобальный обработчик клика
onMounted(() => {
    getSponsorsList()
    document.addEventListener('keydown', handleKeyDown)

    // Устанавливаем правильную высоту viewport
    setVhProperty()
    window.addEventListener('resize', setVhProperty)


    // Предзагружаем видео
    if (heroVideo.value) {
        heroVideo.value.load()
    }
})

onUnmounted(() => {
    document.removeEventListener('keydown', handleKeyDown)
    window.removeEventListener('resize', setVhProperty)
    // Восстанавливаем скролл при выходе с страницы
    document.body.style.overflow = 'auto'
})
</script>

<style scoped>
/* Header Navigation Styles */
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



.container-logo {
    display: flex;
    justify-content: space-around;
}

/* Скрываем мобильную кнопку на десктопе */
.mobile-sponsor-btn {
    display: none;
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

.section-item {
    font-size: 12px;
    color: #28223C;
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

/* Hero Section */
.hero-section {
    position: relative;
    width: 100%;
    height: 100vh;
    height: calc(var(--vh, 1vh) * 100);
    /* Fallback для старых браузеров */
    height: 100dvh;
    /* Современное свойство для мобильных устройств */
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

/* Hero placeholder and video transitions */
.hero-placeholder {
    transition: opacity 0.8s ease-in-out;
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
}

.hero-video {
    transition: opacity 0.8s ease-in-out;
    position: absolute;
    top: 0;
    left: 0;
}

/* Обеспечиваем плавное появление видео */
.hero-image {
    position: relative;
    background-color: #000;
    /* Предотвращаем белые вспышки */
}

.hero-image .hero-bg {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
}

/* Оптимизация для picture элемента */
.hero-placeholder img {
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

.logo-vityaz {
    width: 145px;
    height: auto;
    margin-top: 38px;
}

.club-name {
    line-height: 1.2;
}

.club-title {
    font-size: 1.8rem;
    font-weight: bold;
    letter-spacing: 2px;
    margin-bottom: -5px;
}

.club-subtitle {
    font-size: 0.9rem;
    font-weight: 300;
    letter-spacing: 1px;
    opacity: 0.9;
}

/* Center Navigation */
.center-nav {
    flex: 1;
    justify-content: right;
    margin: 0 40px;
}

.nav-list {
    gap: 40px;
}

.nav-link {
    color: white;
    text-decoration: none;
    font-size: 1.1rem;
    font-weight: 400;
    letter-spacing: 0.5px;
    display: inline-flex;
    align-items: center;
    gap: 15px;
    line-height: 1;
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

/* Mobile Styles */
@media (max-width: 991.98px) {
    .center-nav {
        display: none;
    }

    .logo-vityaz {
        width: 50px;
    }

    .club-title {
        font-size: 1.5rem;
    }

    .club-subtitle {
        font-size: 0.8rem;
    }

    .logo-regby {
        height: 60px;
    }
}

/* Mobile Header Styles */
@media (max-width: 767.98px) {
    .header-nav {
        padding-top: 20px;
        padding-left: 20px;
        padding-right: 20px;
    }

    .content-container {
        padding: 0 20px;
    }

    /* Mobile Header Navigation */
    .mobile-header-nav {
        flex-direction: column;
        padding: 65px 30px 30px 30px;
        position: relative;
        height: 100vh;
        height: calc(var(--vh, 1vh) * 100);
        /* Fallback для старых браузеров */
        height: 100dvh;
        /* Современное свойство для мобильных устройств */
    }

    .mobile-top-row {
        margin-bottom: 20px;
    }

    .mobile-logo-vityaz {
        width: 104px;
        width: auto;
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
        padding: 0 24px;
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

    /* Hero section мобильная версия */
    .hero-section {
        height: 100vh;
        height: calc(var(--vh, 1vh) * 100);
        /* Fallback для старых браузеров */
        height: 100dvh;
        /* Современное свойство для мобильных устройств */
        /* Полная высота для мобильной версии как в макете */
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
}

/* Small Mobile Styles */
@media (max-width: 480px) {
    .header-nav {
        padding-top: 15px;
    }

    .logo-vityaz {
        width: 50px;
    }

    .logo-regby {
        height: 40px;
    }

    .hero-section {
        height: 100vh;
        height: calc(var(--vh, 1vh) * 100);
        /* Fallback для старых браузеров */
        height: 100dvh;
        /* Современное свойство для мобильных устройств */
    }

    .section-title {
        font-size: 35px;
    }

    .section-item {
        font-size: 14px;
    }

    .content-container {
        padding: 0px 15px;
    }

    /* Убеждаемся что боковые элементы скрыты и на маленьких экранах */
    .section-header-wrapper {
        display: flex !important;
        justify-content: center !important;
        grid-template-columns: none !important;
    }

    .section-item--left,
    .section-item--right {
        display: none !important;
    }
}

/* Match day section */
.match-day {
    width: 100%;
    padding-top: 120px;
}

.event-section {
    width: 100%;
    margin-top: 120px;
    margin-bottom: 120px;
    position: relative;
    overflow: visible;
}

/* Mobile styles for sections */
@media (max-width: 767.98px) {
    .match-day {
        padding-top: 60px;
    }

    .event-section {
        margin-top: 60px;
        margin-bottom: 60px;
    }

    .sponsor-section {
        margin-bottom: 60px;
    }
}

/* News Section Styles */
.news-container {
    display: flex;
    flex-direction: column;
    gap: 40px;
    width: 100%;
}

.news-item {
    display: flex;
    gap: 100px;
    align-items: flex-start;
    width: 100%;
    cursor: pointer;
    transition: transform 0.3s ease;
}

.news-item:hover {
    transform: translateY(-5px);
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

/* Mobile News Styles */
@media (max-width: 767.98px) {
    .news-container {
        gap: 40px;
    }

    .news-item {
        flex-direction: column !important;
        gap: 20px;
        padding: 0;
        background: white;
        overflow: hidden;
        cursor: default;
    }

    .news-item:hover {
        transform: none;
    }

    .news-photo {
        flex: none;
        width: 100%;
        height: 200px;
        border-radius: 0;
    }

    .news-description {
        gap: 15px;
        padding: 0;
    }

    .news-title {
        font-size: 18px;
        color: #28223C;
    }

    .news-text {
        font-size: 14px;
        color: #28223C;
        line-height: 1.4;
    }

    /* Arrow для мобильной версии - скрываем */
    .arrow-container {
        display: none;
    }
}

/* Responsive Design for News - Tablet */
@media (max-width: 1024px) and (min-width: 768px) {
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

@media (max-width: 480px) {
    .news-title {
        font-size: 18px;
    }

    .news-text {
        font-size: 13px;
    }

    .event-section {
        margin-top: 40px;
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
    padding: 10px;
    border-radius: 50%;
    transition: background-color 0.3s ease;
}

.arrow-container:hover {
    background-color: rgba(27, 0, 71, 0.1);
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
    line-height: 40px;
    margin-bottom: 120px;
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

/* Sponsor link */
.sponsor-link {
    color: #28223C;
    text-decoration: none;
    cursor: pointer;
    transition: color 0.3s ease;
}

.sponsor-link:hover {
    color: #ED1B26;
}

/* Mobile sponsor section */
@media (max-width: 767.98px) {
    .container-logo {
        justify-content: space-around;
        align-items: center;
        margin-bottom: 60px !important;
    }

    .logo-1 img {
        max-height: 135px;
        height: auto;
    }

    .logo-2 img {
        width: 163px;
        height: auto;
    }

    .mobile-sponsor-btn {
        display: block;
        background-color: #ED1B26;
        padding: 12px 20px;
        font-size: 14px;
        font-weight: 500;
        color: white;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        cursor: pointer;
        text-align: center;
        margin: 0 auto 40px auto;
        width: fit-content;
        transition: background-color 0.3s ease;
    }

    .mobile-sponsor-btn:hover {
        background-color: #d41620;
    }

    .section-item--left .sponsor-link {
        background: #ED1B26;
        color: white;
        padding: 12px 20px;
        font-size: 14px;
        font-weight: 500;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }

    .section-item--left .sponsor-link:hover {
        background: #d41620;
        color: white;
    }
}

/* Footer mobile styles */
@media (max-width: 767.98px) {
    .footer-container {
        width: 100%;
        padding: 40px 20px;
    }

    .footer-container .row {
        flex-direction: column;
        gap: 30px;
    }

    .footer-container .col-2,
    .footer-container .col-4 {
        width: 100%;
        text-align: center;
    }

    .contact-wrapper,
    .footer-title_sponsors {
        text-align: center;
    }

    .contact-row {
        justify-content: center;
    }

    .row-sponsors_icon {
        justify-content: center;
        gap: 30px;
    }

    .footer-title_contacts,
    .footer-title_sponsors {
        font-size: 16px;
        margin-bottom: 20px;
    }
}
</style>
