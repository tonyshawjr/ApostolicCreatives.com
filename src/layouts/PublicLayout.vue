<template>
  <div class="bg-white">
    <!-- Public Header -->
    <header class="bg-white border-b border-gray-100">
      <div class="max-w-[1280px] mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between h-20">
          <div class="flex items-center">
            <router-link to="/" class="flex-shrink-0 flex items-center">
              <span class="text-2xl font-bold bg-gradient-to-r from-purple-800 to-pink-600 bg-clip-text text-transparent">Apostolic Creatives</span>
            </router-link>
            <nav class="hidden md:ml-10 md:flex md:space-x-8">
              <router-link to="/about" class="text-gray-600 hover:text-gray-900 px-3 py-2 text-sm font-medium transition-colors duration-200">
                About
              </router-link>
              <router-link to="/pricing" class="text-gray-600 hover:text-gray-900 px-3 py-2 text-sm font-medium transition-colors duration-200">
                Pricing
              </router-link>
              <router-link to="/why-us" class="text-gray-600 hover:text-gray-900 px-3 py-2 text-sm font-medium transition-colors duration-200">
                Why Us
              </router-link>
              <router-link to="/blog" class="text-gray-600 hover:text-gray-900 px-3 py-2 text-sm font-medium transition-colors duration-200">
                Blog
              </router-link>
              <router-link to="/faq" class="text-gray-600 hover:text-gray-900 px-3 py-2 text-sm font-medium transition-colors duration-200">
                FAQ
              </router-link>
              <router-link to="/contact" class="text-gray-600 hover:text-gray-900 px-3 py-2 text-sm font-medium transition-colors duration-200">
                Contact
              </router-link>
            </nav>
          </div>
          <div class="flex items-center space-x-4">
            <router-link to="/login" class="text-gray-600 hover:text-gray-900 px-4 py-2 text-sm font-medium transition-colors duration-200">
              Sign in
            </router-link>
            <router-link to="/register" class="inline-flex items-center px-4 py-2 text-sm font-medium rounded-lg text-white bg-gradient-to-r from-purple-800 to-pink-600 hover:opacity-90 transition-opacity">
              Sign up
            </router-link>
            <!-- Mobile menu button -->
            <button @click="mobileMenuOpen = !mobileMenuOpen" type="button" class="md:hidden inline-flex items-center justify-center p-2 rounded-md text-gray-600 hover:text-gray-900 hover:bg-gray-100 transition-colors duration-200">
              <span class="sr-only">Open main menu</span>
              <!-- Icon when menu is closed -->
              <svg v-if="!mobileMenuOpen" class="block h-6 w-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
              </svg>
              <!-- Icon when menu is open -->
              <svg v-else class="block h-6 w-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
              </svg>
            </button>
          </div>
        </div>
      </div>

      <!-- Mobile menu, show/hide based on menu state -->
      <div v-show="mobileMenuOpen" class="md:hidden border-t border-gray-100">
        <div class="pt-2 pb-3 space-y-1 px-4 sm:px-6 lg:px-8">
          <router-link to="/about" class="block px-3 py-2 text-base font-medium text-gray-600 hover:text-gray-900 hover:bg-gray-50 rounded-md transition-colors duration-200">
            About
          </router-link>
          <router-link to="/pricing" class="block px-3 py-2 text-base font-medium text-gray-600 hover:text-gray-900 hover:bg-gray-50 rounded-md transition-colors duration-200">
            Pricing
          </router-link>
          <router-link to="/why-us" class="block px-3 py-2 text-base font-medium text-gray-600 hover:text-gray-900 hover:bg-gray-50 rounded-md transition-colors duration-200">
            Why Us
          </router-link>
          <router-link to="/blog" class="block px-3 py-2 text-base font-medium text-gray-600 hover:text-gray-900 hover:bg-gray-50 rounded-md transition-colors duration-200">
            Blog
          </router-link>
          <router-link to="/faq" class="block px-3 py-2 text-base font-medium text-gray-600 hover:text-gray-900 hover:bg-gray-50 rounded-md transition-colors duration-200">
            FAQ
          </router-link>
          <router-link to="/contact" class="block px-3 py-2 text-base font-medium text-gray-600 hover:text-gray-900 hover:bg-gray-50 rounded-md transition-colors duration-200">
            Contact
          </router-link>
        </div>
      </div>
    </header>

    <!-- Main Content -->
    <main>
      <router-view></router-view>
    </main>

    <!-- Footer -->
    <AppFooter :isAuthenticated="false" />
  </div>
</template>

<script setup>
import { ref } from 'vue'
import AppFooter from '@/components/AppFooter.vue'

const mobileMenuOpen = ref(false)
</script>

<style scoped>
.router-link-active {
  color: #4F46E5;
}
</style>