<script setup>
import { ref, onMounted, nextTick, watch } from 'vue'
import { useRoute } from 'vue-router'
import TeamModal from '@/components/TeamModal.vue'
import AppHeader from '@/components/AppHeader.vue'
import AppFooter from '@/components/AppFooter.vue'
import { Players } from '@/api'
const manPlayersList = ref([])
const womanPlayersList = ref([])
const getManPlayersList = async () => {
    const response = await Players.getList({team: 1, ordering: 'order'})
    manPlayersList.value = response
}
const getWomanPlayersList = async () => {
    const response = await Players.getList({team: 2, ordering: 'order'})
    womanPlayersList.value = response
}
// Router
const route = useRoute()

// Modal state
const isTeamModalOpen = ref(false)

const openTeamModal = () => {
    isTeamModalOpen.value = true
}

const closeTeamModal = () => {
    isTeamModalOpen.value = false
}

// Функция прокрутки к секции по хешу
const scrollToSection = (hash) => {
    if (!hash) return

    let selector = ''
    if (hash === '#man') {
        selector = '.section-header-wrapper.man'
    } else if (hash === '#woman') {
        selector = '.section-header-wrapper.woman'
    }

    if (selector) {
        const element = document.querySelector(selector)
        if (element) {
            element.scrollIntoView({
                behavior: 'smooth',
                block: 'start'
            })
        }
    }
}

// Watcher для отслеживания изменений в маршруте
watch(() => route.hash, (newHash) => {
    if (newHash) {
        nextTick(() => {
            setTimeout(() => {
                scrollToSection(newHash)
            }, 100)
        })
    }
}, { immediate: true })

// Обработка хеша при монтировании компонента
onMounted(() => {
    getManPlayersList()
    getWomanPlayersList()
    nextTick(() => {
        if (route.hash) {
            setTimeout(() => {
                scrollToSection(route.hash)
            }, 100) // Небольшая задержка для завершения рендеринга
        }
    })
})

