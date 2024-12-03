<template>
  <div>
    <!-- Top Header -->
    <div class="bg-[#1F2937] border-b border-gray-700">
      <div class="max-w-[1280px] mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between items-center h-20">
          <!-- Logo -->
          <div class="flex-shrink-0">
            <h1 class="text-2xl font-bold text-white">Apostolic Creatives</h1>
          </div>

          <!-- Right Section -->
          <div class="flex items-center space-x-6">
            <!-- Desktop Order -->
            <div class="hidden md:flex items-center space-x-6">
              <!-- Notifications -->
              <button @click="toggleNotifications" class="text-gray-300 hover:text-white relative">
                <span class="sr-only">View notifications</span>
                <svg class="h-6 w-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6.002 6.002 0 00-4-5.659V5a2 2 0 10-4 0v.341C7.67 6.165 6 8.388 6 11v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9" />
                </svg>
                <span v-if="notifications.length" class="absolute -top-1 -right-1 h-4 w-4 bg-red-500 rounded-full flex items-center justify-center">
                  <span class="text-xs text-white">{{ notifications.length }}</span>
                </span>
              </button>

              <!-- Profile Section -->
              <div class="flex items-center space-x-4">
                <!-- Profile Dropdown -->
                <div class="relative">
                  <button @click="toggleDropdown" class="flex items-center space-x-3">
                    <img src="https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=3000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" alt="Tony Shaw" class="h-8 w-8 rounded-full object-cover">
                    <span class="hidden md:inline text-sm font-medium text-white">Tony Shaw</span>
                  </button>

                  <div v-if="isDropdownOpen" class="absolute right-0 mt-2 w-48 bg-white rounded-lg shadow-lg py-1 z-50">
                    <a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">Your Profile</a>
                    <a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">Settings</a>
                    <a href="#" @click="logout" class="block px-4 py-2 text-sm text-red-600 hover:bg-gray-100">Sign out</a>
                  </div>
                </div>
              </div>
            </div>

            <!-- Mobile Order -->
            <div class="flex md:hidden items-center space-x-6">
              <!-- Profile Section -->
              <div class="flex items-center space-x-4">
                <!-- Profile Dropdown -->
                <div class="relative">
                  <button @click="toggleDropdown" class="flex items-center space-x-3">
                    <img src="https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=3000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" alt="Tony Shaw" class="h-8 w-8 rounded-full object-cover">
                    <span class="hidden md:inline text-sm font-medium text-white">Tony Shaw</span>
                  </button>

                  <div v-if="isDropdownOpen" class="absolute right-0 mt-2 w-48 bg-white rounded-lg shadow-lg py-1 z-50">
                    <a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">Your Profile</a>
                    <a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">Settings</a>
                    <a href="#" @click="logout" class="block px-4 py-2 text-sm text-red-600 hover:bg-gray-100">Sign out</a>
                  </div>
                </div>
              </div>

              <!-- Notifications -->
              <button @click="toggleNotifications" class="text-gray-300 hover:text-white relative">
                <span class="sr-only">View notifications</span>
                <svg class="h-6 w-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6.002 6.002 0 00-4-5.659V5a2 2 0 10-4 0v.341C7.67 6.165 6 8.388 6 11v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9" />
                </svg>
                <span v-if="notifications.length" class="absolute -top-1 -right-1 h-4 w-4 bg-red-500 rounded-full flex items-center justify-center">
                  <span class="text-xs text-white">{{ notifications.length }}</span>
                </span>
              </button>

              <!-- Hamburger Menu (Mobile) -->
              <button 
                @click="toggleMobileMenu" 
                class="text-gray-300 hover:text-white"
              >
                <svg 
                  class="h-6 w-6" 
                  :class="{ 'hidden': isMobileMenuOpen }"
                  xmlns="http://www.w3.org/2000/svg" 
                  fill="none" 
                  viewBox="0 0 24 24" 
                  stroke="currentColor"
                >
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
                </svg>
                <svg 
                  class="h-6 w-6" 
                  :class="{ 'hidden': !isMobileMenuOpen }"
                  xmlns="http://www.w3.org/2000/svg" 
                  fill="none" 
                  viewBox="0 0 24 24" 
                  stroke="currentColor"
                >
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                </svg>
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Navigation Bar -->
    <div class="bg-gradient-to-r from-purple-800 to-pink-600 border-t border-gray-700">
      <div class="max-w-[1280px] mx-auto px-4 sm:px-6 lg:px-8">
        <!-- Desktop Navigation -->
        <div class="hidden md:flex space-x-8 h-12">
          <router-link 
            v-for="item in navigation"
            :key="item.path"
            :to="item.path"
            class="inline-flex items-center px-3 py-2 text-sm font-medium text-white hover:text-gray-300 transition-colors duration-200"
            :class="{ 'text-purple-800 border-b-2 border-purple-800': isCurrentRoute(item.path) }"
          >
            {{ item.name }}
          </router-link>
        </div>

        <!-- Mobile Navigation -->
        <div v-if="isMobileMenuOpen" class="md:hidden py-2">
          <div class="space-y-1">
            <router-link 
              v-for="item in navigation"
              :key="item.path"
              :to="item.path"
              class="block px-3 py-2 text-base font-medium text-white hover:text-white hover:bg-white/10 rounded-md transition-colors duration-200"
              :class="{ 'bg-white/5 backdrop-blur-sm': isCurrentRoute(item.path) }"
              @click="isMobileMenuOpen = false"
            >
              {{ item.name }}
            </router-link>
          </div>
        </div>
      </div>
    </div>

    <!-- Notification Drawer -->
    <Transition name="slide">
      <div v-if="showNotifications" 
           class="fixed inset-y-0 right-0 w-96 max-w-full bg-white shadow-xl z-50">
        <div class="h-full flex flex-col">
          <!-- Header -->
          <div class="px-6 py-4 border-b border-gray-100 flex justify-between items-center">
            <h2 class="text-xl font-semibold text-gray-900">Notifications</h2>
            <button @click="toggleNotifications" class="text-gray-400 hover:text-gray-500">
              <svg class="h-6 w-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
              </svg>
            </button>
          </div>

          <!-- Notification List -->
          <div class="flex-1 overflow-y-auto p-6">
            <div v-for="(notification, index) in notifications" 
                 :key="index"
                 class="mb-6 last:mb-0">
              <div class="flex items-start">
                <!-- Icon -->
                <div :class="[
                  'rounded-full p-2 mr-4',
                  notification.type === 'job' ? 'bg-purple-50' : '',
                  notification.type === 'event' ? 'bg-pink-50' : '',
                  notification.type === 'verification' ? 'bg-green-50' : ''
                ]">
                  <svg v-if="notification.type === 'job'" class="w-6 h-6 text-purple-600" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2" />
                  </svg>
                  <svg v-if="notification.type === 'event'" class="w-6 h-6 text-pink-600" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z" />
                  </svg>
                  <svg v-if="notification.type === 'verification'" class="w-6 h-6 text-green-600" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                  </svg>
                </div>
                <!-- Content -->
                <div class="flex-1">
                  <h3 class="text-sm font-medium text-gray-900">{{ notification.title }}</h3>
                  <p class="mt-1 text-sm text-gray-500">{{ notification.description }}</p>
                  <p class="mt-2 text-xs text-gray-400">{{ notification.time }}</p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </Transition>

    <!-- Overlay -->
    <Transition name="fade">
      <div v-if="showNotifications" 
           class="fixed top-0 inset-x-0 bottom-0 bg-black bg-opacity-50 z-10"
           @click="closeAllMenus"></div>
    </Transition>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'

