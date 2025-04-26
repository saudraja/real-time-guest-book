import { createRouter, createWebHistory } from 'vue-router';
import GuestbookView from '../views/GuestbookView.vue';
import AdminView from '../views/AdminView.vue';

const routes = [
  {
    path: '/',
    name: 'Guestbook',
    component: GuestbookView
  },
  {
    path: '/admin',
    name: 'Admin',
    component: AdminView
  }
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;