</script>
<template>
    <div>
        <AppHeader />
        <section class="man-team-section">
            <div class="team-container">
                <div class="section-header-wrapper man">
                    <div class="section-item section-item--left">
                        ФЕДЕРАЛЬНАЯ ЛИГА
                    </div>
                    <div class="section-title">
                        МУЖСКАЯ
                    </div>
                    <div class="section-item section-item--right">
                        КОМАНДА
                    </div>
                </div>
                <div class="row-team_wrapper d-flex flex-wrap">
                    <div class="player">
                        <div class="photo">
                            <img src="/images/pl1.png" alt="pl1">
                        </div>
                        <div class="name-wrapper d-flex justify-content-between">
                            <div class="name">
                                Артем <br> Садаев
                            </div>
                            <div class="amplua">
                                тренер
                            </div>
                        </div>
                    </div>
                    <div class="player" v-for="player in manPlayersList" :key="player.id + 'man'">
                        <div class="photo">
                            <img :src="player.photo" alt="pl1">
                        </div>
                        <div class="name-wrapper d-flex justify-content-between">
                            <div class="name">{{ player.full_name }}</div>
                            <div class="amplua">{{ player.staff_type_name || '' }}</div>
                        </div>
                    </div>
                </div>
                <div class="man-team-action-wrapper">
                    <div class="man-team-action_title">
                        Ведется набор в мужскую
                        сборную Пермского края!
                    </div>
                    <div class="man-team-action_btn" @click="openTeamModal">
                        ХОЧУ В КОМАНДУ!
                    </div>
                </div>
                <div class="section-header-wrapper woman"
                    style="margin-bottom: 80px; margin-top: 100px; max-width: 1280px; width: 1280px; margin-left: auto; margin-right: auto;">
                    <div class="section-item section-item--left">
                        ПРЕМЬЕР ЛИГА
                    </div>
                    <div class="section-title">
                        ЖЕНСКАЯ
                    </div>
                    <div class="section-item section-item--right">
                        КОМАНДА
                    </div>
                </div>
                <div class="row-team_wrapper d-flex flex-wrap">
                    <div class="player">
                        <div class="photo">
                            <img src="/images/plw1.png" alt="pl1">
                        </div>
                        <div class="name-wrapper d-flex justify-content-between">
                            <div class="name">
                                Ислам <br>Гарифуллин
                            </div>
                            <div class="amplua">
                                тренер
                            </div>
                        </div>
                    </div>
                    <div class="player" v-for="player in womanPlayersList" :key="player.id + 'woman'">
                        <div class="photo">
                            <img :src="player.photo" alt="pl1">
                        </div>
                        <div class="name-wrapper d-flex justify-content-between">
                            <div class="name">{{ player.full_name }}</div>
                            <div class="amplua">{{ player.staff_type_name || '' }}</div>
                        </div>
                    </div>
                </div>
                <div class="man-team-action-wrapper">
                    <div class="man-team-action_title">
                        Ведется набор в женскую
                        сборную Пермского края!
                    </div>
                    <div class="man-team-action_btn" @click="openTeamModal">
                        ХОЧУ В КОМАНДУ!
                    </div>
                </div>
                <!-- Десктопная версия заголовка дирекции -->
                <div class="section-header-wrapper directorate-header-desktop">
                    <div class="section-item section-item--left">
                        ФЕДЕРАЦИЯ РЕГБИ
                    </div>
                    <div class="section-title">
                        ДИРЕКЦИЯ
                    </div>
                    <div class="section-item section-item--right">
                        КЛУБ ВИТЯЗЬ
                    </div>
                </div>

                <!-- Мобильная версия заголовка дирекции -->
                <div class="section-header-wrapper directorate-header-mobile">
                    <div class="section-title">
                        ДИРЕКЦИЯ
                    </div>
                </div>
                <div class="directorate-wrapper directorate-desktop">
                    <div class="directorate-item">
                        <div class="directorate-item_photo">
                            <img src="/images/dir1.jpg" alt="dir1">
                        </div>
                        <div class="directorate-item_description">
                            <div class="directorate-item_name">
                                Алексей <br> Конев
                            </div>
                            <div class="directorate-item_post">
                                Президент Федерации регби Пермского края
                            </div>
                        </div>
                    </div>
                    <div class="directorate-item">
                        <div class="directorate-item_photo">
                            <img src="/images/dir2.jpg" alt="dir1">
                        </div>
                        <div class="directorate-item_description">
                            <div class="directorate-item_name">
                                Кирилл <br> Тропинин
                            </div>
                            <div class="directorate-item_post" style="width: 293px;">
                                Директор регби-клуба "Витязь" исполнительный Директор Федерации регби Пермского края
                            </div>
                        </div>
                    </div>
                </div>
                <div class="directorate-wrapper directorate-desktop" style="margin-top: 50px;">
                    <div class="directorate-item">
                        <div class="directorate-item_photo">
                            <img src="/images/dir3.jpg" alt="dir1">
                        </div>
                        <div class="directorate-item_description">
                            <div class="directorate-item_name">
                                Анастасия <br> Ворончихина
                            </div>
                            <div class="directorate-item_post">
                                заместитель исполнительного директора Федерации регби Пермского края
                            </div>
                        </div>
                    </div>
                    <div class="directorate-item">
                        <div class="directorate-item_photo">
                            <img src="/images/dir4.jpg" alt="dir1">
                        </div>
                        <div class="directorate-item_description">
                            <div class="directorate-item_name">
                                Василий <br> Вахрин
                            </div>
                            <div class="directorate-item_post" style="width: 293px;">
                                пресс-центр
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Мобильная версия дирекции -->
                <div class="directorate-mobile">
                    <div class="directorate-mobile-item">
                        <div class="directorate-mobile-photo">
                            <img src="/images/dir1.jpg" alt="Алексей Конев">
                        </div>
                        <div class="directorate-mobile-description">
                            <div class="directorate-mobile-name">
                                Алексей Конев
                            </div>
                            <div class="directorate-mobile-post">
                                Президент Федерации регби Пермского края
                            </div>
                        </div>
                    </div>

                    <div class="directorate-mobile-item">
                        <div class="directorate-mobile-photo">
                            <img src="/images/dir2.jpg" alt="Кирилл Тропинин">
                        </div>
                        <div class="directorate-mobile-description">
                            <div class="directorate-mobile-name">
                                Кирилл Тропинин
                            </div>
                            <div class="directorate-mobile-post">
                                Директор регби-клуба "Витязь" исполнительный Директор Федерации регби Пермского края
                            </div>
                        </div>
                    </div>

                    <div class="directorate-mobile-item">
                        <div class="directorate-mobile-photo">
                            <img src="/images/dir3.jpg" alt="Анастасия Ворончихина">
                        </div>
                        <div class="directorate-mobile-description">
                            <div class="directorate-mobile-name">
                                Анастасия Ворончихина
                            </div>
                            <div class="directorate-mobile-post">
                                заместитель исполнительного директора Федерации регби Пермского края
                            </div>
                        </div>
                    </div>

                    <div class="directorate-mobile-item">
                        <div class="directorate-mobile-photo">
                            <img src="/images/dir4.jpg" alt="Василий Вахрин">
                        </div>
                        <div class="directorate-mobile-description">
                            <div class="directorate-mobile-name">
                                Василий Вахрин
                            </div>
                            <div class="directorate-mobile-post">
                                пресс-центр
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <div style="margin-top: 100px;">
            <AppFooter />
        </div>

        <!-- Модальное окно заявки в команду -->
        <TeamModal :isOpen="isTeamModalOpen" @close="closeTeamModal" />
    </div>
