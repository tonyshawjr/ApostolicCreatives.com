<template>
  <div class=" flex flex-col">
    <div class="flex-grow flex items-center justify-center bg-gray-50 py-24 px-4 sm:px-6 lg:px-8">
      <div class="max-w-md w-full bg-white rounded-xl shadow-md p-6">
        <div class="text-center mb-8">
          <h2 class="text-3xl font-bold text-gray-900">Sign in to your account</h2>
          <p class="mt-2 text-sm text-gray-600">Welcome back to Apostolic Creatives</p>
        </div>

        <!-- Quick Login Buttons -->
        <div class="mb-6 space-y-3">
          <button
            @click="quickLogin('creative@apostoliccreatives.com', 'Creative123!')"
            class="w-full px-4 py-2 text-sm font-medium text-white bg-purple-600 rounded-md hover:bg-purple-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-purple-500"
          >
            Login as Creative
          </button>
          <button
            @click="quickLogin('partner@apostoliccreatives.com', 'Partner123!')"
            class="w-full px-4 py-2 text-sm font-medium text-white bg-blue-600 rounded-md hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500"
          >
            Login as Partner
          </button>
          <button
            @click="quickLogin('admin@apostoliccreatives.com', 'Admin123!')"
            class="w-full px-4 py-2 text-sm font-medium text-white bg-green-600 rounded-md hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-green-500"
          >
            Login as Admin
          </button>
        </div>

        <div class="relative mb-6">
          <div class="absolute inset-0 flex items-center">
            <div class="w-full border-t border-gray-300"></div>
          </div>
          <div class="relative flex justify-center text-sm">
            <span class="px-2 bg-white text-gray-500">Or sign in manually</span>
          </div>
        </div>

        <form class="space-y-6" @submit.prevent="handleLogin">
          <div class="space-y-5">
            <div>
              <label for="email" class="sr-only">Email address</label>
              <input
                id="email"
                v-model="email"
                type="email"
                required
                class="input-field rounded-t-md"
                placeholder="Email address"
              />
            </div>
            <div>
              <label for="password" class="sr-only">Password</label>
              <input
                id="password"
                v-model="password"
                type="password"
                required
                class="input-field rounded-b-md"
                placeholder="Password"
              />
            </div>
          </div>

          <div v-if="error" class="text-red-600 text-sm text-center">
            {{ error }}
          </div>

          <div>
            <button
              type="submit"
              :disabled="loading"
              class="btn-primary w-full flex items-center justify-center"
            >
              <span>{{ loading ? 'Signing in...' : 'Sign in' }}</span>
            </button>
          </div>
        </form>

        <div class="mt-6">
          <div class="relative">
            <div class="absolute inset-0 flex items-center">
              <div class="w-full border-t border-gray-300"></div>
            </div>
            <div class="relative flex justify-center text-sm">
              <span class="px-2 bg-white text-gray-500">Or continue with</span>
            </div>
          </div>

          <div class="mt-6">
            <button
              @click="handleGoogleLogin"
              type="button"
              class="w-full inline-flex justify-center items-center px-4 py-2 rounded-md shadow-sm border border-gray-300 bg-white text-sm font-medium text-gray-700 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-purple-500"
            >
              <img class="h-5 w-5 mr-2" src="https://www.svgrepo.com/show/475656/google-color.svg" alt="Google logo" />
              <span>Sign in with Google</span>
            </button>
          </div>
        </div>

        <div class="mt-8 text-center text-sm">
          <span class="text-gray-600">Don't have an account? </span>
          <router-link
            to="/register"
            class="font-medium text-purple-600 hover:text-purple-500"
          >
            Sign up
          </router-link>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { useAuthStore } from '@/stores/auth'

const router = useRouter()
const authStore = useAuthStore()

const email = ref('')
const password = ref('')
const error = ref('')
const loading = ref(false)

async function quickLogin(testEmail, testPassword) {
  email.value = testEmail
  password.value = testPassword
  await handleLogin()
}

async function handleLogin() {
  try {
    loading.value = true
    error.value = ''
    console.log('Starting login process...')
    
    const result = await authStore.login({
      email: email.value,
      password: password.value
    })
    
    console.log('Login result:', result)
    
    if (result.success) {
      const userType = authStore.userType
      console.log('User type:', userType)
      
      if (userType === 'creative') {
        console.log('Redirecting to creative dashboard...')
        router.push('/creative/dashboard')
      } else if (userType === 'partner') {
        console.log('Redirecting to partner dashboard...')
        router.push('/partner/dashboard')
      } else if (userType === 'team') {
        console.log('Redirecting to admin dashboard...')
        router.push('/admin/dashboard')
      } else {
        console.error('Unknown user type:', userType)
        error.value = 'Invalid user type'
      }
    } else {
      error.value = result.error || 'Login failed'
    }
  } catch (e) {
    console.error('Login error:', e)
    error.value = 'An unexpected error occurred'
  } finally {
    loading.value = false
  }
}

function handleGoogleLogin() {
  // Implement Google login logic here
  console.log('Google login clicked')
}
</script>

<style scoped>
.input-field {
  @apply appearance-none relative block w-full px-3 py-2 border border-gray-300 placeholder-gray-500 text-gray-900 focus:outline-none focus:ring-purple-500 focus:border-purple-500 focus:z-10 sm:text-sm;
}

.btn-primary {
  @apply relative py-2 px-4 border border-transparent text-sm font-medium rounded-md text-white bg-purple-600 hover:bg-purple-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-purple-500;
}
</style>