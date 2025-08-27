<template>
    <div class="booking">
        <div class="booking_wrapper">
            <div class="booking_head">
                <div class="title">
					<img src="/images/sphinks.webp" alt="logo" class="footer-logo">

                    <h2>
                        {{ steps[currentStep].titleName }}
                    </h2>


                </div>
                <DefaultBtn>
                    close
                </DefaultBtn>

            </div>
            <div class="booking_content">
                <div 
                    class="progress_bar"
                    v-if="currentStep < 3"
                >
                    <div class="progress_description">
                        <div class="el">
                            <svg class="svg-icon"> 
								<use xlink:href="#schedule-icon"></use>

							</svg>
                            <span>Setting day</span>


                        </div>
                        <div class="el">
                            <svg class="svg-icon"> 
								<use xlink:href="#contact-time"></use>

							</svg>
                            <span>Setting time</span>


                        </div>
                        <div class="el">
                            <svg class="svg-icon"> 
								<use xlink:href="#contact-form"></use>

							</svg>
                            <span>Contacts</span>

                        </div>
                    </div>
                    <!-- <progress id="progress" max="100" value="0"></progress> -->
                    <div class="progress">
                        <div 
                            class="progress_value"
                            :style="{width: progress + '%'}"
                        ></div>

                    </div>
                </div>
                <!-- <BookingSetDate/> -->
                <!-- <BookingSetTime/> -->
                 <!-- <BookingContactForm/> -->
                <!-- <component :is="stepComponents[currentStep]"></component> -->
                 <!-- {{ stepComponents[currentStep] }} -->

                <component 
                    :is="steps[currentStep].component"
                    v-model="steps[currentStep].value"
                    v-model:valid="steps[currentStep].valid"
                    :booking-data="bookingData"
                />
          
                    <!-- @can-continue="updateStepValidity" -->



            </div>
            <div 
                class="booking_btn"
                v-if="currentStep < 3"
            >
                <DefaultBtn
                    @click="prevStep"
                    v-if="currentStep > 0"
                >
                    Prev
                </DefaultBtn>
                <DefaultBtn
                    class="step_disabled"
                    style="pointer-events: none; opacity: 0.5;"
                    v-if="steps[currentStep].valid === false"
                >
                    {{ steps[currentStep].nameBtn }}
                </DefaultBtn>
                <DefaultBtn
                    class="step_active"
                    v-else
                    @click="nextStep(steps[currentStep].method)"
                >
                    {{ steps[currentStep].nameBtn }}
                </DefaultBtn>

            </div>
            <div 
                class="discount_btn"
                v-if="currentStep === 3"
            >
                <DefaultBtn
                    class="decline btn"
                    @click="nextStep('decline-discount')"
                >
                    No, thanks
                </DefaultBtn>
                <DefaultBtn
                    class="accept btn"
                    @click="nextStep('approve-discount')"

                >
                    Order now
                </DefaultBtn>

            </div>

        </div>
      
    </div>




</template>



