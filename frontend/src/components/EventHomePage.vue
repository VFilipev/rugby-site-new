<template>

            <div class="news-container" ref="newsContainer">
                <div
                    v-for="(event, index) in eventsList"
                    :key="event.id"
                    class="news-item"
                    :class="{
                        'last-news-item': index === eventsList.length - 1,
                        'animate-in-left': index % 2 === 0 && visibleItems[index],
                        'animate-in-right': index % 2 === 1 && visibleItems[index],
                        'news-hidden': !visibleItems[index]
                    }"
                    :ref="el => setNewsItemRef(el, index)"
                    @click="goToEvents"
                >
                    <div class="news-photo">
                        <img :src="event.preview_photo_url || '/images/news-photo.jpg'" :alt="event.title" class="news-image">
                    </div>
                    <div class="news-description">
                        <div class="news-title news-title--clamp">{{ event.title }}</div>
                        <div class="news-text news-text--clamp">{{ event.text }}</div>
                        <div class="news-item_date">{{ getDateLabel(event.date) }}</div>
                    </div>

                    <div v-if="index === eventsList.length - 1" class="arrow-container" @click.stop="goToEvents">
                        <img src="@/assets/Arrow.svg" alt="Стрелка" class="arrow-icon">
                    </div>
                </div>
            </div>
</template>

<script setup>
import { ref, onMounted, onUnmounted, nextTick } from 'vue'
import { useNavigation } from '@/composables/useNavigation'
import { Events } from '@/api'
import moment from 'moment'
const months = [
    'января', 'февраля', 'марта', 'апреля', 'мая', 'июня',
    'июля', 'августа', 'сентября', 'октября', 'ноября', 'декабря'
]
const getDateLabel = (date) => {
    const momentDate = moment(date)
    const day = momentDate.format('D')
    const monthIndex = momentDate.month()
    const month = months[monthIndex]

    return `${day} ${month}`
}
const { goToEvents } = useNavigation()

const newsContainer = ref(null)
const itemRefs = ref([])

const eventsList = ref([])
const getEventsList = async () => {
    const response = await Events.mainPage()
    eventsList.value = response
}

const visibleItems = ref([])

const setNewsItemRef = (el, index) => {
    if (el) {
        itemRefs.value[index] = el
    }
}

const observeNewsItems = () => {
    const options = {
        threshold: 0.3,
        rootMargin: '0px 0px -50px 0px'
    }

    const observer = new IntersectionObserver((entries) => {
        entries.forEach((entry) => {
            if (entry.isIntersecting) {
                const index = itemRefs.value.indexOf(entry.target)
                const delay = index * 150
                setTimeout(() => {
                    visibleItems.value[index] = true
                }, delay)
            }
        })
    }, options)

    itemRefs.value.forEach(el => el && observer.observe(el))

    return observer
}

let observerRef = null

onMounted(async () => {
    await getEventsList()
    await nextTick()
    visibleItems.value = new Array(eventsList.value.length).fill(false)
    observerRef = observeNewsItems()
})

onUnmounted(() => {
    if (observerRef && observerRef.disconnect) observerRef.disconnect()
})
</script>

<style scoped>
.news-item_date{
    text-transform: uppercase;
}
.event-section {
    width: 100%;
    margin-top: 120px;
    margin-bottom: 120px;
    position: relative;
    overflow: visible;
}

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

.news-text--clamp {
    display: -webkit-box;
    -webkit-line-clamp: 4;
    line-clamp: 4;
    -webkit-box-orient: vertical;
    overflow: hidden;
}
.news-title--clamp {
    display: -webkit-box;
    -webkit-line-clamp: 2;
    line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
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

/* Mobile styles for sections */
@media (max-width: 767.98px) {
    .event-section {
        margin-top: 60px;
        margin-bottom: 60px;
    }

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

    .news-item_date {
        font-size: 20px;
        color: #28223C;
        font-family: 'Rossika';
        font-weight: 400;
        text-transform: uppercase;
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
    .event-section {
        margin-top: 40px;
    }
}
</style>


