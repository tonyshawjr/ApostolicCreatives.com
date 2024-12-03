<template>
  <div class=" bg-[#f9fafb]">
    <!-- Profile Header -->
    <div class="mb-8">
      <div class="bg-gradient-to-r from-purple-800 to-pink-600 h-32"></div>
      <div class="max-w-5xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="-mt-16 sm:-mt-20 sm:flex sm:items-end sm:space-x-5">
          <div class="relative group">
            <div class="h-24 w-24 sm:h-32 sm:w-32 rounded-full overflow-hidden ring-4 ring-white">
              <img
                v-if="profile.photoUrl"
                :src="profile.photoUrl"
                alt="Profile photo"
                class="h-full w-full object-cover"
              />
              <div
                v-else
                class="h-full w-full bg-gray-200 flex items-center justify-center"
              >
                <UserCircleIcon class="h-16 w-16 text-gray-400" />
              </div>
            </div>
            <button
              @click="triggerPhotoUpload"
              class="absolute bottom-0 right-0 bg-white rounded-full p-2 shadow-lg hover:bg-gray-50"
            >
              <PencilIcon class="h-5 w-5 text-gray-500" />
            </button>
            <input
              ref="photoInput"
              type="file"
              accept="image/*"
              class="hidden"
              @change="handlePhotoUpload"
            />
          </div>
          <div class="mt-6 sm:flex-1 sm:min-w-0 sm:flex sm:items-center sm:justify-end sm:space-x-6 sm:pb-1">
            <div class="sm:hidden md:block mt-6 min-w-0 flex-1">
              <h1 class="text-2xl font-bold text-gray-900 truncate">{{ profile.name || 'Add Your Name' }}</h1>
              <p class="text-gray-500">{{ profile.title || 'Add Your Title' }}</p>
            </div>
            <div class="mt-6 flex flex-col justify-stretch space-y-3 sm:flex-row sm:space-y-0 sm:space-x-4">
              <button
                @click="saveProfile"
                class="inline-flex justify-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-gradient-to-r from-purple-800 to-pink-600 hover:from-purple-700 hover:to-pink-500 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-purple-500"
              >
                Save Changes
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Profile Content -->
    <div class="max-w-5xl mx-auto px-4 sm:px-6 lg:px-8">
      <div class="space-y-6">
        <!-- Basic Information -->
        <div class="bg-white shadow rounded-lg">
          <div class="px-4 py-5 sm:p-6">
            <h3 class="text-lg font-medium text-gray-900 mb-4">Basic Information</h3>
            <div class="grid grid-cols-1 gap-6 sm:grid-cols-2">
              <div>
                <label for="name" class="block text-sm font-medium text-gray-700">Full Name</label>
                <input
                  type="text"
                  id="name"
                  v-model="profile.name"
                  class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-purple-500 focus:border-purple-500 sm:text-sm"
                />
              </div>
              <div>
                <label for="title" class="block text-sm font-medium text-gray-700">Professional Title</label>
                <input
                  type="text"
                  id="title"
                  v-model="profile.title"
                  class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-purple-500 focus:border-purple-500 sm:text-sm"
                />
              </div>
              <div>
                <label for="email" class="block text-sm font-medium text-gray-700">Email</label>
                <input
                  type="email"
                  id="email"
                  v-model="profile.email"
                  class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-purple-500 focus:border-purple-500 sm:text-sm"
                />
              </div>
              <div>
                <label for="phone" class="block text-sm font-medium text-gray-700">Phone</label>
                <input
                  type="tel"
                  id="phone"
                  v-model="profile.phone"
                  class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-purple-500 focus:border-purple-500 sm:text-sm"
                />
              </div>
              <div class="sm:col-span-2">
                <label for="location" class="block text-sm font-medium text-gray-700">Location</label>
                <input
                  type="text"
                  id="location"
                  v-model="profile.location"
                  class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-purple-500 focus:border-purple-500 sm:text-sm"
                />
              </div>
            </div>
          </div>
        </div>

        <!-- Skills -->
        <div class="bg-white shadow rounded-lg">
          <div class="px-4 py-5 sm:p-6">
            <h3 class="text-lg font-medium text-gray-900 mb-4">Skills</h3>
            <div class="space-y-4">
              <div class="flex flex-wrap gap-2">
                <span
                  v-for="skill in profile.skills"
                  :key="skill"
                  class="inline-flex items-center px-3 py-1 rounded-full text-sm font-medium bg-purple-100 text-purple-800"
                >
                  {{ skill }}
                  <button
                    @click="removeSkill(skill)"
                    class="ml-2 inline-flex items-center p-0.5 rounded-full text-purple-600 hover:bg-purple-200 focus:outline-none"
                  >
                    <XMarkIcon class="h-4 w-4" />
                  </button>
                </span>
              </div>
              <div class="flex gap-2">
                <input
                  type="text"
                  v-model="newSkill"
                  @keyup.enter="addSkill"
                  placeholder="Add a skill"
                  class="block w-full border-gray-300 rounded-md shadow-sm focus:ring-purple-500 focus:border-purple-500 sm:text-sm"
                />
                <button
                  @click="addSkill"
                  class="inline-flex items-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-gradient-to-r from-purple-800 to-pink-600 hover:from-purple-700 hover:to-pink-500 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-purple-500"
                >
                  Add
                </button>
              </div>
            </div>
          </div>
        </div>

        <!-- Portfolio Links -->
        <div class="bg-white shadow rounded-lg">
          <div class="px-4 py-5 sm:p-6">
            <h3 class="text-lg font-medium text-gray-900 mb-4">Portfolio Links</h3>
            <div class="space-y-4">
              <div v-for="(link, index) in profile.portfolioLinks" :key="index" class="flex gap-2">
                <input
                  type="text"
                  v-model="profile.portfolioLinks[index]"
                  class="block w-full border-gray-300 rounded-md shadow-sm focus:ring-purple-500 focus:border-purple-500 sm:text-sm"
                />
                <button
                  @click="removePortfolioLink(index)"
                  class="inline-flex items-center px-2 py-2 border border-gray-300 rounded-md text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-purple-500"
                >
                  <XMarkIcon class="h-5 w-5" />
                </button>
              </div>
              <button
                @click="addPortfolioLink"
                class="inline-flex items-center px-4 py-2 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-purple-500"
              >
                Add Portfolio Link
              </button>
            </div>
          </div>
        </div>

        <!-- About -->
        <div class="bg-white shadow rounded-lg">
          <div class="px-4 py-5 sm:p-6">
            <h3 class="text-lg font-medium text-gray-900 mb-4">About</h3>
            <textarea
              v-model="profile.about"
              rows="4"
              class="block w-full border-gray-300 rounded-md shadow-sm focus:ring-purple-500 focus:border-purple-500 sm:text-sm"
              placeholder="Tell us about yourself..."
            ></textarea>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { UserCircleIcon, PencilIcon, XMarkIcon } from '@heroicons/vue/24/solid'
