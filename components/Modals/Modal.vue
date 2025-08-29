<template>
  <div v-if="isVisible" class="modal-overlay" @click.self="closeModal">
    <div class="modal-content max-h-[100vh] overflow-y-auto">
      <slot :openModal="openModal" :closeModal="closeModal" />
      <component
        v-if="currentModal"
        :is="modalComponents[currentModal]"
        v-bind="modalProps"
        :openModal="openModal"
        :closeModal="closeModal"
      />
    </div>
  </div>
</template>


<script setup>
import { computed } from 'vue'
import { useModalStore } from '#imports'

import ModalMain from '../booking/ModalMain.vue'
import Reminder from './Reminder.vue';

//admin

import BookingDetails from './admin/BookingDetails.vue';

const modalStore = useModalStore();
const isVisible = computed(() => modalStore.isVisible);
const currentModal = computed(() => modalStore.currentModal);
const modalProps = computed(() => modalStore.modalProps);

const closeModal = () => {
  modalStore.closeModal();
};
const openModal = (modalName, props = {}) => {
  modalStore.showModal(modalName, props);
};

const modalComponents = {
    //admin
  BookingDetails,

  //main
  ModalMain,
  Reminder
}

</script>



<style>
.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100vw;
  height: 100vh;
  background: rgba(0, 0, 0, 0.5);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 1000;
}
.modal-content {
  background: white;
  padding: 10px;
  border-radius: 10px;
  overflow-x: hidden;
}
</style>