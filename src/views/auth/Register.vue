<template>
  <div class="flex flex-col">
    <div class="flex-grow flex items-center justify-center bg-gray-50 py-24 px-4 sm:px-6 lg:px-8">
      <div class="max-w-7xl mx-auto w-full">
        <!-- Header Section -->
        <div class="text-center mb-12">
          <h1 class="text-4xl font-bold text-gray-900 mb-3">Get Started with Apostolic Creatives</h1>
          <p class="text-xl text-gray-600">Join our growing community of creative professionals and churches.</p>
        </div>

        <div class="grid grid-cols-1 lg:grid-cols-12 gap-12">
          <!-- Left Column - Information -->
          <div class="lg:col-span-5 space-y-8">
            <!-- For Creatives Box -->
            <div class="bg-white p-8 rounded-xl shadow-sm border border-gray-100">
              <h2 class="text-2xl font-semibold text-gray-900 mb-6">For Creatives</h2>
              <ul class="space-y-4">
                <li class="flex items-start">
                  
                  <span class="text-lg text-gray-600"><strong>Step 1:</strong> Sign up to create your profile and access the platform.</span>
                </li>
                <li class="flex items-start">
                  
                  <span class="text-lg text-gray-600"><strong>Step 2:</strong> After registration, a team member will guide you through the pastor recommendation process.</span>
                </li>
              </ul>
            </div>

            <!-- For Partners Box -->
            <div class="bg-purple-50 p-8 rounded-xl shadow-sm border border-purple-100">
              <h2 class="text-2xl font-semibold text-purple-900 mb-6">For Partners (Churches and Ministries)</h2>
              <p class="text-lg text-purple-700 mb-6">Partners require a different onboarding process. Contact us to schedule a call, so we can guide you through the setup and vetting process.</p>
              <a 
                href="/contact"
                class="inline-flex items-center px-6 py-3 border border-purple-300 text-base font-medium rounded-md text-purple-700 bg-white hover:bg-purple-50"
              >
                Schedule a Call
                <svg class="ml-2 -mr-1 h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
                </svg>
              </a>
            </div>
          </div>

          <!-- Right Column - Registration Form -->
          <div class="lg:col-span-7">
            <div class="bg-white p-10 rounded-xl shadow-sm border border-gray-100">
              

              <!-- Google Sign Up -->
              <button
                @click="handleGoogleRegister"
                type="button"
                class="w-full flex justify-center items-center px-6 py-3 rounded-md border border-gray-300 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-purple-500"
              >
                <img class="h-6 w-6 mr-3" src="https://www.svgrepo.com/show/475656/google-color.svg" alt="Google logo" />
                <span class="text-base text-gray-700 font-medium">Sign up with Google</span>
              </button>

              <div class="relative my-8">
                <div class="absolute inset-0 flex items-center">
                  <div class="w-full border-t border-gray-200"></div>
                </div>
                <div class="relative flex justify-center text-base">
                  <span class="px-4 bg-white text-gray-500">Or continue with email</span>
                </div>
              </div>

              <!-- Registration Form -->
              <form class="space-y-6" @submit.prevent="handleRegister">
                <div class="space-y-6">
                  <div>
                    <label for="fullName" class="block text-base font-medium text-gray-700">Full Name</label>
                    <input
                      id="fullName"
                      v-model="fullName"
                      type="text"
                      required
                      class="input-field mt-1"
                      placeholder="Enter your full name"
                    />
                  </div>

                  <div>
                    <label for="email" class="block text-base font-medium text-gray-700">Email Address</label>
                    <input
                      id="email"
                      v-model="email"
                      type="email"
                      required
                      class="input-field mt-1"
                      placeholder="your@email.com"
                    />
                  </div>

                  <div>
                    <label for="password" class="block text-base font-medium text-gray-700">Password</label>
                    <input
                      id="password"
                      v-model="password"
                      type="password"
                      required
                      class="input-field mt-1"
                      placeholder="Create a strong password"
                    />
                  </div>

                  <div>
                    <label for="skills" class="block text-base font-medium text-gray-700">Primary Role or Skill</label>
                    <select
                      id="skills"
                      v-model="primarySkill"
                      required
                      class="input-field mt-1"
                    >
                      <option value="">Select your primary skill</option>
                      <option value="musician">Musician</option>
                      <option value="childrens_ministry">Children's Ministry Leader</option>
                      <option value="media_consultant">Media Consultant</option>
                      <option value="graphic_design">Graphic Designer</option>
                      <option value="video_editing">Video Editor</option>
                      <option value="photography">Photographer</option>
                      <option value="web_development">Web Developer</option>
                      <option value="social_media">Social Media Manager</option>
                      <option value="content_writing">Content Writer</option>
                    </select>
                  </div>
                </div>

                <div class="space-y-6">
                  <div class="flex items-start">
                    <div class="flex items-center h-5">
                      <input
                        id="terms"
                        v-model="acceptedTerms"
                        type="checkbox"
                        required
                        class="h-6 w-6 text-purple-600 focus:ring-purple-500 border-gray-300 rounded"
                      />
                    </div>
                    <div class="ml-3">
                      <label for="terms" class="text-base text-gray-600">
                        I agree to the 
                        <a href="/terms" class="text-purple-600 hover:text-purple-500">Terms of Service</a>
                        and
                        <a href="/privacy" class="text-purple-600 hover:text-purple-500">Privacy Policy</a>
                      </label>
                    </div>
                  </div>

                  <div v-if="error" class="text-red-600 text-base text-center">
                    {{ error }}
                  </div>

                  <button
                    type="submit"
                    :disabled="loading"
                    class="btn-primary w-full py-3 text-base"
                  >
                    <span>{{ loading ? 'Creating account...' : 'Create My Account' }}</span>
                  </button>

                  <p class="text-center text-base text-gray-600">
                    Already have an account? 
                    <router-link to="/login" class="font-medium text-purple-600 hover:text-purple-500">
                      Sign in
                    </router-link>
                  </p>
                </div>
              </form>
            </div>
          </div>
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
const fullName = ref('')
const email = ref('')
const password = ref('')
const primarySkill = ref('')
const acceptedTerms = ref(false)
const error = ref('')
const loading = ref(false)

async function handleGoogleRegister() {
  try {
    loading.value = true
    error.value = ''
    const result = await authStore.googleRegister()
    
    if (result.success) {
      router.push('/dashboard')
    } else {
      error.value = result.error || 'Google registration failed'
    }
  } catch (err) {
    error.value = 'Google registration failed. Please try again.'
    console.error('Google registration error:', err)
  } finally {
    loading.value = false
  }
}

async function handleRegister() {
  try {
    loading.value = true
    error.value = ''

    const result = await authStore.register({
      fullName: fullName.value,
      email: email.value,
      password: password.value,
      primarySkill: primarySkill.value,
      userType: 'creative'
    })

    if (result.success) {
      router.push('/dashboard')
    } else {
      error.value = result.error || 'Registration failed'
    }
  } catch (err) {
    error.value = 'An unexpected error occurred. Please try again.'
    console.error('Registration error:', err)
  } finally {
    loading.value = false
  }
}
</script>

<style scoped>
.input-field {
  @apply appearance-none relative block w-full px-4 py-3 border border-gray-300 rounded-md placeholder-gray-500 text-gray-900 focus:outline-none focus:ring-purple-500 focus:border-purple-500 focus:z-10 text-base;
}

.btn-primary {
  @apply relative px-6 border border-transparent font-medium rounded-md text-white bg-purple-600 hover:bg-purple-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-purple-500 disabled:opacity-50 disabled:cursor-not-allowed;
}
</style>
