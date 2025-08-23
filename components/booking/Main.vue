<template>
    <div class="booking">
        <div class="booking_wrapper">
            <div class="booking_head">
                <div class="title">
					<img src="/images/sphinks.webp" alt="logo" class="footer-logo">

                    <h2>
                        {{ titleNames[currentStep] }}
                    </h2>


                </div>
                <DefaultBtn>
                    close
                </DefaultBtn>

            </div>
            <div class="booking_content">
                <div class="progress_bar">
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
                        <div class="progress_value">

                        </div>

                    </div>
                </div>
                <!-- <BookingSetDate/> -->
                <!-- <BookingSetTime/> -->
                 <!-- <BookingContactForm/> -->
                <!-- <component :is="stepComponents[currentStep]"></component> -->
                 <!-- {{ stepComponents[currentStep] }} -->

                <component :is="stepComponents[currentStep]" />


            </div>
            <div class="booking_btn">
                <DefaultBtn
                    @click="prevStep"
                >
                    Prev
                </DefaultBtn>
                <DefaultBtn
                    @click="nextStep"
                >
                    Next
                </DefaultBtn>

            </div>

        </div>
      
    </div>




</template>



<script setup>
    import DefaultBtn from '../shared/DefaultBtn.vue';
    import { ref, computed, watch } from 'vue';


    const currentStep = ref(0);

    const titleNames = ref([
        "Setting day",
        "Setting time",
        "Contacts"
    ])
    const stepComponents = [

        resolveComponent("BookingSetDate"),
        resolveComponent("BookingSetTime"),
        resolveComponent("BookingContactForm"),

    ]

    const progress = computed(() => ((currentStep.value + 1) / steps.length) * 100)

    const nextStep = () => {



        if ( currentStep.value > 1) {
            return;
        }

        currentStep.value++;


    }

    const prevStep = () => {

        if ( currentStep.value < 1) {
            return;
        }

        currentStep.value--;


    }


    watch(() => {
        console.log(currentStep.value);
        
    })
    


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
        height: auto;
        min-height: 50vh;
        margin: 0 auto;
        border: 1px solid var(--text-color);
        border-radius: 15px;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        align-items: normal;
        position: relative;
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
}


</style>