import { useToast } from '@/composables/useToast'

const { showToast } = useToast()

const profile = ref({
  name: '',
  title: '',
  email: '',
  phone: '',
  location: '',
  photoUrl: '',
  skills: [],
  portfolioLinks: [],
  about: ''
})

const newSkill = ref('')
const photoInput = ref(null)

onMounted(async () => {
  try {
    // TODO: Fetch profile data from API
    // For now, using mock data
    profile.value = {
      name: 'Tony Shaw',
      title: 'Creative Director',
      email: 'tony@example.com',
      phone: '(555) 123-4567',
      location: 'New York, NY',
      photoUrl: '',
      skills: ['Graphic Design', 'Video Editing', 'Photography'],
      portfolioLinks: ['https://portfolio.example.com'],
      about: 'Creative professional with 5+ years of experience...'
    }
  } catch (error) {
    showToast('Error loading profile', 'error')
  }
})

function addSkill() {
  if (newSkill.value.trim() && !profile.value.skills.includes(newSkill.value.trim())) {
    profile.value.skills.push(newSkill.value.trim())
    newSkill.value = ''
  }
}

function removeSkill(skill) {
  profile.value.skills = profile.value.skills.filter(s => s !== skill)
}

function addPortfolioLink() {
  profile.value.portfolioLinks.push('')
}

function removePortfolioLink(index) {
  profile.value.portfolioLinks.splice(index, 1)
}

function triggerPhotoUpload() {
  photoInput.value.click()
}

async function handlePhotoUpload(event) {
  const file = event.target.files[0]
  if (!file) return

  try {
    // TODO: Implement photo upload to server
    // For now, just create a local URL
    profile.value.photoUrl = URL.createObjectURL(file)
    showToast('Photo uploaded successfully', 'success')
  } catch (error) {
    showToast('Error uploading photo', 'error')
  }
}

async function saveProfile() {
  try {
    // TODO: Implement API call to save profile
    showToast('Profile saved successfully', 'success')
  } catch (error) {
    showToast('Error saving profile', 'error')
  }
}
</script>

<style scoped>
/* Add any additional styles here */
</style>