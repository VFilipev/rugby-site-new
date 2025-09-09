<template>
    <div class="floating-button" :class="{ 'visible': showFloatingButton }" ref="floatingButtonRef" @click="toggleFloatingMenu">
        <button class="floating-burger-button" :class="{ 'active': isFloatingMenuOpen }">
            <span class="floating-burger-line"></span>
            <span class="floating-burger-line"></span>
            <span class="floating-burger-line"></span>
        </button>

        <!-- Floating Navigation Menu -->
        <div class="floating-nav-menu" :class="{ 'show': isFloatingMenuOpen }">
            <ul class="floating-nav-list">
                <li><a href="#" @click.prevent="goToMenTeam" class="floating-nav-link">мужской состав</a></li>
                <li><a href="#" @click.prevent="goToWomenTeam" class="floating-nav-link">женский состав</a></li>
                <li><a href="#" @click.prevent="goToSchool" class="floating-nav-link">детское регби</a></li>
                <li><a href="#" @click.prevent="goToSchedule" class="floating-nav-link">тренировки</a></li>
                <li><a href="#" @click.prevent="goToTrophies" class="floating-nav-link">зал славы</a></li>
                <li><a href="#" @click.prevent="scrollToSponsors" class="floating-nav-link">спонсоры</a></li>
                <li><a href="#" @click.prevent="scrollToMatches" class="floating-nav-link">матчи</a></li>
            </ul>
        </div>
    </div>
</template>

<script setup>
import { ref, onMounted, onUnmounted } from 'vue'
import { useRouter } from 'vue-router'

// Router
const router = useRouter()

// Floating button state
const showFloatingButton = ref(false)
const floatingButtonRef = ref(null)
const isFloatingMenuOpen = ref(false)

// Toggle floating menu
const toggleFloatingMenu = (event) => {
    event.stopPropagation()
    isFloatingMenuOpen.value = !isFloatingMenuOpen.value
}

// Close floating menu when clicking outside
const closeFloatingMenu = (event) => {
    if (floatingButtonRef.value && !floatingButtonRef.value.contains(event.target)) {
        isFloatingMenuOpen.value = false
    }
}

// Scroll handler to show/hide floating button
const handleScroll = () => {
    const heroHeight = window.innerHeight
    const scrollTop = window.pageYOffset || document.documentElement.scrollTop

    // Показываем кнопку когда прокрутили больше чем высота первого экрана
    showFloatingButton.value = scrollTop > heroHeight * 0.8
}

// Navigation functions
const goToMenTeam = () => {
    isFloatingMenuOpen.value = false
    router.push('/team#man')
}

const goToWomenTeam = () => {
    isFloatingMenuOpen.value = false
    router.push('/team#woman')
}

const goToSchool = () => {
    isFloatingMenuOpen.value = false
    router.push('/school')
}

const goToSchedule = () => {
    isFloatingMenuOpen.value = false
    router.push('/schedule')
}

const goToTrophies = () => {
    isFloatingMenuOpen.value = false
    router.push('/trophies')
}

const scrollToMatches = () => {
    isFloatingMenuOpen.value = false
    const matchesSection = document.getElementById('matches-section')
    if (matchesSection) {
        matchesSection.scrollIntoView({
            behavior: 'smooth',
            block: 'start'
        })
    }
}

const scrollToSponsors = () => {
    isFloatingMenuOpen.value = false
    const sponsorsSection = document.getElementById('sponsors-section')
    if (sponsorsSection) {
        sponsorsSection.scrollIntoView({
            behavior: 'smooth',
            block: 'start'
        })
    }
}

// Global click handler
const handleGlobalClick = (event) => {
    closeFloatingMenu(event)
}

// Keyboard handler
const handleKeyDown = (event) => {
    if (event.key === 'Escape' && isFloatingMenuOpen.value) {
        isFloatingMenuOpen.value = false
    }
}

// Lifecycle hooks
onMounted(() => {
    document.addEventListener('click', handleGlobalClick)
    document.addEventListener('keydown', handleKeyDown)
    window.addEventListener('scroll', handleScroll)
})

onUnmounted(() => {
    document.removeEventListener('click', handleGlobalClick)
    document.removeEventListener('keydown', handleKeyDown)
    window.removeEventListener('scroll', handleScroll)
})
</script>

<style scoped>
/* Floating Button Styles */
.floating-button {
    position: fixed;
    bottom: 30px;
    right: 30px;
    z-index: 9999;
    opacity: 0;
    visibility: hidden;
    transform: translateY(100px);
    transition: all 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94);
}

/* Hide floating button on desktop */
@media (min-width: 768px) {
    .floating-button {
        display: none !important;
    }
}

.floating-button.visible {
    opacity: 1;
    visibility: visible;
    transform: translateY(0);
}

.floating-burger-button {
    width: 50px;
    height: 50px;
    background-color: #ED1B26;
    border: none;
    border-radius: 50%;
    cursor: pointer;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    position: relative;
    transition: all 0.3s ease;
}

.floating-burger-button:hover {
    transform: scale(1.1);
}

.floating-burger-line {
    width: 20px;
    height: 2px;
    background-color: white;
    transition: all 0.3s ease;
    position: absolute;
    border-radius: 1px;
}

.floating-burger-line:nth-child(1) {
    transform: translateY(-5px);
}

.floating-burger-line:nth-child(2) {
    transform: translateY(0);
}

.floating-burger-line:nth-child(3) {
    transform: translateY(5px);
}

.floating-burger-button.active .floating-burger-line:nth-child(1) {
    transform: rotate(45deg);
}

.floating-burger-button.active .floating-burger-line:nth-child(2) {
    opacity: 0;
}

.floating-burger-button.active .floating-burger-line:nth-child(3) {
    transform: rotate(-45deg);
}

/* Floating Navigation Menu */
.floating-nav-menu {
    position: absolute;
    bottom: 60px;
    right: 0;
    opacity: 0;
    visibility: hidden;
    transform: translateY(10px);
    transition: all 0.3s ease;
    z-index: 9998;
    min-width: 160px;
    background: white;
    box-shadow: 0 10px 30px rgba(40, 34, 60, 0.2);
    padding: 15px 0;
}

.floating-nav-menu.show {
    opacity: 1;
    visibility: visible;
    transform: translateY(0);
}

.floating-nav-list {
    list-style: none;
    margin: 0;
    padding: 0;
    display: flex;
    flex-direction: column;
    gap: 0;
}

.floating-nav-list li {
    margin: 0;
}

.floating-nav-link {
    display: block;
    color: #28223C;
    text-decoration: none;
    font-size: 14px;
    font-weight: 400;
    text-align: right;
    transition: all 0.3s ease;
    padding: 10px 20px;
    border-radius: 0;
}

.floating-nav-link:hover {
    color: #ED1B26;
    background-color: rgba(237, 27, 38, 0.05);
}

/* Mobile adjustments for floating button */
@media (max-width: 767.98px) {
    .floating-button {
        bottom: 20px;
        right: 20px;
    }

    .floating-button:not(.visible) {
        transform: translateY(80px);
    }

    .floating-nav-menu {
        min-width: 140px;
    }

    .floating-nav-link {
        font-size: 13px;
        padding: 8px 15px;
    }
}
</style>
