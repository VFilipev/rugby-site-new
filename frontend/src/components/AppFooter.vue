<template>
    <footer>
        <div class="footer-wrapper">
            <div class="footer-container">
                <div class="row p-0">
                    <div class="col-2">
                        <img src="@/assets/footer_logo.svg" alt="logo">
                    </div>
                    <div class="col-4">
                        <div class="contact-wrapper">
                            <div class="footer-title_contacts">
                                КОНТАКТЫ
                            </div>
                            <div class="contacts-center">
                                <div class="contact-row d-flex">
                                    <div class="contact-item_icon">
                                        <a href="mailto:region59@rugby.ru" target="_blank" rel="noopener noreferrer">
                                            <img src="@/assets/footer-icon_mail.svg" alt="icon_mail">
                                        </a>
                                    </div>
                                    <div class="contact-item_text">
                                        <a href="mailto:region59@rugby.ru" target="_blank" rel="noopener noreferrer"
                                            class="contact-link">
                                            region59@rugby.ru
                                        </a>
                                    </div>
                                </div>
                                <div class="contact-row d-flex">
                                    <div class="contact-item_icon">
                                        <a href="https://t.me/rugbyprm" target="_blank" rel="noopener noreferrer">
                                            <img src="@/assets/footer-icon_tg.svg" alt="icon_mail">
                                        </a>
                                    </div>
                                    <div class="contact-item_text">
                                        <a href="https://t.me/rugbyprm" target="_blank" rel="noopener noreferrer"
                                            class="contact-link">
                                            @rugbyprm
                                        </a>
                                    </div>
                                </div>
                                <div class="contact-row d-flex">
                                    <div class="contact-item_icon">
                                        <a href="https://vk.com/vityaz_rugby" target="_blank" rel="noopener noreferrer">
                                            <img src="@/assets/footer-icon_vk.svg" alt="icon_mail">
                                        </a>
                                    </div>
                                    <div class="contact-item_text vk">
                                        <a href="https://vk.com/vityaz_rugby" target="_blank" rel="noopener noreferrer"
                                            class="contact-link">
                                            vityaz_rugby
                                        </a>
                                        <br>
                                        <span class="vk-second">
                                            <a href="https://vk.com/rugbyprm" target="_blank" rel="noopener noreferrer"
                                                class="contact-link">
                                                rugbyprm
                                            </a>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="col-6 pe-lg-0">
                        <div class="footer-title_sponsors">
                            СПОНСОРЫ
                        </div>
                        <div class="row-sponsors_icon d-flex align-items-center justify-content-between">
                            <div class="d-flex">
                                <div class="sponsors_icon">
                                    <a href="https://www.eurochem.ru/" target="_blank" rel="noopener noreferrer"
                                        @click="openEuroChem">
                                        <img src="@/assets/footer-icon_eurochem.svg" alt="footer-icon_eurochem">
                                    </a>
                                </div>
                                <div class="sponsors_icon" style="margin-left: 51px;">
                                    <a href="https://rugby.ru/" target="_blank" rel="noopener noreferrer"
                                        @click="openRugbyRussia">
                                        <img src="@/assets/footer-icon_rugby.svg" alt="footer-icon_rugby">
                                    </a>
                                </div>
                            </div>
                            <div class="sponsor-btn" @click="openSponsorModal">
                                СТАТЬ СПОНСОРОМ!
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </footer>

    <!-- Модальное окно спонсора -->
    <SponsorModal :is-open="isSponsorModalOpen" @close="closeSponsorModal" />
</template>

<script setup>
import { ref } from 'vue'
import SponsorModal from './SponsorModal.vue'

const isSponsorModalOpen = ref(false)

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
</script>

<style scoped>
.sponsor-btn {
    background-color: #ED1B26;
    padding-left: 15px;
    padding-right: 15px;
    padding-top: 10px;
    padding-bottom: 10px;
    font-size: 16px;
    color: #fff;
    height: 46px;
    margin-left: 85px;
    cursor: pointer;
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

.contact-item_text.vk {
    margin-left: 12px;
}

.contact-link {
    color: white;
    text-decoration: none;
    transition: color 0.3s ease;
}

.contact-link:hover {
    color: #ED1B26;
}

.sponsors_icon a {
    display: inline-block;
    transition: transform 0.3s ease;
    cursor: pointer;
}

.sponsors_icon a:hover {
    transform: scale(1.05);
}

.sponsors_icon img {
    display: block;
    max-width: 100%;
    height: auto;
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

/* Footer mobile styles */
@media (max-width: 1024px) {
    .footer-container {
        width: 100%;
        padding: 40px 20px;
    }
}

@media (max-width: 768px) {
    .footer-container {
        text-align: center;
    }

    .footer-container .row {
        flex-direction: column;
        gap: 40px;
        align-items: center;
    }

    .footer-container .col-2 {
        width: 100%;
        max-width: 100%;
        flex: none;
        order: 1;
    }

    .footer-container .col-4 {
        width: 100%;
        max-width: 100%;
        flex: none;
        order: 2;
    }

    .footer-container .col-6 {
        width: 100%;
        max-width: 100%;
        flex: none;
        order: 3;
    }

    .contacts-center {
        width: fit-content;
        margin: 0 auto;
    }

    .footer-title_contacts {
        display: none;
    }

    .footer-title_sponsors {
        display: none;
    }

    .row-sponsors_icon {
        justify-content: space-between;
    }

    .row-sponsors_icon .d-flex {
        gap: 0;
        width: 100%;
        justify-content: space-between;
    }

    .sponsors_icon {
        margin-left: 0 !important;
    }

    .sponsor-btn {
        display: none;
    }

    /* Размеры логотипов для мобильной версии */
    .footer-container .col-2 img {
        width: 100px;
        height: auto;
    }

    .sponsors_icon img {
        height: 55px;
        width: auto;
    }

    .contact-item_icon img {
        width: 20px;
        height: 20px;
    }

    /* Исправление выравнивания VK контактов */
    .vk-second {
        display: block;
        margin-left: 0;
        text-align: left;
    }

    .contact-row {
        align-items: flex-start;
    }
}
</style>
