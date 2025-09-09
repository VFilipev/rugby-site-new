<template>
    <div class="match-carousel">
        <div class="match-cards" ref="matchCards" @mousedown="handleMouseDown" @mousemove="handleMouseMove"
            @mouseup="handleMouseUp" @mouseleave="handleMouseUp" @touchstart="handleTouchStart"
            @touchmove="handleTouchMove" @touchend="handleTouchEnd">
            <!-- Единый цикл по карточкам с условным шаблоном -->
            <template v-for="card in combinedCardsList" :key="`${card.type}-${card.id}`">
                <!-- Карточка матча -->
                <div class="match-card" v-if="card && card.type === 'match'">
                    <div class="row">
                        <div class="col-12 header-wrapper">
                            <div class="d-flex justify-content-center">
                                <div class="liga text-center">{{ card.league }}</div>
                            </div>
                            <div class="match-date">{{ getDate(card.date) }}</div>
                        </div>
                    </div>
                    <div class="match-content">
                        <div class="scores-row">
                            <div class="score">{{ card.score_team_a }}</div>
                            <div class="score-divider">:</div>
                            <div class="score">{{ card.score_team_b }}</div>
                        </div>
                        <div class="teams-row">
                            <div class="team">{{ card.team_a }}</div>
                            <div class="team">{{ card.team_b }}</div>
                        </div>
                    </div>
                    <div class="match-location" v-html="formatVenue(card.venue)">
                    </div>
                </div>

                <!-- Карточка турнира -->
                <div class="match-card tournament-result"
                    v-else-if="card && card.type === 'tournament'">
                    <div class="row">
                        <div class="col-12 header-wrapper">
                            <div class="d-flex justify-content-center">
                                <div class="liga text-center">{{ card.league }}</div>
                            </div>
                            <div class="match-date">{{ getDateRange(card.date_start, card.date_end) }}</div>
                        </div>
                    </div>
                    <div class="tournament-content">
                        <div v-if="card.position" class="place-result">
                            {{ card.position }} МЕСТО</div>
                        <div v-else class="place-result">-</div>
                        <div class="team-name">
                            {{ card.team }}
                        </div>
                    </div>
                    <div class="match-location" v-html="formatVenue(card.venue)">
                    </div>
                </div>
            </template>
        </div>
    </div>
</template>

<script setup>
import { ref, onMounted, onUnmounted, computed, nextTick } from 'vue'
import { Matches, Tournaments } from '@/api'
import moment from 'moment'

const months = [
    'января', 'февраля', 'марта', 'апреля', 'мая', 'июня',
    'июля', 'августа', 'сентября', 'октября', 'ноября', 'декабря'
]
const getDateRange = (date_start, date_end) => {
    const momentDateStart = moment(date_start)
    const momentDateEnd = moment(date_end)
    const dayStart = momentDateStart.format('D')
    const dayEnd = momentDateEnd.format('D')
    const monthStartIndex = momentDateStart.month()
    const monthEndIndex = momentDateEnd.month()
    const monthStart = months[monthStartIndex]
    const monthEnd = months[monthEndIndex]
    if (monthStartIndex === monthEndIndex) {
        return `${dayStart} - ${dayEnd} ${monthStart}`
    }
    return `${dayStart} ${monthStart} - ${dayEnd} ${monthEnd}`
}

const getDate = (date) => {
    const momentDate = moment(date)
    const day = momentDate.format('D')
    const monthIndex = momentDate.month()
    const month = months[monthIndex]

    return `${day} ${month}`
}

const formatVenue = (venue) => {
    if (!venue) return ''

    // Разбиваем по запятой
    const parts = venue.split(',')
    if (parts.length >= 2) {
        const city = parts[0].trim()
        const stadium = parts.slice(1).join(',').trim()
        return `${city},<br>${stadium}`
    }

    return venue
}
const tournamentsList = ref([])
const getTournamentsList = async () => {
    const response = await Tournaments.getList({is_hidden:false})
    tournamentsList.value = response.reverse()
}
const matchesList = ref([])
const getMatchesList = async () => {
    const response = await Matches.getList({is_hidden:false})
    // Переворачиваем массив, чтобы прошлые матчи были слева, будущие справа
    matchesList.value = response.reverse()
}

// Объединенный список всех карточек (матчи + турниры)
const combinedCardsList = ref([])

