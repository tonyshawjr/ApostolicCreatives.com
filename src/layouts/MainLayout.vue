<template>
  <div class="min-h-screen bg-gray-50">
    <LoggedInHeader />
    <main>
      <div class="max-w-[1280px] mx-auto px-4 sm:px-6 lg:px-8">
        <router-view></router-view>
      </div>
    </main>
    <AppFooter :isAuthenticated="true" />
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { useAuthStore } from '@/stores/auth'
import AppFooter from '@/components/AppFooter.vue'
import LoggedInHeader from '@/components/LoggedInHeader.vue'

const router = useRouter()
const route = useRoute()
const authStore = useAuthStore()
const mobileMenuOpen = ref(false)

const isAuthenticated = computed(() => authStore.isAuthenticated)

const user = computed(() => authStore.user)
const userInitials = computed(() => {
  if (!user.value?.email) return ''
  return user.value.email.charAt(0).toUpperCase()
})

const navigationLinks = computed(() => {
  if (!isAuthenticated.value) {
    return [
      { name: 'Home', to: '/' },
      { name: 'About', to: '/about' },
      { name: 'Why Us', to: '/why-us' },
      { name: 'Pricing', to: '/pricing' },
      { name: 'Contact', to: '/contact' }
    ]
  }

  const userRole = authStore.userRole
  if (userRole === 'creative') {
    return [
      { name: 'Dashboard', to: '/creative/dashboard' },
      { name: 'Projects', to: '/creative/projects' },
      { name: 'Messages', to: '/creative/messages' }
    ]
  } else if (userRole === 'partner') {
    return [
      { name: 'Dashboard', to: '/partner/dashboard' },
      { name: 'Creatives', to: '/partner/creatives' },
      { name: 'Projects', to: '/partner/projects' }
    ]
  } else if (userRole === 'admin') {
    return [
      { name: 'Dashboard', to: '/admin/dashboard' },
      { name: 'Verifications', to: '/admin/verifications' },
      { name: 'Users', to: '/admin/users' },
      { name: 'Jobs', to: '/admin/jobs' },
      { name: 'Subscriptions', to: '/admin/subscriptions' },
      { name: 'Reports', to: '/admin/reports' }
    ]
  }
  
  return []
})

function isCurrentRoute(path) {
  return route.path === path
}

async function logout() {
  mobileMenuOpen.value = false
  await authStore.logout()
  router.push('/')
}
</script>

<style scoped>
.router-link-active {
  color: #6B21A8;
}
</style>