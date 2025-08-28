<template>
  <div 
    class="loader"
    v-if="loader"
  >
    <span>
      Loading...
    </span>
  </div>
  <div 
    class="slot_wrapper"
    v-else
  >
    <div v-if="slots && slots.length">
      <h2>
        Select time for {{ userDate }}
      </h2>
      <ul class="slot_list">
        <li class="slot_item" v-for="(slot, index) in slots" :key="index"
          :class="{ active_slot: modelValue === slot }"
        >
          <!-- {{ console.log(slot, "slot") }} -->


          <button 
            @click="(e) => selectTimeHandler(slot)"
          >
            {{ slot }}


          </button>
        </li>
      </ul>
    </div>
  </div>
</template>

<script setup lang="ts">
  import { ref, computed, onMounted } from "vue"
  import dayjs from "dayjs"
  import utc from "dayjs/plugin/utc"
  import timezone from "dayjs/plugin/timezone"

  dayjs.extend(utc)
  dayjs.extend(timezone)

  const selectedDate = ref<string | null>(null);
  const selectedTime = ref<string | null>(null);
  const userDate = ref<string | null>(null);
  const modelValue = defineModel<string | null>({ default: null });
  const slots = ref([]);

  // const modelValue = defineModel<Date | null>({ default: null })

  const isValid = defineModel<boolean>("valid", { default: false });

  const loader = ref(true);


 const props = defineProps<{
  modelValue: string | null
  valid: boolean
  bookingData: {
    date: any | null
    time: string | null
    contact: {
      name: string
      email: string
      phone: string
      method: string
    }
  }
}>();


  const selectTimeHandler = (slot) => {
    modelValue.value = slot

  }

    const handleClickOutside = (event: MouseEvent) => {
      const slotWrapper = document.querySelector(".slot_wrapper")
      if (slotWrapper && !slotWrapper.contains(event.target as Node)) {
        modelValue.value = null
      }
    }


  // function generateSlots(date: string) {
  //   const slots: { utc: string; mexico: string; local: string }[] = []

  //   const startHour = 8
  //   const endHour = 16
  //   const stepMinutes = 30

  //   for (let hour = startHour; hour < endHour; hour++) {
  //     for (let minute = 0; minute < 60; minute += stepMinutes) {
  //       const slotMexico = dayjs.tz(`${date} ${hour}:${minute}`, "YYYY-MM-DD H:m", "America/Mexico_City")

  //       slots.push({
  //         utc: slotMexico.utc().format(),
  //         mexico: slotMexico.format("HH:mm"),
  //         local: slotMexico.local().format("HH:mm"),
  //       })
  //     }
  //   }

  //   return slots
  // }

  // const slots = computed(() => (selectedDate.value ? generateSlots(selectedDate.value) : []))


  watch(modelValue, (val) => {
    isValid.value = !!val
  })


const getFreeSlots = async (date: string) => {

  try{

    const slots = await $fetch('/api/bookingCall', {
      method: 'GET',
      params: {
        method: 'getAvailableSlots',
        date: date
      }
    })

    console.log(slots, 'slots')

    return slots.data

    
  } catch (error) {
    console.log(error, 'error getFreeSlots');
  }

}

onMounted(async () => {
  document.addEventListener("click", handleClickOutside);

  selectedDate.value = props.bookingData.date.toISOString().split("T")[0];
  userDate.value = new Intl.DateTimeFormat("en-US", {
    month: "long",  
    day: "numeric", 
    year: "numeric", 
  }).format(props.bookingData.date);

  // function toLocalISODateString(input: string): string {
  //   const d = new Date(input);

  //   const year = d.getFullYear();
  //   const month = String(d.getMonth() + 1).padStart(2, "0");
  //   const day = String(d.getDate()).padStart(2, "0");

  //   return `${year}-${month}-${day}`;
  // }

  const rawDate = toLocalISODateString(props.bookingData.date);


  const receivedSlots = await getFreeSlots(rawDate);

  slots.value = receivedSlots;

  loader.value = false;




  console.log(receivedSlots, "recievedSlots");

  // console.log(props.bookingData.date, "props.bookingData.date");
  // console.log(selectedDate.value, "selectedDate");

})

onBeforeUnmount(() => {
  document.removeEventListener("click", handleClickOutside)
})

</script>

<style lang="scss">

  .loader{
    display: flex;
    justify-content: center;
    align-items: center;
    width: 100%;
    height: 100%;
  }


  .slot_wrapper{
    width: 100%;
    height: 100%;
  }
  h2{
    text-align: center;
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