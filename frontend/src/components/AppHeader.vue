<template>
    <div class="header-wrapper">
        <div class="header-container d-flex justify-content-between align-items-center">
            <!-- Desktop version -->
            <div class="logo-left d-none d-md-block">
                <a href="#" @click="goToHome" class="logo-link">
                    <img
                        :src="logoSrc"
                        alt="Витязь"
                        class="logo-vityaz"
                    >
                </a>
            </div>
            <div class="nav-right_wrapper d-flex align-items-center d-none d-md-flex">
                <div class="header-nav_wrapper d-flex gap-5 align-items-start">
                    <div class="header-nav_item dropdown-container" ref="dropdownRef">
                        <div class="school-link p-0">
                        <a href="#" class="header-nav_link" @click.prevent="toggleDropdown">
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
                                <li><a href="#" class="dropdown-link p-0" @click.prevent="goToTeam">состав</a></li>
                                <li><a href="#" class="dropdown-link p-0" @click.prevent="goToSchedule">тренировки</a></li>
                                <li><a href="#" class="dropdown-link p-0 mb-0" @click.prevent="goToTrophies">зал славы</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="header-nav_item">
                        <a class="p-0 school-link" href="#" @click.prevent="scrollToMatches">матчи</a>
                    </div>
                    <div class="header-nav_item">
                        <a class="p-0 school-link" href="#" @click.prevent="scrollToSponsors">спонсоры</a>
                    </div>
                    <div class="header-nav_item  p-0 text-left">
                        <a class="p-0 school-link" href="#" @click.prevent="goToSchool">
                            <span class="school-line">детское</span>
                            <span class="school-line">регби</span>
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
                    <img src="@/assets/logo-regby-permskiy-krai-white.svg" alt="Регби Пермского края" class="logo-regby">
                </div>
            </div>

            <!-- Mobile version -->
            <div class="mobile-header d-flex d-md-none w-100 justify-content-between align-items-start">
                <!-- Mobile Logo -->
                <div class="mobile-logo">
                    <a href="#" @click.prevent="goToHome" class="logo-link">
                        <img src="@/assets/logo-vityaz_mobile.svg" alt="Витязь" class="mobile-logo-vityaz">
                    </a>
                </div>

                <!-- Mobile Burger Menu -->
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
                            <li><a href="#" @click.prevent="goToMenTeamMobile" class="mobile-nav-link">мужской состав</a></li>
                            <li><a href="#" @click.prevent="goToWomenTeamMobile" class="mobile-nav-link">женский состав</a></li>
                            <li><a href="#" @click.prevent="goToSchoolMobile" class="mobile-nav-link">детское регби</a></li>
                            <li><a href="#" @click.prevent="goToScheduleMobile" class="mobile-nav-link">тренировки</a></li>
                            <li><a href="#" @click.prevent="goToTrophiesMobile" class="mobile-nav-link">зал славы</a></li>
                            <li><a href="#" @click.prevent="scrollToSponsorsMobile" class="mobile-nav-link">спонсоры</a></li>
                            <li><a href="#" @click.prevent="scrollToMatchesMobile" class="mobile-nav-link">матчи</a></li>

                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup>
import { ref, onMounted, onUnmounted, computed } from 'vue'
import { useRouter } from 'vue-router'
import logoVityazWithout from '@/assets/logo_vityaz_without.png'
import logoVityaz from '@/assets/logo-vityaz-no-text.svg'

// Props
const props = defineProps({
    logoVariant: {
        type: String,
        default: 'without', // 'without' или 'with'
        validator: (value) => ['without', 'with'].includes(value)
    }
})

// Computed property for logo source
const logoSrc = computed(() => {
    return props.logoVariant === 'without' ? logoVityazWithout : logoVityaz
})

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
const toggleMobileMenu = (event) => {
    event.stopPropagation()
    isMobileMenuOpen.value = !isMobileMenuOpen.value
}

const closeMobileMenu = (event) => {
    if (mobileBurgerRef.value && !mobileBurgerRef.value.contains(event.target)) {
        isMobileMenuOpen.value = false
    }
}

