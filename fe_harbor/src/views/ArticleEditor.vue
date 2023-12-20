<script setup lang="ts">
import { reactive } from 'vue';
import MainLayout from '../components/MainLayout.vue'
import { storeToRefs } from 'pinia';
import { useEditorStore } from '@/stores/article';

const {editorForm} = storeToRefs(useEditorStore())

function adjustHeight() {
  const element = document.getElementById('articleText')!!!!! // can throw if no id
  element.style.height = "5px";
  element.style.height = (element.scrollHeight+24) + "px";
}

</script>

<template>
  <MainLayout article>
    <form>
      <input v-model="editorForm.title" type="text" name="name" placeholder="Title" />
      <textarea
        contenteditable
        placeholder="Tell your story..."
        name="text"
        id="articleText"
        v-on:input="adjustHeight"
        v-model="editorForm.text"
      ></textarea>
    </form>
  </MainLayout>
</template>

<style scoped>
form {
  display: flex;
  gap: 8px;
  flex-direction: column;
  width: 720px;
  margin: 40px auto 0;
}

input,
textarea {
  width: 100%;
  background: none;
  border: none;
  border-radius: 4px;
  outline: none;
  color: #dcdcdcd4;
  padding: 4px;
}

input[name='name'] {
  font-size: 36px;
}

#articleText {
  font-size: 20px;
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  resize: none;
  overflow: auto;
  min-height: 700px;
  word-wrap: break-word;
}

#articleText[placeholder]:empty:before {
    content: attr(placeholder);
    color: #555; 
}
</style>
