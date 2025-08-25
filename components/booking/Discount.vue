<template>
    <div class="question_block">
        <div class="content text">
            <div class="text_content">

                <h1>
                    We have a special offer for you
                </h1>
                <p>
                    <span>
                        Would you like to have our book for 50% discount instead of a call?
                    </span>
                    <br/>

                    <span>
                        Please note! Our offer is valid for only 24 hours.
                    </span>

                </p>
              

            </div>
           

           

        </div>
        <div class="content">
            <img src="~/public/images/book-768.webp" alt="book">

        </div>

    </div>
 

  




</template>



<script setup>

</script>



<style lang="scss">
    .question_block{
        display: flex;
        justify-content: space-between;
        flex-direction: row-reverse;
        overflow: hidden;
        align-items: center;
        position: absolute;
        top: 0;
        left: 0;
        padding: 0;
        gap: 1em;
        width: 100%;
        height: 100%;
    }
    .content{
        flex: 1;
    }
    .text{
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        align-items: center;
        padding: 1em;
        padding-left: 0;
        height: 100%
    }
    .text_content{
        display: flex;
        align-items: flex-start;
        justify-content: center;
        flex-direction: column;
        height: 100%;
        gap: 3em;
    }
   


</style>