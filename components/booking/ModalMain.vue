<template>
    <div class="modal">
        <div class="modal_wrapper">
            <SharedModalHead
                @cancelBtnMethod="clearAllData"
            >
                {{ steps[currentStep].titleName }}
            </SharedModalHead>
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
                    <div class="progress">
                        <div 
                            class="progress_value"
                            :style="{width: progress + '%'}"
                        ></div>

                    </div>
                </div>

                <component 
                    :is="steps[currentStep].component"
                    v-model="steps[currentStep].value"
                    v-model:valid="steps[currentStep].valid"
                    :booking-data="bookingData"
                />

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

    const modalStore = useModalStore();
    const currentStep = ref(0);
    const reservationId = ref('');
    const bookOrdered = ref(false);


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

    const clearAllData = () => {

        currentStep.value = 0;
        reservationId.value = '';
        bookOrdered.value = false;

        steps[0].value = null;
        steps[1].value = null;
        steps[2].value = null;
        steps[3].value = null;
        steps[4].value = null;

        modalStore.closeModal();

    };


    const progress = computed(() => ((currentStep.value + 1) / 3) * 100);


    const bookingData = computed(() => ({

        date: steps[0].value,
        time: steps[1].value,
        contact: steps[2].value,
        bookOrdered: bookOrdered.value

    }));

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

            return updateDiscount;

        } catch (error) {
            return {
                message: "Something went wrong"
            }
        }

    }


    const fetchDataHandler = async () => {

        const endingDiscountTime = new Date(Date.now() + 24 * 60 * 60 * 1000).toISOString();
        const selectedDate = toLocalISODateString(steps[0].value);
        const selectedTime = steps[1].value;
        const filledForm = steps[2].value;
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

        formData.append('data', JSON.stringify(jsonData));

        try{

            const fetchData = await $fetch('/api/bookingCall', {
                method: 'POST',
                params: {
                    method: 'addCallback',
                },
                body: formData
            })

            return {
                status: 'successfully',
                id: fetchData.data.id
            }

        } catch (error) {
            console.error(error.message)

        }
    }

    const nextStep = async (method: string) => {

        switch (method) {
            case "next-step":

                currentStep.value++;
                break;

            case "send-data":

                const fetchedId = await fetchDataHandler();
                reservationId.value = fetchedId.id;
                currentStep.value++ ;

            break;
            case "set-slot-reservation":

                slotReservation();
                currentStep.value ++;

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

</script>



<style lang="scss">
.modal{
    width: 100%;
    margin: 0 auto;
    height: 100%;
    background-color: #fff;
    display: flex;
    align-items: center;
    justify-content: center;
    .modal_wrapper{
        width: 80vw;
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
 
    .booking_content{
        padding: 1em;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        position: relative;
        width: 100%;
        height: inherit;
        min-height: 60vh;
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