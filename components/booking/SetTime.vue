<template>
  <div class="slot_wrapper">
    <div v-if="slots.length">
      <!-- <h3>Слоты:</h3> -->
      <ul class="slot_list">
        <li class="slot_item" v-for="slot in slots" :key="slot.utc"
          :class="{ active_slot: activeSlot === slot.utc }"
        >
          <button 
            @click="(e) => selectTimeHandler(slot)"
          >
            {{ slot.local }}


          </button>
          <!-- Мексика: {{ slot.mexico }} | Локально: {{ slot.local }} | UTC: {{ slot.utc }} -->
        </li>
      </ul>
    </div>
  </div>
</template>

<script setup lang="ts">
  import { ref, computed } from "vue"
  import dayjs from "dayjs"
  import utc from "dayjs/plugin/utc"
  import timezone from "dayjs/plugin/timezone"

  dayjs.extend(utc)
  dayjs.extend(timezone)

  const selectedDate = ref<string | null>(null);
  const selectedTime = ref<string | null>(null);
  const activeSlot = ref<string | null>(null);
  selectedDate.value = "2023-08-30"


  const selectTimeHandler = (slot) => {
    activeSlot.value = slot.utc
    // element.classList.add('active')

    console.log(activeSlot.value);




  }

    const handleClickOutside = (event: MouseEvent) => {
      const slotWrapper = document.querySelector(".slot_wrapper")
      if (slotWrapper && !slotWrapper.contains(event.target as Node)) {
        activeSlot.value = null
      }
    }


  function generateSlots(date: string) {
    const slots: { utc: string; mexico: string; local: string }[] = []

    const startHour = 8
    const endHour = 16
    const stepMinutes = 30

    for (let hour = startHour; hour < endHour; hour++) {
      for (let minute = 0; minute < 60; minute += stepMinutes) {
        const slotMexico = dayjs.tz(`${date} ${hour}:${minute}`, "YYYY-MM-DD H:m", "America/Mexico_City")

        slots.push({
          utc: slotMexico.utc().format(),
          mexico: slotMexico.format("HH:mm"),
          local: slotMexico.local().format("HH:mm"),
        })
      }
    }

    return slots
  }

  const slots = computed(() => (selectedDate.value ? generateSlots(selectedDate.value) : []))


onMounted(() => {
  document.addEventListener("click", handleClickOutside)
})

onBeforeUnmount(() => {
  document.removeEventListener("click", handleClickOutside)
})

</script>

<style lang="scss">
  .slot_wrapper{
    width: 100%;
    height: 100%;
  }
.slot_list {

    display: flex;

  flex-wrap: wrap;      
  gap: 0.5em 1em;   
}
.slot_item{
  display: flex;
  align-items: center;
  justify-content: center;
  border: 1px solid black;
  border-radius: 10px;
  margin-bottom: 0.25em;
  // flex: 0 0 calc(33.333% - 1em); 
    flex: 0 0 calc((100% - 2em) / 3);
  box-sizing: border-box;
  position: relative;
  button{
    padding-block: 0.5em;

    width: 100%;
    height:  100%;
  }

  
}

.active_slot{
  background: var(--text-color);
  color: white
}

</style>