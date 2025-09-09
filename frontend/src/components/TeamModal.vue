<template>
    <div v-if="isOpen" class="modal-overlay" @click="handleOverlayClick">
        <div class="modal-content" @click.stop>
            <!-- <div class="modal-header">
                <h2 class="modal-title">ХОЧУ В КОМАНДУ</h2>
            </div> -->

            <form @submit.prevent="submitForm" class="modal-form">
                <div class="form-group">
                    <div class="input-wrapper">
                        <input v-model="formData.name" type="text" class="form-input" placeholder=" " required>
                        <label class="form-label">имя</label>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group form-group-half">
                        <div class="input-wrapper">
                            <input v-model="formData.age" type="number" class="form-input" placeholder=" " required>
                            <label class="form-label">возраст</label>
                        </div>
                    </div>

                    <div class="form-group form-group-half">
                        <div class="input-wrapper">
                            <input v-model="formData.contact" type="text" class="form-input" placeholder=" " required>
                            <label class="form-label">телефон / tg</label>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-wrapper textarea-wrapper">
                        <textarea v-model="formData.experience" class="form-textarea" placeholder=" " rows="4"
                            required></textarea>
                        <label class="form-label">спортивный опыт</label>
                    </div>
                </div>

                <button type="submit" class="submit-btn">
                    ОТПРАВИТЬ
                </button>
            </form>
        </div>
    </div>
</template>

<script setup>
import { ref, onMounted, onUnmounted, watch } from 'vue'
import { useToast } from 'vue-toastification'

const props = defineProps({
    isOpen: {
        type: Boolean,
        required: true
    }
})

const emit = defineEmits(['close'])

const toast = useToast()

const formData = ref({
    name: '',
    age: '',
    contact: '',
    experience: ''
})

const closeModal = () => {
    emit('close')
}

const handleOverlayClick = (event) => {
    if (event.target === event.currentTarget) {
        closeModal()
    }
}

const handleEscape = (event) => {
    if (event.key === 'Escape') {
        closeModal()
    }
}

const submitForm = () => {
    // Здесь можно добавить логику отправки формы

    // Показываем уведомление об успешной отправке
    toast.success('Заявка успешно отправлена!')

    // Сбрасываем форму
    formData.value = {
        name: '',
        age: '',
        contact: '',
        experience: ''
    }

    // Закрываем модальное окно
    closeModal()
}

onMounted(() => {
    document.addEventListener('keydown', handleEscape)
    if (props.isOpen) {
        document.body.style.overflow = 'hidden'
    }
})

onUnmounted(() => {
    document.removeEventListener('keydown', handleEscape)
    document.body.style.overflow = ''
})

// Блокируем скролл при открытии/закрытии модального окна
watch(() => props.isOpen, (newValue) => {
    if (newValue) {
        document.body.style.overflow = 'hidden'
    } else {
        document.body.style.overflow = ''
    }
})
</script>

<style scoped>
.modal-overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
    display: flex;
    justify-content: center;
    align-items: center;
    z-index: 1000;
    animation: fadeIn 0.3s ease-out;
}

.modal-content {
    background: #FFFFFF;
    width: 632px;
    position: relative;
    animation: scaleIn 0.3s ease-out;
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
}



.modal-header {
    display: flex;
    justify-content: center;
    padding-top: 63px;
    text-align: center;
    margin-bottom: 50px;
}

.modal-title {
    font-family: 'Golos Text', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
    font-weight: 700;
    font-size: 22px;
    line-height: 26px;
    color: #28223C;
    margin: 0;
}

.modal-form {
    padding: 80px;
}

.form-group {
    margin-bottom: 10px;
}

.form-row {
    display: flex;
    gap: 8px;
    margin-bottom: 10px;
}

.form-group-half {
    flex: 1;
    margin-bottom: 0;
}

.form-group-half:first-child {
    flex: 0 0 149px;
}

.form-group-half:last-child {
    flex: 0 0 315px;
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
    color: rgba(27, 0, 71, 0.5);
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

.submit-btn {
    width: 188px;
    height: 46px;
    background: #ED1B26;
    border: none;
    font-family: 'Golos Text', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
    font-weight: 500;
    font-size: 16px;
    line-height: 18px;
    color: #FFFFFF;
    cursor: pointer;
    margin: 50px auto 0;
    display: block;
    transition: background-color 0.2s ease;
}

.submit-btn:hover {
    background: #d91825;
}

@keyframes fadeIn {
    from {
        opacity: 0;
    }

    to {
        opacity: 1;
    }
}

@keyframes scaleIn {
    from {
        opacity: 0;
        transform: scale(0.9);
    }

    to {
        opacity: 1;
        transform: scale(1);
    }
}

/* Мобильная адаптация */
@media (max-width: 768px) {
    .modal-content {
        width: 90%;
        max-width: 600px;
        height: auto;
        max-height: 90vh;
        overflow-y: auto;
    }

    .modal-form {
        padding: 0 30px;
    }

    .form-row {
        flex-direction: column;
        gap: 11px;
    }

    .form-group-half {
        flex: none;
    }

    .form-group-half:first-child,
    .form-group-half:last-child {
        flex: none;
    }

    .submit-btn {
        margin-bottom: 50px;
    }
}
</style>
