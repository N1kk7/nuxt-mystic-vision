<template>
    <div class="booking">
        <div class="booking_wrapper">
            <div class="booking_head">
                <div class="title">
                    logo
                    slide name


                </div>
                <DefaultBtn>
                    close
                </DefaultBtn>

            </div>
            <div class="booking_content">
                <!-- <BookingSetDate/> -->
                <!-- <BookingSetTime/> -->
                 <BookingContactForm/>


            </div>
            <div class="booking_btn">
                <DefaultBtn>
                    Prev
                </DefaultBtn>
                <DefaultBtn>
                    Next
                </DefaultBtn>

            </div>

        </div>
      
    </div>




</template>



<script setup>
import DefaultBtn from '../shared/DefaultBtn.vue';

</script>



<style lang="scss">
.booking{
    width: 100%;
    height: 80vh;
    background-color: #fff;
    display: flex;
    align-items: center;
    justify-content: center;
    .booking_wrapper{
        width: 80vw;
        height: auto;
        min-height: 50vh;
        margin: 0 auto;
        border: 1px solid var(--text-color);
        border-radius: 15px;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        align-items: normal;
    }
    .booking_head{
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 1em;
        border-bottom: 1px solid var(--text-color);

    }
    .booking_content{
        padding: 1em;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    .booking_btn{
        padding: 1em;
        display: flex;
        justify-content: flex-end;
        align-items: center;
        border-top: 1px solid var(--text-color);
        gap: 1em;

    }
}


</style>