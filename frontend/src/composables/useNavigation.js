import { ref, onMounted, onUnmounted } from 'vue'
import { useRouter } from 'vue-router'

export function useNavigation() {
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

    const goToSchool = () => {
        router.push('/school')
    }

    const goToEvents = () => {
        // На мобильных устройствах не переходим
        if (window.innerWidth <= 768) {
            return
        }
        router.push('/events')
    }

    // Scroll functions
    const scrollToMatches = () => {
        const matchesSection = document.getElementById('matches-section')
        if (matchesSection) {
            matchesSection.scrollIntoView({
                behavior: 'smooth',
                block: 'start'
            })
        }
    }

    const scrollToSponsors = () => {
        const sponsorsSection = document.getElementById('sponsors-section')
        if (sponsorsSection) {
            sponsorsSection.scrollIntoView({
                behavior: 'smooth',
                block: 'start'
            })
        }
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
        scrollToMatches()
    }

    const scrollToSponsorsMobile = () => {
        isMobileMenuOpen.value = false
        scrollToSponsors()
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

    // Global click handler
    const handleGlobalClick = (event) => {
        closeDropdown(event)
        closeMobileMenu(event)
    }

    // Keyboard handler
    const handleKeyDown = (event) => {
        if (event.key === 'Escape') {
            if (isMobileMenuOpen.value) {
                isMobileMenuOpen.value = false
            }
        }
    }

    // Setup event listeners
    onMounted(() => {
        document.addEventListener('click', handleGlobalClick)
        document.addEventListener('keydown', handleKeyDown)
    })

    onUnmounted(() => {
        document.removeEventListener('click', handleGlobalClick)
        document.removeEventListener('keydown', handleKeyDown)
    })

    return {
        // States
        isDropdownOpen,
        dropdownRef,
        isMobileMenuOpen,
        mobileBurgerRef,

        // Functions
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
    }
}
