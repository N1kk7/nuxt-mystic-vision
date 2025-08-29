<template>

    <div class="modal_head">
        <div class="title">
            <img src="/images/sphinks.webp" alt="logo" class="footer-logo">

            <h2>
                <!-- {{ steps[currentStep].titleName }} -->
                <slot>

                </slot>
            </h2>


        </div>
        <DefaultBtn
            @click="emit('cancelBtnMethod')"
        >
            close
        </DefaultBtn>

    </div>

    



</template>




<script setup lang="ts">

    import DefaultBtn from './DefaultBtn.vue';

    const emit = defineEmits<{
        (e: 'cancelBtnMethod'): void
    }>();



</script>



<style lang="scss">

    .modal_head{
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

</style>