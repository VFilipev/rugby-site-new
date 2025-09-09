<script setup>
import AppHeader from '@/components/AppHeader.vue'
import AppFooter from '@/components/AppFooter.vue'
import { Events } from '@/api'
import { ref, onMounted } from 'vue'
import moment from 'moment'
const eventsList = ref([])
const getEventsList = async () => {
    const response = await Events.recent()
    eventsList.value = response
}
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
const goToUrl = (url) => {
    window.open(url, '_blank')
    return
}
onMounted(async () => {
    await getEventsList()
})
</script>
<template>
    <div>
        <AppHeader logo-variant="without" />
        <section class="events-section">
            <div class="events-container">
                <div class="section-header-wrapper"
                    style="margin-bottom: 100px; margin-top: 100px; max-width: 1280px; width: 1280px; margin-left: auto; margin-right: auto;">
                    <div class="section-item section-item--left">
                        НОВОСТИ
                    </div>
                    <div class="section-title">
                        СОБЫТИЯ
                    </div>
                    <div class="section-item section-item--right">
                        2025
                    </div>
                </div>
                <div class="row-news_wrapper">
                    <div :class="{ 'news-item': !event.news_url, 'news-item-full': event.news_url }"
                        v-for="event in eventsList" :key="event.id">
                        <div class="news-item_photo">
                            <img :src="event.preview_photo_url" :alt="event.title" class="news-image">
                        </div>
                        <div class="news-item_description"
                            :style="{ paddingTop: event.news_url ? '50px' : '0', paddingRight: event.news_url ? '80px' : '0' }">
                            <div class="news-item_header d-flex justify-content-between">
                                <div class="news-item_title" :style="{ color: event.news_url ? '#fff' : '#28223C' }">
                                    {{ event.title }}
                                </div>
                                <div class="news-item_date" :style="{ color: event.news_url ? '#fff' : '#28223C' }">
                                    {{ getDateLabel(event.date) }}
                                </div>
                            </div>
                            <div class="news-item_text" :style="{ color: event.news_url ? '#fff' : '#28223C' }">
                                {{ event.text }}
                            </div>
                        </div>
                        <div v-if="event.news_url" class="arrow-container" @click.stop="goToUrl(event.news_url)">
                            <img src="@/assets/ArrowWhite.svg" alt="Стрелка" class="arrow-icon">
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <div style="margin-top: 100px;">
            <AppFooter />
        </div>
    </div>
</template>

<style scoped>
.news-item-full {
    position: relative;
}

.arrow-container {
    position: absolute;
    bottom: 20px;
    right: 80px;
    z-index: 10;
    cursor: pointer;
    padding: 10px;
    border-radius: 50%;
    transition: background-color 0.3s ease;
}

.arrow-container:hover {
    background-color: rgba(255, 255, 255, 0.1);
}

.arrow-icon {
    width: 26px;
    height: 16px;
    transition: transform 0.3s ease;
    fill: #fbfbfb;
}

.arrow-container:hover .arrow-icon {
    transform: translateX(3px) scale(1.1);
}
.logo-regby {
    width: 135px
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

.news-item-full {
    background-color: #28223C;
    display: flex;
    width: 100%;
    gap: 50px;
}

.news-item_text {
    margin-top: 30px;
    color: #28223C;
    font-size: 16px;
    line-height: 25px;
}

.news-item_title {
    color: #28223C;
    font-size: 22px;
    font-weight: 600;
    line-height: 26px;
    max-width: 366px;
}

.news-item_date {
    color: #28223C;
    font-size: 20px;
    font-family: 'Rossika';
    font-weight: 400;
    text-transform: uppercase;
}

.news-item {
    display: flex;
    width: 100%;
    max-width: 1280px;
    width: 1280px;
    margin: 0 auto;
    gap: 50px;
}

.news-item_photo,
.news-item_description {
    width: calc(50% - 25px);
    flex: 0 0 calc(50% - 25px);
}

.news-item_photo img {
    width: 100%;
    height: auto;
    display: block;
    object-fit: cover;
}

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



.row-news_wrapper {
    display: flex;
    flex-direction: column;
    gap: 65px;
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
</style>
