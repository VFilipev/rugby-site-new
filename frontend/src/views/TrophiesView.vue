<script setup>
import AppHeader from '@/components/AppHeader.vue'
import AppFooter from '@/components/AppFooter.vue'
</script>
<template>
    <div>
        <AppHeader />
        <section class="man-team-section">
            <div class="team-container">
                <!-- Заголовок ЗАЛ СЛАВЫ -->
                <div class="section-header-wrapper"
                    style="margin-bottom: 80px; margin-top: 100px; max-width: 1280px; width: 1280px; margin-left: auto; margin-right: auto;">
                    <div class="section-item section-item--left">
                        ФЕДЕРАЦИЯ РЕГБИ
                    </div>
                    <div class="section-title">
                        ТРОФЕИ
                    </div>
                    <div class="section-item section-item--right">
                        ВИТЯЗЬ
                    </div>
                </div>

                <!-- Секция с трофеями -->
                <div class="trophies-section">
                    <div class="trophies-container">
                        <!-- Трофеи -->
                        <div class="trophies-wrapper">
                            <div class="trophy-item">
                                <div class="trophy-image">
                                    <img src="/images/trophy1.jpg" alt="Чемпионат России по регби пляжному">
                                </div>
                                <div class="trophy-title">
                                    Чемпионат России<br>по регби пляжному
                                </div>
                            </div>
                            <div class="trophy-item">
                                <div class="trophy-image">
                                    <img src="/images/trophy2.jpg" alt="Кубок России по регби пляжному">
                                </div>
                                <div class="trophy-title">
                                    Кубок России<br>по регби пляжному
                                </div>
                            </div>
                            <div class="trophy-item">
                                <div class="trophy-image">
                                    <img src="/images/trophy3.jpg" alt="Чемпионат России по регби на снегу">
                                </div>
                                <div class="trophy-title">
                                    Чемпионат России<br>по регби на снегу
                                </div>
                            </div>
                            <div class="trophy-item">
                                <div class="trophy-image">
                                    <img src="/images/trophy4.jpg" alt="Чемпионат Федеральной лиги">
                                </div>
                                <div class="trophy-title">
                                    Чемпионат Федеральной лиги
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Секция мужской команды -->
                <!-- Заголовок мужской команды -->
                <div class="section-header-wrapper">
                    <div class="section-item section-item--left">
                        ФЕДЕРАЦИЯ РЕГБИ
                    </div>
                    <div class="section-title">
                        МУЖСКАЯ
                    </div>
                    <div class="section-item section-item--right">
                        ВИТЯЗЬ
                    </div>
                </div>

                <div class="achievements-section">
                    <div class="achievements-container">
                        <!-- Десктопная версия с фото -->
                        <div class="achievements-photo d-none d-md-block">
                            <img src="/images/man-trophies.jpg" alt="Мужская команда с трофеями">
                        </div>

                        <div class="achievements-content">
                            <div class="achievements-title">
                                Достижения:
                            </div>
                            <div class="achievements-text">
                                Обладатели Кубка России по пляжному регби<br>
                                Участники Чемпионата Высшей Лиги по регби-7 2020 – 2024 гг<br>
                                Призеры Кубка России по пляжному регби 2022 г<br>
                                Серебряные призеры 1 тура Чемпионата Высшей Лиги 2020 г<br>
                                Чемпионы Приволжского Федерального округа по регби-7 2020<br>
                                Обладатели Кубка Москвы по регби на снегу<br>
                                Обладатели Кубка Пермского края по регби на снегу<br><br>

                                Игроки мужской команды входили в состав сборной России по регби-7<br><br>

                                В сезоне 2025г мужская сборная играет в Федеральной регбийной Лиге
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Мобильное фото мужской команды -->
                <div class="mobile-team-photo d-block d-md-none">
                    <img src="/images/man-trophies.jpg" alt="Мужская команда с трофеями">
                </div>

                <!-- Секция женской команды -->
                <!-- Заголовок женской команды -->
                <div class="section-header-wrapper">
                    <div class="section-item section-item--left">
                        ФЕДЕРАЦИЯ РЕГБИ
                    </div>
                    <div class="section-title">
                        ЖЕНСКАЯ
                    </div>
                    <div class="section-item section-item--right">
                        ВИТЯЗЬ
                    </div>
                </div>



                <div class="achievements-section">
                    <div class="achievements-container">
                        <div class="achievements-content">
                            <div class="achievements-title">
                                Достижения:
                            </div>
                            <div class="achievements-text">
                                В сезоне 2025г женская сборная играет в Премьер-лиге Чемпионата России по
                                регби-7<br><br>
                                Серебряные призеры Чемпионата России по пляжному регби 2024г<br>
                                Призеры Чемпионата России по регби на снегу 2024г<br>
                                Чемпионы России по снежному регби 2023г<br>
                                Трехкратные обладатели Кубка России по пляжному регби 2021, 2022, 2023 гг<br>
                                Серебряные призеры Чемпионата России по регби-7 среди студентов 2020 г<br>
                                Чемпионы России по пляжному регби 2019г<br>
                                Трехкратные Чемпионы Федеральной лиги 2016, 2017, 2018 гг.<br>
                                Лидеры международного турнира по пляжному регби "the Baltic Sea" г.Рига<br>
                                Лидеры международного регбийного турнира в Батуми<br><br>

                                Сезон 2024г команда закончила на 4 месте Премьер-Лиги Чемпионата России по
                                регби-7<br><br>

                                Игроки нашей команды в составе сборной России становились абсолютными чемпионами Европы
                                по <br> пляжному регби и регби на снегу
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Фото женской команды на всю ширину экрана -->
                <div class="woman-photo-fullwidth">
                    <img src="/images/woman-trophies.jpeg" alt="Женская команда с трофеями">
                </div>
            </div>
        </section>
        <div>
            <AppFooter />
        </div>
    </div>
