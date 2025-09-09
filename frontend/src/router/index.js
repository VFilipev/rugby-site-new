import { createRouter, createWebHistory } from 'vue-router'

const routes = [
  {
    path: '/',
    name: 'home',
    component: () => import( '../views/HomePage.vue'),
  },
  {
    path: '/matches',
    name: 'matches',
    component: () => import( '../views/MatchesView.vue'),
  },
  {
    path: '/events',
    name: 'events',
    component: () => import( '../views/EventsView.vue'),
  },
  {
    path: '/team',
    name: 'team',
    component: () => import( '../views/TeamView.vue'),
  },
  {
    path: '/trophies',
    name: 'trophies',
    component: () => import( '../views/TrophiesView.vue'),
  },
  {
    path: '/school',
    name: 'school',
    component: () => import( '../views/SchoolView.vue'),
  },
  {
    path: '/schedule',
    name: 'schedule',
    component: () => import( '../views/ScheduleView.vue'),
  },
]

const router = createRouter({
  history: createWebHistory('/'),  // Всегда используем корневой путь для маршрутизации
  routes,
  scrollBehavior(to, from, savedPosition) {
    // Если есть якорь (например #section), прокручиваем к нему
    if (to.hash) {
      return {
        el: to.hash,
        behavior: 'smooth'
      }
    }
    // Если это возврат назад и есть сохраненная позиция, возвращаемся к ней
    if (savedPosition) {
      return savedPosition
    }
    // Во всех остальных случаях прокручиваем к верху
    return { top: 0 }
  }
})

export default router