// Navigation functions
const goToHome = () => {
    router.push('/')
}

const scrollToMatches = () => {
    router.push('/#matches-section')
}

const scrollToSponsors = () => {
    router.push('/#sponsors-section')
}

const goToSchool = () => {
    router.push('/school')
}

const goToTeam = () => {
    isDropdownOpen.value = false
    router.push('/team')
}

const goToTrophies = () => {
    isDropdownOpen.value = false
    router.push('/trophies')
}

const goToSchedule = () => {
    isDropdownOpen.value = false
    router.push('/schedule')
}

// Mobile navigation functions
const goToMenTeamMobile = () => {
    isMobileMenuOpen.value = false
    router.push('/team#man')
}

const goToWomenTeamMobile = () => {
    isMobileMenuOpen.value = false
    router.push('/team#woman')
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

const goToScheduleMobile = () => {
    isMobileMenuOpen.value = false
    router.push('/schedule')
}

const goToTrophiesMobile = () => {
    isMobileMenuOpen.value = false
    router.push('/trophies')
}

// Global click handler for closing menu
const handleGlobalClick = (event) => {
    closeDropdown(event)
    closeMobileMenu(event)
}

// Add and remove global click handler
onMounted(() => {
    document.addEventListener('click', handleGlobalClick)
})

onUnmounted(() => {
    document.removeEventListener('click', handleGlobalClick)
})
</script>

<style scoped>
.header-nav_wrapper {
    margin-right: 55px;
    transform: translateY(7px);
}

.header-wrapper {
    background-color: #28223C;
}

.header-container {
    max-width: 1280px;
    width: 1280px;
    margin: 0 auto;
    padding-top: 17px;
    padding-bottom: 9px;
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
    width: 74px;
    height: auto;

}

.logo-regby {
    width: 135px;
}

.header-nav_item a {
    color: #fff;
    font-size: 12px;
    font-weight: 500;
    line-height: 19.2px;
    text-decoration: none;
    text-transform: uppercase;
    letter-spacing: 0.7px;
    line-height: 12px;
    padding: 0;
}

.header-nav_link {
    color: #fff;
    font-size: 14px;
    font-weight: 400;
    line-height: 19.2px;
    text-decoration: none;
    text-transform: uppercase;
    display: inline-flex;
    align-items: center;
    gap: 8px;
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
    min-width: 210px;
    opacity: 0;
    visibility: hidden;
    transform: translate(-20px, 37px);
    transition: all 0.3s ease;
    z-index: 9999;
    background: white;
    padding: 0px;
    box-shadow: 0 4px 20px #28223C38;
}

.dropdown-menu-custom.show {
    opacity: 1;
    visibility: visible;
    transform: translate(-20px, 62px);
}

.dropdown-list {
    list-style: none;
    margin: 0;
    padding: 20px 20px;
}

.dropdown-list li {
    margin: 0px 0;
}

.dropdown-link {
    display: block;
    color: #28223C !important;
    text-decoration: none;
    font-size: 14px;
    font-weight: 400;
    letter-spacing: 0.5px;
    text-transform: uppercase;
    transition: all 0.3s ease;
    margin-bottom: 20px;
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
    color: #fff;
    font-size: 12px;
    font-weight: 500;
    line-height: 14px;
    text-decoration: none;
    text-transform: uppercase;
    letter-spacing: 0.7px;
}

/* Mobile Styles */
@media (max-width: 767.98px) {
    .header-wrapper {
        background-color: transparent !important;
    }

    .header-container {
        width: 100%;
        max-width: 100%;
        padding: 20px;
    }

    .mobile-header {
        align-items: flex-start;
    }

    .mobile-logo-vityaz {
        height: 144px;
        width: auto;
    }

    /* Burger Menu */
    .mobile-burger-menu {
        position: relative;
        margin-top: 10px;
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
        background-color: #28223C;
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
        top: 100%;
        right: 0;
        opacity: 0;
        visibility: hidden;
        transform: translateY(10px);
        transition: all 0.3s ease;
        z-index: 99999;
        margin-top: 20px;
        min-width: 130px;
        background: white;
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
        color: #28223C;
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
</style>
