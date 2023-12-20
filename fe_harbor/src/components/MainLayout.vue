<script setup lang="ts">
import IconHouse from './icons/IconHouse.vue';
import {useQuery} from "@tanstack/vue-query";
import {me} from "@/api/user"
import router from '@/router';
import IconLogo from './icons/IconLogo.vue';
import { useEditorStore } from '@/stores/article';
import { createArticle } from '@/api/article';
const props = defineProps({article: Boolean}) 
const access_token = localStorage.getItem("access_token")
const {data, isPending} = useQuery({queryKey: ["user"], queryFn: me}) 

const editorStore = useEditorStore()

function logout(){
    localStorage.removeItem("access_token")
    router.push("/login")
}

function publish(){
    createArticle({name: editorStore.$state.editorForm.title, text: editorStore.$state.editorForm.text})
}

</script>
<template>
    <nav>
        <RouterLink to="/" style="height: 42px; padding: 0; background: none;">
            <IconLogo/>
        </RouterLink>
        <div class="actions">
            <a v-on:click="publish" id="publish" v-if="article">Publish</a>
            <RouterLink v-if="!access_token" to="/register" id="register">Sign In</RouterLink>
            <RouterLink v-if="!access_token" to="/login">Log In</RouterLink>
            <p v-if="access_token">{{ data?.data.email }}</p>
            <button v-on:click="logout" v-if="access_token" id="logout">Log Out</button>
        </div>
    </nav>
    <slot/>
</template>

<style scoped>
 nav {
    display: flex;
    justify-content: space-between;
    align-items: center;
    max-width: 900px;
    margin: 0 auto;
 }
 #register {
    background: hsla(160, 100%, 37%, 1);
    color: #000000d2;
    font-weight: 700;
    border-radius: 2px;
    margin-right: 12px;
 }
 .actions {
    display: flex;
    align-items: center;
    gap: 12px;
 }
 #publish {
    font-size: 16px;
    margin-right: 20px;
    background-color: rgb(31, 31, 31);
    font-weight: 500;
    border-radius: 24px;
    padding: 4px 8px;
 }
 #logout {
    background: none;
    color: hsla(160, 40%, 37%, 1);
    font-size: 16px;
    border: none;
    cursor: pointer;
 }
</style>