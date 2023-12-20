import { createRouter, createWebHistory } from 'vue-router'
import App from "../views/ArticleList.vue"
import ArticleEditor from "../views/ArticleEditor.vue"
import Register from "../views/Register.vue"
import Login from "@/views/Login.vue"

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: App
    },
    {
      path: "/article/new",
      name: "editor",
      component: ArticleEditor
    },
    {
      path:"/register",
      name: "register",
      component: Register
    },
    {
      path: "/login",
      name: "login",
      component: Login
    }
    ]
})

export default router
