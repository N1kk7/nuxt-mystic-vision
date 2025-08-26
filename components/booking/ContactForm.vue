<!-- @submit.prevent="handleSubmit" -->
    <!-- <button type="submit"> Send</button> -->

<template>
  <div class="contact_modelValue">
    <div class="modelValue_group">
      <input
        type="text"
        v-model="localValue.name"
        @focus="focused.name = true"
        @blur="focused.name = false"
        @input="validate"
      />
      <label :class="{ active: focused.name || localValue.name }">Name</label>
      <span class="error" v-if="errors.name">{{ errors.name }}</span>
    </div>

    <div class="modelValue_group">
      <input
        type="email"
        v-model="localValue.email"
        @focus="focused.email = true"
        @blur="focused.email = false"
        @input="validate"
      />
      <label :class="{ active: focused.email || localValue.email }">Email</label>
      <span class="error" v-if="errors.email">{{ errors.email }}</span>
    </div>

    <div class="modelValue_group">
      <input
        type="tel"
        v-model="localValue.phone"
        @focus="focused.phone = true"
        @blur="focused.phone = false"
        @input="validate"
      />
      <label :class="{ active: focused.phone || localValue.phone }">Phone</label>
      <span class="error" v-if="errors.phone">{{ errors.phone }}</span>
    </div>

    <div class="switch-contents">
      <input id="layout-single" type="radio" value="telegram" name="layout" v-model="localValue.method" checked>
      <label class="radio_label" for="layout-single">Telegram</label>

      <input id="layout-column" type="radio" value="whatsapp" name="layout" v-model="localValue.method">
      <label class="radio_label" for="layout-column">WhatsApp</label>

      <input id="layout-card" type="radio" value="phone" name="layout" v-model="localValue.method">
      <label class="radio_label" for="layout-card">Phone</label>
    </div>
  </div>
</template>

<script setup lang="ts">
import { reactive, ref, watch, onMounted } from "vue";

const loader = ref(true);

interface ContactData {
  name: string;
  email: string;
  phone: string;
  method: string;
}


const emit = defineEmits<{
  (e: 'update:modelValue', value: ContactData): void
  (e: 'update:valid', value: boolean): void
}>()


const localValue = reactive<ContactData>({
  name: "",
  email: "",
  phone: "",
  method: "telegram",
})

const valid = ref(false)
const errors = reactive({ name: "", email: "", phone: "" })
const focused = reactive({ name: false, email: false, phone: false })


watch(
  localValue,
  (val) => emit("update:modelValue", { ...val }),
  { deep: true }
)

const validate = () => {
  let check = true

  if (!localValue.name || localValue.name.length < 2) {
    errors.name = "The name should be at least 2 characters"
    check = false;
    return;
  } else errors.name = ""

  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
  if (!emailRegex.test(localValue.email)) {
    errors.email = "Enter a valid email"
    check = false
    return;
  } else errors.email = ""

  const phoneRegex = /^[\d\s()+-]{6,20}$/
  if (!phoneRegex.test(localValue.phone)) {
    errors.phone = "Enter a valid phone number"
    check = false
    return;
  } else errors.phone = ""

  valid.value = check
  emit("update:valid", valid.value)
}
</script>


<style scoped lang="scss">
.contact_modelValue {
  width: 400px;
  height: -webkit-fill-available;
  margin: 0 auto;
  display: flex;
  flex-direction: column;
  justify-content: center;
  gap: 1.5em;
}

.modelValue_group {
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