</template>
<style scoped>
.directorate-wrapper {
    width: 973px;
    margin: 0 auto;
    display: flex;
    justify-content: space-between;
}

/* Блоки дирекции */
.directorate-desktop {
    display: none;
}

.directorate-mobile {
    display: flex;
}

/* Показываем десктопную версию на планшетах и выше */
@media (min-width: 768px) {
    .directorate-desktop {
        display: flex !important;
    }

    .directorate-mobile {
        display: none !important;
    }
}

.directorate-item_post {
    font-size: 16px;
    line-height: 25px;
    width: 180px;
}

.directorate-item_name {
    font-size: 22px;
    line-height: 26px;
    color: #28223C;
}

.directorate-item_description {
    display: flex;
    flex-direction: column;
    gap: 30px;
}

.directorate-item {
    display: flex;
    gap: 51px
}

.man-team-action_btn {
    background-color: #ED1B26;
    padding-left: 15px;
    padding-right: 15px;
    padding-top: 10px;
    padding-bottom: 10px;
    font-size: 16px;
    color: #fff;
}

.man-team-action_title {
    font-size: 22px;
    line-height: 26px;
    color: #28223C;
    font-weight: bold;
}

.man-team-action_btn:hover {
    cursor: pointer;
}

.man-team-action-wrapper {
    width: 289px;
    margin: 0 auto;
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 30px;
}

.amplua {
    font-family: 'Golos Text', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
    font-weight: 500;
    font-size: 10px;
    line-height: 1.2;
    letter-spacing: 0.02em;
    color: #28223C;
    text-transform: uppercase;
    text-align: right;
}

.name {
    font-family: 'Golos Text', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
    font-weight: 500;
    font-size: 16px;
    line-height: 1.05;
    color: #28223C;
    word-spacing: 100vw;
}

.name-wrapper {
    position: absolute;
    bottom: 17px;
    left: 20px;
    right: 20px;
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    background: none;
    height: auto;
    padding: 0;
    width: auto;
}

.row-team_wrapper {
    max-width: 1280px;
    width: 1280px;
    margin: 0 auto;
    column-gap: 93px;
    row-gap: 50px;
    margin-bottom: 40px;
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
    line-height: 0.7;
}



.header-container {
    max-width: 1280px;
    width: 1280px;
    margin: 0 auto;
    padding-top: 30px;
    padding-bottom: 33px;
}

.header-wrapper {
    background-color: #28223C;
}

.player {
    width: 250px;
    height: 380px;
    margin-bottom: 40px;
    position: relative;
    background-color: rgba(40, 34, 60, 0.05);
}

.photo {
    width: 218px;
    height: 291px;
    overflow: hidden;
    margin: 19px 16px 0 16px;
    position: relative;
}

.photo img {
    width: 100%;
    height: 100%;
    object-fit: contain;
    object-position: center bottom;
}

.player::after {
    content: '';
    position: absolute;
    top: 310px;
    /* 19px (margin-top фото) + 291px (высота фото) */
    left: 0;
    right: 0;
    height: 3px;
    background-color: #28223C;
}

.section-header-wrapper {
    margin-bottom: 80px;
    margin-top: 120px;
    max-width: 1280px;
    width: 1280px;
    margin-left: auto;
    margin-right: auto;
    display: grid;
    grid-template-columns: 1fr auto 1fr;
    align-items: center;
}

/* Заголовки дирекции - важный приоритет для переопределения общих правил */
.section-header-wrapper.directorate-header-desktop {
    display: none !important;
}