// Функция для объединения матчей и турниров в один массив с сортировкой по дате
const combineAndSortCards = () => {
    const combined = []

    // Добавляем матчи с типом 'match'
    matchesList.value.forEach(match => {
        if (match && match.date) {
            combined.push({
                ...match,
                type: 'match',
                sortDate: moment(match.date)
            })
        }
    })

    // Добавляем турниры с типом 'tournament'
    tournamentsList.value.forEach(tournament => {
        if (tournament && tournament.date_start) {
            combined.push({
                ...tournament,
                type: 'tournament',
                sortDate: moment(tournament.date_start)
            })
        }
    })

    // Сортируем по дате (от старых к новым)
    combined.sort((a, b) => a.sortDate.diff(b.sortDate))

    // Удаляем временное поле sortDate
    combined.forEach(card => delete card.sortDate)

    combinedCardsList.value = combined
}

// Находим индекс ближайшей карточки (матча или турнира)
const findNearestCardIndex = () => {
    if (combinedCardsList.value.length === 0) return 0

    const now = moment()
    let nearestIndex = 0
    let minTimeDiff = Infinity


    // Ищем карточку с минимальной разницей во времени от текущего момента
    for (let i = 0; i < combinedCardsList.value.length; i++) {
        const card = combinedCardsList.value[i]
        if (!card || !card.type) continue

        const cardDate = card.type === 'match'
            ? moment(card.date)
            : moment(card.date_start)
        const timeDiff = Math.abs(cardDate.diff(now))


        if (timeDiff < minTimeDiff) {
            minTimeDiff = timeDiff
            nearestIndex = i
        }
    }

    const nearestCard = combinedCardsList.value[nearestIndex]
    if (!nearestCard || !nearestCard.type) {
        return 0
    }

    const nearestDate = nearestCard.type === 'match'
        ? moment(nearestCard.date)
        : moment(nearestCard.date_start)


    return nearestIndex
}
const matchCards = ref(null)
const isDragging = ref(false)
const startX = ref(0)
const scrollLeft = ref(0)
const currentTranslate = ref(0)

// Адаптивные параметры
const getCardWidth = () => window.innerWidth <= 768 ? 300 : 400
const getCardGap = () => window.innerWidth <= 768 ? 20 : 40
const visibleCards = 3
const partialCardWidth = 46

// Вычисляем количество карточек динамически
const totalCards = computed(() => {
    if (!matchCards.value) return 6 // fallback
    return matchCards.value.children.length
})

// Вычисляем все возможные позиции
const getPositions = () => {
    const cardCount = combinedCardsList.value.length
    if (cardCount === 0) return [0]

    if (window.innerWidth <= 768) {
        // Динамические позиции для мобильной версии
        const positions = []
        const cardWidth = getCardWidth()
        const cardGap = getCardGap()
        const stepSize = cardWidth + cardGap
        const maxStartIndex = Math.max(0, cardCount - 1)

        for (let i = 0; i <= maxStartIndex; i++) {
            const translateX = -i * stepSize
            positions.push(translateX)
        }

        return positions
    } else {
        // Динамические позиции для десктопной версии
        const positions = []
        const cardWidth = getCardWidth()
        const cardGap = getCardGap()
        const stepSize = cardWidth + cardGap

        // Вычисляем позицию для центрирования карточки
        const centerOffset = (window.innerWidth - cardWidth) / 2 - 50 // 50px - отступ карусели

        for (let i = 0; i < cardCount; i++) {
            const translateX = centerOffset - (i * stepSize)
            positions.push(translateX)
        }

        return positions
    }
}

const handleMouseDown = (e) => {
    isDragging.value = true
    startX.value = e.pageX - matchCards.value.offsetLeft
    scrollLeft.value = currentTranslate.value
    matchCards.value.style.cursor = 'grabbing'
    matchCards.value.style.transition = 'none'
}

const handleMouseMove = (e) => {
    if (!isDragging.value) return
    e.preventDefault()

    const x = e.pageX - matchCards.value.offsetLeft
    const walk = (x - startX.value) * 1
    const newTranslate = scrollLeft.value + walk

    // Динамические границы
    const positions = getPositions()
    const maxTranslate = Math.max(...positions)
    const minTranslate = Math.min(...positions)

    currentTranslate.value = Math.max(minTranslate, Math.min(maxTranslate, newTranslate))
    matchCards.value.style.transform = `translateX(${currentTranslate.value}px)`
}

