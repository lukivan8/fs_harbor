<script setup lang="ts">
import MainLayout from '../components/MainLayout.vue';
import { useQuery } from "@tanstack/vue-query";
import { fetchArticles } from "../api/article";
const {isPending, data, isError, error} = useQuery({queryKey:["articles"], queryFn: fetchArticles})

</script> 
<template>
  <MainLayout>
    <RouterLink to="/article/new">Editor</RouterLink>
    <p v-if="data">{{ data.data.data }}</p>
    <p v-else-if="isPending">Loading...</p>
  </MainLayout>
</template>