<template>
  <form class="contact_form" @submit.prevent="handleSubmit">

    <div class="form_group">
      <input
        type="text"
        v-model="form.name"
        required
        @focus="focused.name = true"
        @blur="focused.name = false"
      />
      <label :class="{ active: focused.name || form.name }">Name</label>
      <span class="error" v-if="errors.name">{{ errors.name }}</span>
    </div>


    <div class="form_group">
      <input
        type="email"
        v-model="form.email"
        required
        @focus="focused.email = true"
        @blur="focused.email = false"
      />
      <label :class="{ active: focused.email || form.email }">Email</label>
      <span class="error" v-if="errors.email">{{ errors.email }}</span>
    </div>


    <div class="form_group">
      <input
        type="tel"
        v-model="form.phone"
        required
        @focus="focused.phone = true"
        @blur="focused.phone = false"
      />
      <label :class="{ active: focused.phone || form.phone }">Phone</label>
      <span class="error" v-if="errors.phone">{{ errors.phone }}</span>
    </div>




<div class="switch-contents">
  <input id="layout-single" type="radio" name="layout" checked><label class="radio_label" for="layout-single">Telegram</label>
  <input id="layout-column" type="radio" name="layout"><label class="radio_label" for="layout-column">WhatsApp</label>
  <input id="layout-card" type="radio" name="layout"><label class="radio_label" for="layout-card">Phone</label>
</div>





    <button type="submit"> Send</button>
  </form>
</template>

<script setup lang="ts">
import { reactive, ref } from "vue"


const form = reactive({
  name: "",
  email: "",
  phone: "",
})

const contactMethod = ref("telegram") 


// const contactOptions = [
//   { label: "Telegram", value: "telegram" },
//   { label: "WhatsApp", value: "whatsapp" },
//   { label: "Телефон", value: "phone" },
// ]


const focused = reactive({
  name: false,
  email: false,
  phone: false,
})


const errors = reactive({
  name: "",
  email: "",
  phone: "",
})


const validate = () => {
  let valid = true
  // имя
  if (!form.name || form.name.length < 2) {
    errors.name = "Имя должно быть минимум 2 символа"
    valid = false
  } else errors.name = ""


  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
  if (!emailRegex.test(form.email)) {
    errors.email = "Введите корректный email"
    valid = false
  } else errors.email = ""


  const phoneRegex = /^[\d\s()+-]{6,20}$/
  if (!phoneRegex.test(form.phone)) {
    errors.phone = "Введите корректный телефон"
    valid = false
  } else errors.phone = ""

  return valid
}


const handleSubmit = () => {
  if (validate()) {
    alert(`Форма отправлена! Данные:\n${JSON.stringify(form, null, 2)}`)

    //fetch

  }
}


const contactOptions = [
  { label: "Telegram", value: "telegram" },
  { label: "WhatsApp", value: "whatsapp" },
  { label: "Телефон", value: "phone" },
]
</script>

<style scoped lang="scss">
.contact_form {
  width: 400px;
  margin: 0 auto;
  display: flex;
  flex-direction: column;
  gap: 1.5em;
}

.form_group {
  position: relative;
}

input[type="text"],
input[type="email"],
input[type="tel"] {
  width: 100%;
  padding: 12px 10px;
  font-size: 16px;
  border: 1px solid #ccc;
  border-radius: 6px;
  outline: none;
}

label {
  position: absolute;
  left: 12px;
  top: 12px;
  color: #888;
  pointer-events: none;
  transition: 0.2s ease all;
}

label.active {
  top: -8px;
  left: 8px;
  font-size: 12px;
  background: white;
  padding: 0 4px;
  color: #333;
}

.error {
  color: red;
  font-size: 12px;
  margin-top: 4px;
}

.radio_group p {
  margin-bottom: 0.5em;
  font-weight: 500;
}



.switch-contents {

  text-align: center;
  position: relative;
  border: 1px solid var(--text-color);
  border-radius: 10px;
  padding: 0.5em;
  display: flex;
  align-items: center;
  justify-content: flex-start;
  input[name="layout"] {
  display: none;
  z-index: 100;

  &:checked + label {
    border-bottom: 2px solid #3498db;
    cursor: default;
  }
}
label{
  display: inline-block;
  position: relative;
  margin: 0 1em;
  font-size: 1.2rem;
  font-family: 'Open Sans', sans-serif;
  font-weight: 300;
  top: unset;
  left: unset;
  flex: 1;
  cursor: pointer;
  pointer-events: unset;
  &:hover {
    border-bottom: 2px solid #000;
  }
}
}








/* submit */
button[type="submit"] {
  padding: 12px;
  font-size: 16px;
  border: none;
  border-radius: 6px;
  background: #4caf50;
  color: white;
  cursor: pointer;
  transition: 0.2s;
}

button[type="submit"]:hover {
  background: #45a049;
}
</style>

