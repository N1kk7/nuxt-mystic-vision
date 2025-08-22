import { defineNuxtPlugin } from 'nuxt/app'
import VCalendar from 'v-calendar'
// import VTimePicker from 'v-calendar/dist/components/VTimePicker'
import 'v-calendar/dist/style.css'

export default defineNuxtPlugin((nuxtApp) => {
  nuxtApp.vueApp.use(VCalendar)                  
  // nuxtApp.vueApp.component('VTimePicker', VTimePicker) 
})