const handleMouseUp = () => {
    if (!isDragging.value) return

    isDragging.value = false
    matchCards.value.style.cursor = 'grab'
    matchCards.value.style.transition = 'transform 0.3s ease'

    // Находим ближайшую позицию с учетом направления движения
    const positions = getPositions()
    const dragDistance = currentTranslate.value - scrollLeft.value
    const threshold = 50 // порог для переключения позиции

    // Находим текущую позицию
    let currentIndex = 0
    let minDistance = Math.abs(scrollLeft.value - positions[0])
    for (let i = 1; i < positions.length; i++) {
        const distance = Math.abs(scrollLeft.value - positions[i])
        if (distance < minDistance) {
            minDistance = distance
            currentIndex = i
        }
    }

    // Определяем новую позицию на основе направления движения
    let targetIndex = currentIndex
    if (dragDistance > threshold && currentIndex > 0) {
        // Движение вправо - переходим к предыдущей позиции
        targetIndex = currentIndex - 1
    } else if (dragDistance < -threshold && currentIndex < positions.length - 1) {
        // Движение влево - переходим к следующей позиции
        targetIndex = currentIndex + 1
    }

    currentTranslate.value = positions[targetIndex]
    matchCards.value.style.transform = `translateX(${currentTranslate.value}px)`
}

// Touch event handlers
const handleTouchStart = (e) => {
    isDragging.value = true
    startX.value = e.touches[0].pageX - matchCards.value.offsetLeft
    scrollLeft.value = currentTranslate.value
    matchCards.value.style.transition = 'none'
}

const handleTouchMove = (e) => {
    if (!isDragging.value) return
    e.preventDefault()

    const x = e.touches[0].pageX - matchCards.value.offsetLeft
    const walk = (x - startX.value) * 1
    const newTranslate = scrollLeft.value + walk

    // Динамические границы
    const positions = getPositions()
    const maxTranslate = Math.max(...positions)
    const minTranslate = Math.min(...positions)

    currentTranslate.value = Math.max(minTranslate, Math.min(maxTranslate, newTranslate))
    matchCards.value.style.transform = `translateX(${currentTranslate.value}px)`
}

const handleTouchEnd = () => {
    if (!isDragging.value) return

    isDragging.value = false
    matchCards.value.style.transition = 'transform 0.3s ease'

    // Находим ближайшую позицию с учетом направления движения
    const positions = getPositions()
    const dragDistance = currentTranslate.value - scrollLeft.value
    const threshold = 50 // порог для переключения позиции

    // Находим текущую позицию
    let currentIndex = 0
    let minDistance = Math.abs(scrollLeft.value - positions[0])
    for (let i = 1; i < positions.length; i++) {
        const distance = Math.abs(scrollLeft.value - positions[i])
        if (distance < minDistance) {
            minDistance = distance
            currentIndex = i
        }
    }

    // Определяем новую позицию на основе направления движения
    let targetIndex = currentIndex
    if (dragDistance > threshold && currentIndex > 0) {
        // Движение вправо - переходим к предыдущей позиции
        targetIndex = currentIndex - 1
    } else if (dragDistance < -threshold && currentIndex < positions.length - 1) {
        // Движение влево - переходим к следующей позиции
        targetIndex = currentIndex + 1
    }

    currentTranslate.value = positions[targetIndex]
    matchCards.value.style.transform = `translateX(${currentTranslate.value}px)`
}

const initializeCarousel = () => {
    if (!matchCards.value || combinedCardsList.value.length === 0) {
        return
    }

    // Устанавливаем адаптивную ширину контейнера
    const cardWidth = getCardWidth()
    const cardGap = getCardGap()
    const containerWidth = combinedCardsList.value.length * cardWidth + (combinedCardsList.value.length - 1) * cardGap
    matchCards.value.style.width = `${containerWidth}px`

    const positions = getPositions()
    const nearestCardIndex = findNearestCardIndex()


    // Устанавливаем позицию для показа ближайшей карточки по центру
    if (positions.length > 0) {
        // Ограничиваем индекс в пределах доступных позиций
        const targetIndex = Math.min(nearestCardIndex, positions.length - 1)
        currentTranslate.value = positions[targetIndex]
        matchCards.value.style.transform = `translateX(${currentTranslate.value}px)`

    }
}

