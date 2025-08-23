
<template>
  <VDatePicker
    v-model="selectedDate"
    :min-date="today"
    :disabled-dates="disabledDates"
    :first-day-of-week="2" 
    locale="en"  
    is-required
  />
</template>

<script setup lang="ts">
import { ref } from 'vue'

const selectedDate = ref<Date | null>(null)

const today = new Date()
today.setHours(0, 0, 0, 0)

const disabledDates = [{ repeat: { weekdays: [1] } }]
</script>


<style lang="scss">

</style>