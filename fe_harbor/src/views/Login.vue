<script setup lang="ts">
import MainLayout from '@/components/MainLayout.vue';
import { reactive } from 'vue';
import { login, registerUser, type TokenResponse } from "../api/user"
import { useMutation } from "@tanstack/vue-query"
import router from '@/router';


const { isPending, isError, error, isSuccess, mutate } = useMutation({
    mutationFn: login, onSuccess: ({data}) => {
        localStorage.setItem("access_token", data.data.access_token)
        console.log(data.data.access_token)
        router.push("/")
    }
})
interface FormData {
    email: string;
    password: string;
    password_confirmation: string;
}
const formData = reactive<FormData>({
    email: "",
    password: "",
    password_confirmation: ""
})

const handleSubmit = () => {
    mutate(formData)
}

</script>
<template>
    <MainLayout>
        <form @submit.prevent="handleSubmit">
            <p class="page_title">Login</p>
            <input type="text" placeholder="Email" v-model="formData.email">
            <input type="text" placeholder="Password" v-model="formData.password">
            <button type="submit">SUBMIT</button>
            <p v-if="isPending">Loading...</p>
            <p v-else-if="isError">{{ error?.message }}</p>
        </form>
    </MainLayout>
</template>

<style scoped>
form {
    max-width: 420px;
    margin: 20px auto;
    display: flex;
    flex-direction: column;
    gap: 20px;
    height: 100%;
}

.page_title {
    align-self: center;
    font-size: 36px;
    margin-bottom: 20px;
}

input {
    background: none;
    border: none;
    outline: none;
    font-size: 20px;
    color: #ffffffa8;
    border-bottom: 1px solid #ffffff11;
    padding: 8px;
}

button[type="submit"] {
    font-size: larger;
    background: hsla(160, 70%, 37%, 1);
    border: none;
    padding: 8px;
    border-radius: 2px;
    cursor: pointer;
}</style>