onMounted(async () => {
    try {
        // Загружаем данные матчей и турниров
        await Promise.all([getMatchesList(), getTournamentsList()])


        // Объединяем и сортируем карточки
        combineAndSortCards()

        await nextTick()
        initializeCarousel()

        // Обработчик изменения размера окна для адаптивности
        window.addEventListener('resize', initializeCarousel)
    } catch (error) {
        console.error('Ошибка при загрузке данных:', error)
    }
})

onUnmounted(() => {
    // Очистка обработчика событий
    window.removeEventListener('resize', initializeCarousel)
})
</script>

<style scoped>
.header-wrapper {
    display: flex;
    flex-direction: column;
    gap: 25px;
}

/* Rossika font загружен глобально в main.css */

/* Helvetica больше не используется в проекте - заменен на Golos Text */

.match-carousel {
    width: 100%;
    position: relative;
    overflow: hidden;
    padding: 0 50px;
    /* Отступы для показа частичных карточек по краям */
}

.match-cards {
    display: flex;
    gap: 40px;
    transition: transform 0.3s ease;
    cursor: grab;
    user-select: none;
    touch-action: pan-x;
    -webkit-user-select: none;
    -webkit-touch-callout: none;
}

.match-cards:active {
    cursor: grabbing;
}

.match-card {
    flex: 0 0 400px;
    /* Фиксированная ширина 400px */
    background: #28223C;
    padding: 25px 50px 50px 50px;
    color: white;
    display: flex;
    flex-direction: column;
}

.match-date {
    font-size: 18px;
    text-align: center;
    font-weight: bold;
    font-family: 'Golos Text', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
    font-weight: 600;
}

.match-content {
    display: flex;
    flex-direction: column;
    margin-bottom: 40px;
    margin-top: 30px;
}

.scores-row {
    display: grid;
    grid-template-columns: 1fr auto 1fr;
    align-items: center;
    margin-bottom: 15px;
    gap: 10px;
}

.score {
    font-family: 'Rossika';
    font-size: 90px;
    line-height: 1;
    text-align: center;
}

.score-divider {
    font-family: 'Rossika';
    font-size: 90px;
    line-height: 1;
    text-align: center;
    transform: translateY(-10px);
}

.teams-row {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 20px;
}

.team {
    font-size: 18px;
    text-align: center;
    line-height: 1.2;
    opacity: 0.8;
}

.match-location {
    font-size: 14px;
    text-align: center;
    line-height: 1.2;
    margin-top: auto;
}

.liga {
    font-size: 14px;
    font-weight: normal;
    opacity: 0.9;
    line-height: 1.3;
    max-width: 169px
}

/* Tournament Result Card Styles */
.tournament-result .tournament-content {
    display: flex;
    flex-direction: column;
    align-items: center;
    margin-bottom: 40px;
    margin-top: 30px;
}

.place-result {
    font-family: 'Rossika';
    font-size: 90px;
    line-height: 1;
    text-align: center;
    font-weight: 300;
    margin-bottom: 15px;
}

.team-name {
    font-size: 18px;
    text-align: center;
    line-height: 1.15;
    opacity: 0.8;
}

/* Mobile Styles */
@media (max-width: 768px) {
    .liga {
        font-size: 12px;
    }

    .match-carousel {
        padding: 0 45px;
    }

    @media (min-width: 391px) and (max-width: 768px) {
        .match-carousel {
            padding: 0 65px;
        }
    }

    .match-cards {
        gap: 20px;
    }

    .match-card {
        flex: 0 0 300px;
        padding: 20px 30px 30px 30px;
    }

    .score {
        font-size: 60px;
    }

    .score-divider {
        font-size: 60px;
        transform: translateY(-8px);
    }

    .team {
        font-size: 16px;
    }

    .match-date {
        font-size: 16px;
    }

    .match-location {
        font-size: 12px;
    }

    /* Mobile styles for tournament result card */
    .place-result {
        font-size: 60px;
    }

    .team-name {
        font-size: 16px;
    }
}

/* Стили для сообщения об отсутствии карточек */
.no-cards-message {
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 200px;
    color: white;
    font-size: 18px;
    opacity: 0.7;
}
</style>