<script setup lang="ts">
    import DefaultBtn from '../shared/DefaultBtn.vue';
    import { ref, computed, watch, reactive, markRaw } from 'vue';


    const currentStep = ref(0);
    const reservationId = ref('');
    const bookOrdered = ref(false);


    function toLocalISODateString(input: string): string {
        const d = new Date(input);

        const year = d.getFullYear();
        const month = String(d.getMonth() + 1).padStart(2, "0");
        const day = String(d.getDate()).padStart(2, "0");

        return `${year}-${month}-${day}`;
    }

    const steps = reactive([
        {
            id: 0,
            component: markRaw(resolveComponent("BookingSetDate") as Component),
            titleName: "Setting day",
            method: "next-step",
            nameBtn: "Next",
            value: null, 
            valid: false
        },
        {
            id: 1,
            component: markRaw(resolveComponent("BookingSetTime") as Component),
            titleName: "Setting time",
            method: "set-slot-reservation",
            nameBtn: "Next",
            value: null, 
            valid: false
        },
        {
            id: 2,
            component: markRaw(resolveComponent("BookingContactForm") as Component ),
            titleName: "Contacts",
            method: "send-data",
            nameBtn: "Next",
            value: null,
            valid: false
        },
        {
             id: 3,
            component: markRaw(resolveComponent("BookingDiscount") as Component ),
            titleName: "Discount",
            method: "next-step",
            nameBtn: "Next",
            value: null,
            valid: false
        },
        {
            id: 4,
            component: markRaw(resolveComponent("BookingSummary") as Component ),
            titleName: "Summary",
            method: "next-step",
            nameBtn: "Next",
            value: null,
            valid: false
        }
        ])

  

    const progress = computed(() => ((currentStep.value + 1) / 3) * 100);


    const bookingData = computed(() => ({
        date: steps[0].value,
        time: steps[1].value,
        contact: steps[2].value,
        bookOrdered: bookOrdered.value
        // userName: steps[2].value.name
        // orderBook: steps[3].value
    }));

    watch(steps, () => {
        console.log(
            "recieved props",
            steps[currentStep.value].value,
            steps[currentStep.value].valid
        );
    })

    onMounted(() => {
        console.log(steps[0].value)
    })

    const slotReservation = async () => {

        const selectedDate = toLocalISODateString(steps[0].value) ;
        const selectedTime = steps[1].value;

        try{

            const setReservation = await $fetch('/api/bookingCall', {

                method: 'POST',
                params: {
                    method: "reserveSlot",
                    date: selectedDate,
                    time: selectedTime,

                }

            })

            return setReservation;

        } catch (error) {
                console.error(error);
            return {
                message: "Something went wrong"
            }
        }
    }

    const orderDiscount = async () => {

        const formData = new FormData();

        console.log(reservationId.value, 'reservationId from front')

        const jsonData = {
            reservationId: reservationId.value,
        }

        formData.append('data', JSON.stringify(jsonData));

        try{


            const updateDiscount = await $fetch('/api/bookingCall', {
                method: 'PATCH',
                params: {
                    method: "updateDiscount",
                },
                body: formData

            })

            console.log(updateDiscount, 'updateDiscount');

            return updateDiscount;

        } catch (error) {
            return {
                message: "Something went wrong"
            }
        }


        
    }


    const fetchDataHandler = async () => {
        // console.log('inside fetch')

        // console.log(steps[2]);
        const endingDiscountTime = new Date(Date.now() + 24 * 60 * 60 * 1000).toISOString();
        const selectedDate = toLocalISODateString(steps[0].value);
        const selectedTime = steps[1].value;
        const filledForm = steps[2].value;
        // console.log("fetchDataHandler");
        // console.log(
        //     selectedDate,
        //     selectedTime,
        //     filledForm
        // )

        const formData = new FormData();

        const jsonData = {
            name: filledForm.name,
            email: filledForm.email,
            phone: filledForm.phone,
            contactMethod: filledForm.contactMethod,
            timeSlot: selectedTime,
            dateCallback: new Date(selectedDate).toISOString(),
            comment: filledForm.comment,
            discountEndAt: endingDiscountTime,
            status: 'WAITING_CALL'
        }

        console.log(jsonData, 'jsonData');

        formData.append('data', JSON.stringify(jsonData));

        try{

            const fetchData = await $fetch('/api/bookingCall', {
                method: 'POST',
                params: {
                    method: 'addCallback',
                },
                body: formData
            })

            // console.log('succesfully fetched', fetchData.data.id)

            return {
                status: 'successfully',
                id: fetchData.data.id
            }

        } catch (error) {
            console.error(error.message)

        }
    }

    const nextStep = async (method: string) => {

        // console.log("nextStep", method);

       

        switch (method) {
            case "next-step":
                currentStep.value++;
                break;
            case "send-data":
                // console.log('inside send-data');
                const fetchedId = await fetchDataHandler();
                reservationId.value = fetchedId.id;
                currentStep.value++ ;
            break;
            case "set-slot-reservation":
                slotReservation();
                // console.log(resultReservation, 'resultReservation')
                currentStep.value ++
            break;
            case "approve-discount":
                bookOrdered.value = true;
                await orderDiscount();
                currentStep.value ++
            break;
            case "decline-discount":

                document.cookie = "reminder=true; email=" + steps[2].value.email + "; path=/, reservationId=" + reservationId.value + ";";
                currentStep.value ++

            break;
        }

         if ( currentStep.value > 1) {
            return;
        }

    }

    const prevStep = () => {

        if ( currentStep.value < 1) {
            return;
        }

        if (currentStep.value === 1) {
            steps[0].value = null;
            steps[1].value = null;
            steps[0].valid = false;
        }

        if (currentStep.value === 2) {
            steps[1].value = null;
            steps[1].valid = false;
            steps[2].valid = false;
            steps[2].value = {
                name: "",
                email: "",
                phone: "",
                method: ""
            };
        }

        currentStep.value--;


    }


    // const createCallback = async () => {

    //     try{

    //         const res = await fetch('/api/bookingCall', {
    //             method: 'POST',
    //             body: JSON.stringify({
    //                 name: 'test',
    //                 contact: 'test',
    //                 dateCallback: '2025-08-25T12:00:00.000Z',
    //                 orderTime: '10:00-11:00',
    //                 discountEndAt: '2025-08-30T23:59:59.000Z'
    //             })

    //         })

    //     } catch (error) {
    //         console.log(error);

    //     }
    // }

    // const updateStepValidity = (isValid: boolean) => {
    //     if (isValid) {
    //         nextStep();
    //     }
    // }


    // watch(() => {
    //     console.log(currentStep.value);
        
    // })
    


