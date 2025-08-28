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
        @input="nameValidation"
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
        @input="emailValidation"
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
        @input="phoneValidation"
      />
      <label :class="{ active: focused.phone || localValue.phone }">Phone</label>
      <span class="error" v-if="errors.phone">{{ errors.phone }}</span>
    </div>

    <div class="switch-contents">
      <input id="layout-single" type="radio" value="Phone-call" name="layout" v-model="localValue.method" checked>
      <label class="radio_label" for="layout-single">
        <img src="/phone.webp" alt="g-meet" width="22" height="22">
        Phone call
      </label>

      <input id="layout-column" type="radio" value="Google-meet" name="layout" v-model="localValue.method">
      <label class="radio_label" for="layout-column">
        <img src="/meet.webp" alt="g-meet" width="22" height="22">
        Google Meet
      </label>

      <input id="layout-card" type="radio" value="Somewhere-else" name="layout" v-model="localValue.method">
      <label class="radio_label" for="layout-card">
        <svg fill="none" width="22" height="22" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" data-testid="ask_invitee"><title>Ask invitee for location</title><path d="M21.428 0H2.573C1.2 0 0 1.2 0 2.572v14.57c0 1.373 1.2 2.573 2.572 2.573h2.57v3.428c0 .514.343.857.858.857.172 0 .343 0 .515-.172l5.142-4.113h9.77c1.372 0 2.572-1.2 2.572-2.572V2.573C24 1.2 22.8 0 21.429 0z" fill="#004796"></path><path d="M12 4C9.828 4 8 5.814 8 7.967c0 3.06 3.429 7.027 3.542 7.14.23.226.572.226.8.113l.116-.113c.113-.114 3.542-4.08 3.542-7.14C16 5.814 14.172 4 12 4zm0 5.44c-.8 0-1.37-.68-1.37-1.36s.685-1.36 1.37-1.36 1.372.68 1.372 1.36S12.8 9.44 12 9.44z" fill="#fff"></path></svg>
        Somewhere else
      </label>
    </div>
     <div class="modelValue_group">
      <input
        type="text"
        v-model="localValue.comment"
        @focus="focused.comment = true"
        @blur="focused.comment = false"
        @input="commentValidation"
      />
      <label :class="{ active: focused.comment || localValue.comment }">What topics interest you most in our book?</label>
      <span class="error" v-if="errors.comment">{{ errors.comment }}</span>
    </div>
  </div>
</template>

<script setup lang="ts">
import { reactive, ref, watch, onMounted } from "vue";

const loader = ref(true);

const validationState = ref({
  name: false,
  email: false,
  phone: false,
  comment: false
})

interface ContactData {
  name: string;
  email: string;
  phone: string;
  method: string;
  comment: string
}


const emit = defineEmits<{
  (e: 'update:modelValue', value: ContactData): void
  (e: 'update:valid', value: boolean): void
}>()


const localValue = reactive<ContactData>({
  name: "",
  email: "",
  phone: "+",
  method: "Phone-call",
  comment: ""
})

const errors = reactive({ name: "", email: "", phone: "", comment: "" })
const focused = reactive({ name: false, email: false, phone: false, comment: false })


watch(
  localValue,
  (val) => emit("update:modelValue", { ...val }),
  { deep: true }
)

const nameValidation = ():boolean => {

  if (!localValue.name || localValue.name.length < 2) {
    errors.name = "The name should be at least 2 characters"
    return false;
  } else {
    errors.name = ""
    return true;
  }

}

const emailValidation = ():boolean => {
 const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
  if (!emailRegex.test(localValue.email)) {
    errors.email = "Enter correct email"
    return false;
  } else {
    errors.email = ""
    return true;
  }
}

const phoneValidation = ():boolean => {

  
 const phoneRegex = /^\+\d[\d\s]*$/


  const digitsCount = localValue.phone.replace(/\D/g, "").length

  if (!phoneRegex.test(localValue.phone) || digitsCount < 12 || digitsCount > 15) {
    errors.phone = "Enter a valid phone number with country code (12–15 digits)"
    return false
  } else {
    errors.phone = ""
    return true
  }

}

const commentValidation = ():boolean => {
   if (!localValue.comment || localValue.comment.trim().length < 10) {
    errors.comment = "Comment must be at least 10 characters"
    return false
  } else {
    errors.comment = ""
    return true
  }
}


const isFormValid = computed(() => {
  return (
    nameValidation() &&
    emailValidation() &&
    phoneValidation() &&
    commentValidation()
  )
})

watch(isFormValid, (val) => {

  emit("update:valid", val)

})
</script>


<style scoped lang="scss">
.contact_modelValue {
  width: 600px;
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
  padding: 1em 0.5em 0.5em;
  display: flex;
  align-items: center;
  justify-content: flex-start;
  input[name="layout"] {
  display: none;
  z-index: 100;

  &:checked + label {
    border-bottom: 2px solid var(--text-color);
    cursor: default;
  }


}
label{
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 5px;
  position: relative;
  margin: 0 1em;
  font-size: 1rem;
  font-family: 'Open Sans', sans-serif;
  font-weight: 300;
  top: unset;
  left: unset;
  flex: 1;
  cursor: pointer;
  pointer-events: unset;
  padding-bottom: 0.5em;
  border-bottom: 1px solid transparent;

  &:hover {
    border-bottom: 1px solid #494949;
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

