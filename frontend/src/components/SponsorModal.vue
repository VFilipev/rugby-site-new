<template>
    <div v-if="isOpen" class="modal-overlay" @click="closeModal">
        <div class="modal-container" @click.stop>
            <div class="modal-content">
                <form @submit.prevent="submitForm" class="sponsor-form">
                    <div class="form-group">
                        <div class="input-wrapper">
                            <input type="text" v-model="form.organization" class="form-input" placeholder=" " required>
                            <label class="form-label">организация</label>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="input-wrapper">
                            <input type="text" v-model="form.contacts" class="form-input" placeholder=" " required>
                            <label class="form-label">контакты</label>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="input-wrapper textarea-wrapper">
                            <textarea v-model="form.supportType" class="form-textarea" placeholder=" " rows="4" required></textarea>
                            <label class="form-label">вид поддержки</label>
                        </div>
                    </div>

                    <button type="submit" class="submit-button">
                        СТАТЬ СПОНСОРОМ
                    </button>
                </form>
            </div>
        </div>
    </div>
</template>

<script setup>
import { ref, watch, onMounted, onUnmounted } from 'vue'
import { useToast } from "vue-toastification"

// Props
const props = defineProps({
    isOpen: {
        type: Boolean,
        default: false
    }
})

// Emits
const emit = defineEmits(['close'])

// Toast
const toast = useToast()

// Form data
const form = ref({
    organization: '',
    contacts: '',
    supportType: ''
})

// Methods
const closeModal = () => {
    emit('close')
    // Очищаем форму
    form.value = {
        organization: '',
        contacts: '',
        supportType: ''
    }
}

const submitForm = () => {
    // Закрываем модальное окно
    closeModal()

    // Показываем уведомление об успешной отправке
    toast.success("Заявка отправлена! Спасибо за интерес к спонсорству. Мы свяжемся с вами в ближайшее время.", {
        timeout: 5000
    })
}

const handleEscape = (event) => {
    if (event.key === 'Escape') {
        closeModal()
    }
}

// Watch для управления скроллом body
watch(() => props.isOpen, (newValue) => {
    if (newValue) {
        // Просто блокируем скролл без изменения позиции
        document.body.style.overflow = 'hidden'
    } else {
        // Возвращаем скролл
        document.body.style.overflow = 'auto'
    }
})

// Добавляем обработчик ESC при монтировании
onMounted(() => {
    document.addEventListener('keydown', handleEscape)
})

// Очистка при уничтожении компонента
onUnmounted(() => {
    document.removeEventListener('keydown', handleEscape)
    if (props.isOpen) {
        document.body.style.overflow = 'auto'
    }
})
</script>

<style scoped>
/* Modal styles */
.modal-overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.6);
    display: flex;
    justify-content: center;
    align-items: center;
    z-index: 9999;
    opacity: 0;
    animation: fadeIn 0.3s ease-out forwards;
}

@keyframes fadeIn {
    to {
        opacity: 1;
    }
}

.modal-container {
    background: white;
    max-width: 632px;
    width: 90%;
    max-height: 90vh;
    overflow-y: auto;
    transform: scale(0.9);
    animation: scaleIn 0.3s ease-out forwards;
}

@keyframes scaleIn {
    to {
        transform: scale(1);
    }
}

.modal-content {
    padding: 80px;
}

.modal-title {
    font-family: 'Golos Text', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
    font-size: 22px;
    font-weight: 700;
    color: #28223C;
    text-align: center;
    margin-bottom: 40px;
    line-height: 1.18;
}

.sponsor-form {
    display: flex;
    flex-direction: column;
    gap: 10px;
}

.form-group {

}

.input-wrapper {
    position: relative;
    width: 100%;
}

.textarea-wrapper {
    height: 121px;
}

.form-input,
.form-textarea {
    width: 100%;
    height: 60px;
    border: 2px solid #28223C;
    background: #FFFFFF;
    padding: 20px;
    font-family: 'Golos Text', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
    font-size: 16px;
    line-height: 25px;
    color: #28223C;
    box-sizing: border-box;
    outline: none;
}

.form-textarea {
    height: 121px;
    resize: none;
    padding-top: 20px;
}

.form-input:focus,
.form-textarea:focus {
    border-color: #ED1B26;
}

.form-label {
    position: absolute;
    left: 20px;
    top: 50%;
    transform: translateY(-50%);
    font-family: 'Golos Text', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
    font-size: 16px;
    line-height: 25px;
    color: #28223C;
    pointer-events: none;
    transition: all 0.2s ease-out;
    background: #FFFFFF;
    padding: 0 4px;
}

.textarea-wrapper .form-label {
    top: 30px;
    transform: translateY(0);
}

.form-input:focus+.form-label,
.form-input:not(:placeholder-shown)+.form-label,
.form-textarea:focus+.form-label,
.form-textarea:not(:placeholder-shown)+.form-label {
    top: 0;
    transform: translateY(-50%);
    font-size: 14px;
    color: #ED1B26;
}

.submit-button {
    background-color: #ED1B26;
    color: white;
    border: none;
    height: 46px;
    font-family: 'Golos Text', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
    font-size: 14px;
    font-weight: 400;
    cursor: pointer;
    transition: background-color 0.3s ease;
    margin-top: 20px;
    align-self: center;
    width: 188px;
}

.submit-button:hover {
    background-color: #d41620;
}

/* Responsive modal */
@media (max-width: 768px) {
    .modal-container {
        width: 95%;
        margin: 20px;
    }

    .modal-content {
        padding: 30px 20px;
    }

    .modal-title {
        font-size: 20px;
        margin-bottom: 30px;
    }

    .submit-button {
        width: 100%;
    }
}
</style>
