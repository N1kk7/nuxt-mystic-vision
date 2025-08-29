<template>
  <div class="subscription">
    <div class="container">
      <div class="subscription_wrapper">
        <div class="subscriptions_head">
          <div class="title">
            <h1>Boost your wisdom with our coucher subscriptions</h1>
            <span> description </span>
          </div>

          <div class="toggle_switch">
            <span> Monthly </span>
            <SharedToggleSwitch
              v-model="isMonthly"
            >

            </SharedToggleSwitch>
            <span> Yearly </span>
          </div>
        </div>

        <div class="subscription_items">
          <div
            v-for="item in subscriptionData"
            :key="item.id"
            class="subscription_item"
          >
            <div class="item_head" v-if="!isMonthly">
              <h2>Monthly</h2>
              <span> $ {{ item.priceMonthly }} </span>
            </div>
            <div class="item_head" v-else>
              <h2>Yearly</h2>

              <span> $ {{ item.priceYearly }} </span>
            </div>

            <div class="item_body">
              <p></p>
            </div>

            <div class="item_footer">
              <button>Subscribe</button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, watch } from "vue";

const isMonthly = ref(false);

watch(isMonthly, () => {
    console.log(isMonthly.value, 'value is monthly')
})

const subscriptionData = ref([
  {
    id: 1,
    priceMonthly: 50,
    priceYearly: 500,
    description: "",
    subscriptionLink: "google.com",
  },
  {
    id: 2,
    priceMonthly: 100,
    priceYearly: 1000,
    description: "",
    subscriptionLink: "google.com",
  },
  {
    id: 3,
    priceMonthly: 150,
    priceYearly: 2500,
    description: "",

    subscriptionLink: "google.com",
  },
]);
</script>

<style scoped lang="scss">
.subscription {
  width: 100%;
  height: 100vh;
  background-color: rgb(241, 220, 241);
  position: relative;
}

.subscription_wrapper{
    display: flex;
    justify-content: flex-start;
    align-items: center;
    flex-direction: column;
    padding-block: 5em;
    width: 100%;
    height: 100%;
    gap: 1em;
}

.subscriptions_head{
    display: flex;
    align-items: center;
    justify-content: space-between;
    width: 100% ;
    gap: 5em;
    h1{
        width: 60%;
    }
    .toggle_switch{
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 1em;
    }
}

.subscription_items{
    display: flex;
    flex-wrap: wrap;
    flex-direction: row;
    justify-content: flex-start;
    align-items: center;
    width: 100%;
    height: fit-content;
    padding-block: 5em;
    gap: 2em;


}

.subscription_item{
    display: flex;
    flex-direction: column;
    justify-content: flex-start;
    align-items: center;
    gap: 1em;
    width: 30%;
    height: fit-content;
    background: #fff;
    padding: 1em;
    border-radius: 10px;
    position: relative;

    .item_footer{
        width: 100%;
        display: flex;
        justify-content: center;
        align-items: center;
        button{
            width: 100%;
            height: auto;
            background: black;
            color: #fff;
            padding-block: 0.5em;
            border-radius: 10px;
        }
    }



}
</style>