const userName = ref('Tony Shaw')
const userAvatar = ref('https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=3000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D')
const router = useRouter()
const isDropdownOpen = ref(false)
const showNotifications = ref(false)
const isMobileMenuOpen = ref(false)

const notifications = ref([
  {
    type: 'job',
    title: 'New job application received',
    description: 'John Doe applied for the Sound Engineer role.',
    time: '2 hours ago'
  },
  {
    type: 'event',
    title: 'Upcoming event reminder',
    description: 'Team meeting scheduled for Friday at 2:00 PM.',
    time: '1 day ago'
  },
  {
    type: 'verification',
    title: 'Verification approved',
    description: 'Your account has been verified successfully.',
    time: '3 days ago'
  }
])

const navigation = [
  { name: 'Dashboard', path: '/admin/dashboard' },
  { name: 'Users', path: '/admin/users' },
  { name: 'Jobs', path: '/admin/jobs' },
  { name: 'Reports', path: '/admin/reports' },
  { name: 'Subscriptions', path: '/admin/subscriptions' },
  { name: 'Verifications', path: '/admin/verifications' }
]

const closeAllMenus = () => {
  isDropdownOpen.value = false
  showNotifications.value = false
  isMobileMenuOpen.value = false
}

const toggleDropdown = () => {
  isDropdownOpen.value = !isDropdownOpen.value
  if (isDropdownOpen.value) {
    showNotifications.value = false
    isMobileMenuOpen.value = false
  }
}

const toggleNotifications = () => {
  showNotifications.value = !showNotifications.value
  if (showNotifications.value) {
    isDropdownOpen.value = false
    isMobileMenuOpen.value = false
  }
}

const toggleMobileMenu = () => {
  isMobileMenuOpen.value = !isMobileMenuOpen.value
  if (isMobileMenuOpen.value) {
    isDropdownOpen.value = false
    showNotifications.value = false
  }
}

const logout = async () => {
  // Add your logout logic here
  await router.push('/login')
}

const isCurrentRoute = (path) => router.currentRoute.value.path === path
</script>

<style scoped>
.slide-enter-active,
.slide-leave-active {
  transition: transform 0.3s ease;
}

.slide-enter-from,
.slide-leave-to {
  transform: translateX(100%);
}

.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.3s ease;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}
</style>