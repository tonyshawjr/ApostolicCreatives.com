<template>
  <div>
    <component :is="layout">
      <router-view></router-view>
    </component>
    <Toast />
  </div>
</template>

<script setup>
import { computed } from 'vue'
import { useRoute } from 'vue-router'
import Toast from '@/components/Toast.vue'
import MainLayout from '@/layouts/MainLayout.vue'

const route = useRoute()

// List of routes that should use the default layout
const publicRoutes = ['/login', '/register', '/forgot-password', '/reset-password', '/']

// Determine which layout to use based on the route
const layout = computed(() => {
  return publicRoutes.some(path => route.path.startsWith(path)) ? 'div' : MainLayout
})
</script>

<style>
.btn-primary {
  @apply inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500;
}
</style>