.section-header-wrapper.directorate-header-mobile {
    display: flex !important;
    justify-content: center !important;
    align-items: center !important;
    text-align: center !important;
    grid-template-columns: none !important;
}

/* Показываем десктопную версию на планшетах и выше */
@media (min-width: 768px) {
    .section-header-wrapper.directorate-header-desktop {
        display: grid !important;
    }

    .section-header-wrapper.directorate-header-mobile {
        display: none !important;
    }
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

/* Mobile Styles */
@media (max-width: 767.98px) {

    .team-container {
        padding: 0 20px;
    }

    .section-header-wrapper {
        margin: 0px auto 60px auto !important;
        padding-top: 60px;
        max-width: 100% !important;
        width: 100% !important;
        display: flex !important;
        flex-direction: row !important;
        align-items: center !important;
        justify-content: center !important;
        text-align: center !important;
        height: auto !important;
    }

    /* Первая секция заголовка */
    .man-team-section .section-header-wrapper:first-of-type {
        margin-top: 0px !important;
        padding-top: 40px;
    }

    .section-title {
        font-size: 40px !important;
        text-align: center;
    }

    /* Скрываем боковые элементы на мобильных */
    .section-item--left,
    .section-item--right {
        display: none !important;
    }

    /*
    .section-item--left {
        font-size: 12px;
        flex: 0 0 auto;
        text-align: left;
    }

    .section-item--left {
        font-size: 0;
    }

    .section-item--left::before {
        content: "2025/26";
        font-size: 12px;
        display: block;
    }

    .section-item--right {
        font-size: 12px;
        flex: 0 0 auto;
        text-align: right;
    }
    */

    .row-team_wrapper {
        max-width: 100%;
        width: 100%;
        margin: 0 auto;
        display: flex;
        flex-direction: column;
        align-items: center;
        column-gap: 0;
        row-gap: 40px;
    }

    .player {
        width: 277px;
        height: 420px;
        margin-bottom: 0;
        background-color: rgba(40, 34, 60, 0.05);
        position: relative;
    }

    .photo {
        width: 257px;
        height: 350px;
        overflow: hidden;
        margin: 10px 10px 0 10px;
        position: relative;
    }

    .photo img {
        width: 100%;
        height: 100%;
        object-fit: contain;
        object-position: center bottom;
    }

    .player::after {
        content: '';
        position: absolute;
        top: 360px;
        /* 10px (margin-top фото) + 350px (высота фото) */
        left: 0;
        right: 0;
        height: 3px;
        background-color: #28223C;
    }

    .name-wrapper {
        position: absolute;
        bottom: 9px;
        left: 20px;
        right: 20px;
        display: flex;
        justify-content: space-between;
        align-items: flex-start;
        background: none;
        height: auto;
        padding: 0;
        width: auto;
    }

    .name {
        font-family: 'Golos Text', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
        font-weight: 500;
        font-size: 18px;
        line-height: 1.05;
        color: #28223C;
    }

    .amplua {
        font-family: 'Golos Text', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
        font-weight: 500;
        font-size: 12px;
        line-height: 1.2;
        letter-spacing: 0.02em;
        color: #28223C;
        text-transform: uppercase;
        text-align: right;
    }

    .man-team-action-wrapper {
        width: 100%;
        max-width: 320px;
        margin: 60px auto 0px auto;
        padding: 0 20px;
    }

    .man-team-action_title {
        font-size: 18px;
        line-height: 22px;
        text-align: center;
        max-width: 280px;
    }

    .man-team-action_btn {
        width: 220px;
        height: 46px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 14px;
        font-weight: 500;
    }

    /* Мобильная версия дирекции */
    .directorate-mobile {
        width: 100%;
        margin: 80px auto 0 auto;
        padding: 0 20px;
        flex-direction: column;
        gap: 40px;
    }

    .directorate-mobile-item {
        display: flex;
        gap: 20px;
        align-items: flex-start;
    }

    .directorate-mobile-photo {
        flex: 0 0 130px;
        width: 130px;
        height: 135px;
        overflow: hidden;
    }

    .directorate-mobile-photo img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }

    .directorate-mobile-description {
        flex: 1;
        display: flex;
        flex-direction: column;
        gap: 12px;
    }

    .directorate-mobile-name {
        font-size: 18px;
        font-weight: 500;
        line-height: 1.2;
        color: #28223C;
    }

    .directorate-mobile-post {
        font-size: 14px;
        line-height: 1.4;
        color: #666;
    }

}
</style>
