
<template>
  <div class="date_wrapper">

    <div class="description content_item">
      <div class="title">
        <span>
          Mystic Visions
        </span>
        <h1>
          Here's Your Next Step...
        </h1>

      </div>
      <span class="time">
        <svg class="svg-icon">
          <use href="#contact-time"></use>
        </svg>
        30 min
      </span>
      <p>
        We're offering you personalized feedback on applying The Pillars of Wisdom in a free 30-minute strategy session.
      </p>
      <p>
        *92% of readers say this session helped them get a better grasp on the book.
      </p>

    </div>
    <div class="content_item calendar">
        <VDatePicker
          v-model="modelValue"
          :min-date="today"
          :disabled-dates="disabledDates"
          :first-day-of-week="2" 
          mode="date"
          locale="en"  
          class="calendar"
          is-required

        />

    </div>
  
  </div>
 
</template>

<script setup lang="ts">
import { ref, watch, computed } from 'vue'

// const modelValue = defineModel<Date | null>(null);
const modelValue = defineModel<Date | null>({ default: null })

const isValid = defineModel<boolean>("valid", { default: false });

const today = new Date()
today.setHours(0, 0, 0, 0)

const disabledDates = [{repeat: { weekdays: [1] } }]


// const formattedDate = computed(() => {
//   if (!selectedDate.value) return null
//   return selectedDate.value.toISOString().split("T")[0] 
// })

// const formattedDate = computed(() => {
//   if (!modelValue.value) return null
//   return new Intl.DateTimeFormat("en-US", {
//     month: "long",  
//     day: "numeric", 
//     year: "numeric", 
//   }).format(modelValue.value)
// })


watch(modelValue, (val) => {
  isValid.value = !!val
})





// const date = defineModel<Date | null>();
// const isValid = defineModel<boolean>("valid", { default: false });

// const checkValid = () => {
//   return isValid.value = !!modelValue.value
// }

// watch(formattedDate, () => {
//   console.log(formattedDate.value)
// })



</script>


<style lang="scss" >

  .date_wrapper{
    display: flex;
    justify-content: flex-start;
    align-items: center;
    height: -webkit-fill-available;
    width: 80%;


  }

  .calendar{
    display: flex;
    align-items: center;
    justify-content: center;
  }
 
  .content_item{
    flex: 1;
  }

  .description{
    display: flex;
    flex-direction: column;
    justify-content: flex-start;
    align-items: flex-start;
    gap: 24px;
  }

  .title{
    span{
      font-weight: bold;
      font-size: 16px;
      line-height: 24px;
      color: rgba(26, 26, 26, 0.61);
    }
    h1{
      margin: 0;
      font-weight: bold;
      font-size: 28px;
      line-height: 32px;
    }
  }
  .time{
    display: flex;
    align-items: center;
    justify-content: flex-start;
    gap: 10px;
    color: rgba(26, 26, 26, 0.61);
    svg{
      width: 20px;
      height: 20px;
    }
  }
  p{
    margin: 0;
    padding: 0;
    font-size: 16px;
    font-family: "Proxima Nova", sans-serif;
    line-height: 1.5;
  }


</style>