</template>

<style scoped>
.achievements-title {
    font-size: 22px;
    line-height: 26px;
    color: #28223C;
    font-weight: bold;
    margin-bottom: 30px;
}

.woman-photo-fullwidth {
    width: 100vw;
    position: relative;
    left: 50%;
    right: 50%;
    margin-left: -50vw;
    margin-right: -50vw;
    margin-top: 40px;
}

.woman-photo-fullwidth img {
    width: 100%;
    height: auto;
    object-fit: cover;
    display: block;
}

.section-header-wrapper {
    display: grid;
    grid-template-columns: 1fr auto 1fr;
    align-items: center;
    height: 60px;
    margin-bottom: 80px;
    margin-top: 120px;
    max-width: 1280px;
    width: 1280px;
    margin-left: auto;
    margin-right: auto;
}

.section-item--left {
    justify-self: start;
}

.section-title {
    justify-self: center;
    line-height: 1;
}

.section-item--right {
    justify-self: end;
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

/* Стили для трофеев */
.trophies-section {
    margin-top: 60px;
    margin-bottom: 60px;
}

.trophies-container {
    max-width: 1280px;
    width: 1280px;
    margin: 0 auto;
}

.trophies-wrapper {
    display: flex;
    justify-content: space-between;
    gap: 20px;
}

.trophy-item {
    display: flex;
    flex-direction: column;
    align-items: center;
    width: calc(25% - 15px);
}

.trophy-image {
    width: 100%;
    height: 400px;
    margin-bottom: 20px;
    overflow: hidden;
}

.trophy-image img {
    width: 100%;
    height: 100%;
    object-fit: contain;
}

.trophy-title {
    font-size: 16px;
    line-height: 25px;
    color: #28223C;
    text-align: center;
    font-weight: 400;
}

/* Стили для достижений */
.achievements-section {
    margin-bottom: 100px;
}

.achievements-container {
    max-width: 1280px;
    width: 1280px;
    margin: 0 auto;
    display: flex;
    gap: 50px;
    align-items: flex-start;
}

.achievements-photo {
    flex: 0 0 50%;
    width: 50%;
}

.achievements-photo img {
    width: 100%;
    height: auto;
    object-fit: cover;
}

.achievements-text {
    font-size: 16px;
    line-height: 25px;
    color: #28223C;
    text-align: left;
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



/* Мобильная адаптация */
@media (max-width: 767.98px) {


    /* Мобильная адаптация трофеев */
    .trophies-section {
        margin-top: 40px;
        margin-bottom: 60px;
    }

    .trophies-container {
        max-width: none;
        width: 100%;
        padding: 0 30px;
    }

    .trophies-wrapper {
        display: grid;
        grid-template-columns: 1fr;
        gap: 40px;
        justify-content: center;
    }

    .trophy-item {
        width: 100%;
        display: flex;
        flex-direction: column;
        align-items: center;
    }

    .trophy-image {
        width: 100%;
        height: 200px;
        margin-bottom: 15px;
        overflow: hidden;
    }

    .trophy-image img {
        width: 100%;
        height: 100%;
        object-fit: contain;
    }

    .trophy-title {
        font-size: 16px;
        line-height: 1.56;
        color: #28223C;
        text-align: center;
        font-weight: 400;
    }

    /* Мобильная версия главного заголовка */
    .main-header {
        margin: 40px auto 60px auto !important;
        max-width: 100% !important;
        width: 100% !important;
        padding: 0 30px !important;
        display: block !important;
        text-align: center !important;
        height: auto !important;
    }

    .main-header .section-item {
        display: none !important;
    }

    .main-header .section-title {
        font-size: 40px !important;
        margin: 0;
    }

    /* Мобильные стили заголовков команд как в TeamView */
    .section-header-wrapper:not(.main-header) {
        margin: 60px auto 40px auto !important;
        max-width: 100% !important;
        width: 100% !important;
        padding: 0 30px !important;
        display: flex !important;
        flex-direction: row !important;
        align-items: center !important;
        justify-content: space-between !important;
        text-align: center !important;
        height: auto !important;
    }

    .section-header-wrapper:not(.main-header) .section-title {
        font-size: 40px !important;
        flex: 1;
        text-align: center;
    }

    .section-header-wrapper:not(.main-header) .section-item--left {
        font-size: 0;
        /* Скрываем оригинальный текст */
        flex: 0 0 auto;
        text-align: left;
    }

    .section-header-wrapper:not(.main-header) .section-item--left::before {
        content: "КЛУБ";
        font-size: 12px;
        display: block;
    }

    .section-header-wrapper:not(.main-header) .section-item--right {
        font-size: 12px;
        flex: 0 0 auto;
        text-align: right;
    }

    /* Адаптация достижений */
    .achievements-section {
        margin-bottom: 60px;
    }

    .achievements-container {
        max-width: none;
        width: 100%;
        padding: 0 30px;
        flex-direction: column;
        gap: 0;
    }

    .achievements-content {
        width: 100%;
    }

    .achievements-title {
        font-size: 18px;
        line-height: 1.11;
        color: #28223C;
        font-weight: 700;
        margin-bottom: 20px;
    }

    .achievements-text {
        font-size: 14px;
        line-height: 1.43;
        color: #28223C;
        text-align: left;
    }

    .mobile-team-photo {
        width: 100vw;
        position: relative;
        left: 50%;
        right: 50%;
        margin-left: -50vw;
        margin-right: -50vw;
        margin-top: 40px;
        margin-bottom: 60px;
    }

    .mobile-team-photo img {
        width: 100%;
        height: auto;
        object-fit: cover;
        display: block;
    }

    .woman-photo-fullwidth {
        margin-top: 40px;
    }

    /* Скрываем десктопные отступы на мобильной версии */
    .team-container>div:last-child {
        margin-top: 60px !important;
    }
}
</style>
