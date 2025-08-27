<template>

    <div class="summary_wrapper">

        <div class="summary_head">

            <img src="/success.png" alt="success">

            <h1>
                Thank you!
            </h1>

        </div>

        <div 
            class="info"
            v-if="bookOrderedState"
        >

            <p>
                We alreadyy proccessed your order.
                <span>
                    Additional details we sent to your email.
                    
                </span>

            </p>
        </div>

        <div 
            class="info"
            v-else
        >
            

            <p>
                We setting our meeting for {{ dateMeeting }} at {{ timeMeeting }}
                <span>
                    Additional information we send to your email.
                </span>

            </p>
        </div>



    </div>



</template>



<script setup lang="ts">

import { onMounted, ref } from "vue";


const bookOrderedState = ref(null);
const dateMeeting = ref(null);
const timeMeeting = ref(null);



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
    bookOrdered: boolean
    
  }



}>();

  onMounted(() => {

    bookOrderedState.value = props.bookingData.bookOrdered;
    dateMeeting.value = props.bookingData.date.toISOString().split("T")[0];
    timeMeeting.value = props.bookingData.time;

    // console.log(props.bookingData.bookOrdered, 'props')
    
  })




</script>



<style lang="scss">

    .summary_wrapper{
        position: relative;
        width: 100%;
        height: 100%;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        gap: 30px;
    }

    .summary_head{
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        gap: 30px;
        img{
            width: 100px;
            height: 100px;
        }
    }

    .info{
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        gap: 10px;
    }

</style>