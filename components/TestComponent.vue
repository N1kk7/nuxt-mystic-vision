<template>

    <div class="test_component">
        <button 
            class="schedule"
            @click="modalStore.showModal('ModalMain')"
        >
            Schedule feature
        </button>
        <!-- <BookingMain/> -->
    </div>


</template>


<script setup >
// import BookingMain from '@/components/booking/ModalMain.vue'


// import { useModalStore } from '@/stores/modal-store' 
// import BookingMain from '@/components/booking/main.vue';

const modalStore = useModalStore()

// const openModal = () => {
//   modalStore.showModal(BookingMain, {})
// }

</script>


<style scoped lang="scss">

    .test_component{
        width: 100vw;
        height: 100vh;
        display: flex;;
        justify-content: center;
        align-items: center;

        .schedule{
            background: var(--text-color);
            color: white;
            padding: 1em 2em;
            border-radius: 10px;
        }
    }

</style>