</script>



<style lang="scss">
.booking{
    width: 80%;
    margin: 0 auto;
    height: 80vh;
    background-color: #fff;
    display: flex;
    align-items: center;
    justify-content: center;
    .booking_wrapper{
        width: 80vw;
        height: 70vh;
        min-height: 50vh;
        margin: 0 auto;
        border: 1px solid var(--text-color);
        border-radius: 15px;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        align-items: normal;
        position: relative;
        overflow: hidden;

    }
    .booking_head{
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 1em;
        border-bottom: 1px solid var(--text-color);
        .title{
            display: flex;
            align-items: center;
            justify-content: flex-start;
            gap: 0.5em;
        }
        img{
            width: 50px;
        }

    }
    .booking_content{
        padding: 1em;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        position: relative;
        width: 100%;
        height: inherit;
        gap: 1em;

      

        .progress_bar{
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            position: relative;
            width: 100%;
            gap: 1em;

            .progress_description{
                width: 100%;
                height: auto;
                display: flex;
                justify-content: space-evenly;
                align-items: center;
                .el{
                    display: flex;
                    justify-content: center;
                    color: rgb(224, 224, 224);
                    align-items: flex-end;
                    gap: 0.5em;
                    svg{
                        width: 25px;
                        height: 25px;
                        fill: rgb(224, 224, 224);
                    }
                }
                
            }
            .progress{
                background-color: rgb(224, 224, 224);
                border-radius: 15px;
                width: 80%;
                height: 5px;

            }
            .progress_value{
                background-color: var(--text-color);
                border-radius: 15px;
                // width: 0%;
                height: 5px;
                transition: all ease 0.3s;
            }
        }
    }
    .booking_btn{
        padding: 1em;
        display: flex;
        justify-content: flex-end;
        align-items: center;
        border-top: 1px solid var(--text-color);
        gap: 1em;

    }
     .discount_btn{
        display: flex;
        justify-content: flex-end;
        position: absolute;
        align-items: center;
        width: 100%;
        padding: 1em;
        gap: 1em;
        bottom: 0;
        left: 0;

        .btn{
            padding: 0.5em 1em;
            border-radius: 5px;
            color: black;
            border: 1px solid var(--text-color);
            transition: all ease 0.3s;
            font-weight: bold;
            cursor: pointer;


        }

        .accept{
            @media screen and (min-width: 1024px) {
                &:hover{
                    background: rgb(153, 255, 0);
                    transition: all ease 0.3s;
                    border: 1px solid transparent;


                }
                
            }
        }
        .decline{
        
            @media screen and (min-width: 1024px) {
                &:hover{
                    background: rgb(255, 0, 0);
                    transition: all ease 0.3s;
                    color: white;
                    border: 1px solid transparent;

                    
                }
            }
        }
    }
}


</style>