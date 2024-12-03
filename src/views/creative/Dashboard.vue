<template>
  <div class="py-6 bg-gray-50">
    <div class="max-w-7xl mx-auto py-6 sm:px-6 lg:px-8">
      <!-- Profile Status -->
      <div class="bg-white overflow-hidden shadow rounded-lg divide-y divide-gray-200 mb-6">
        <div class="px-4 py-5 sm:px-6">
          <h3 class="text-lg leading-6 font-medium text-gray-900">Profile Status</h3>
          <p class="mt-1 max-w-2xl text-sm text-gray-500">Complete your profile to increase visibility to partners.</p>
        </div>
        <div class="px-4 py-5 sm:p-6">
          <div class="space-y-4">
            <div class="flex items-center justify-between">
              <div class="flex items-center">
                <div class="flex-shrink-0">
                  <div v-if="profile.photoUrl" class="h-12 w-12 rounded-full overflow-hidden">
                    <img :src="profile.photoUrl" alt="Profile photo" class="h-full w-full object-cover" />
                  </div>
                  <div v-else class="h-12 w-12 rounded-full bg-gray-200 flex items-center justify-center">
                    <span class="text-gray-500 text-lg">{{ initials }}</span>
                  </div>
                </div>
                <div class="ml-4">
                  <h4 class="text-lg font-medium text-gray-900">{{ profile.name || 'Complete Your Profile' }}</h4>
                  <p class="text-sm text-gray-500">{{ profile.location || 'Add your location' }}</p>
                </div>
              </div>
              <router-link
                to="/creative/profile"
                class="inline-flex items-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-primary-600 hover:bg-primary-700"
              >
                Edit Profile
              </router-link>
            </div>
            <div class="grid grid-cols-1 gap-4 sm:grid-cols-2">
              <div class="bg-gray-50 rounded-lg p-4">
                <h5 class="text-sm font-medium text-gray-500">Profile Completion</h5>
                <div class="mt-2 flex items-center">
                  <div class="flex-1 bg-gray-200 rounded-full h-2">
                    <div
                      class="bg-primary-500 rounded-full h-2"
                      :style="{ width: `${profileCompletion}%` }"
                    ></div>
                  </div>
                  <span class="ml-2 text-sm text-gray-500">{{ profileCompletion }}%</span>
                </div>
              </div>
              <div class="bg-gray-50 rounded-lg p-4">
                <h5 class="text-sm font-medium text-gray-500">Verification Status</h5>
                <p class="mt-1 text-sm" :class="verificationStatusColor">
                  {{ verificationStatus }}
                </p>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Recent Activity -->
      <div class="bg-white overflow-hidden shadow rounded-lg divide-y divide-gray-200">
        <div class="px-4 py-5 sm:px-6">
          <h3 class="text-lg leading-6 font-medium text-gray-900">Recent Activity</h3>
        </div>
        <div class="px-4 py-5 sm:p-6">
          <div v-if="recentActivity.length > 0" class="space-y-4">
            <div v-for="activity in recentActivity" :key="activity.id" class="flex items-start space-x-4">
              <div class="flex-shrink-0">
                <span class="inline-flex items-center justify-center h-8 w-8 rounded-full" :class="activity.iconBg">
                  <component :is="activity.icon" class="h-5 w-5" :class="activity.iconColor" />
                </span>
              </div>
              <div class="flex-1 min-w-0">
                <p class="text-sm font-medium text-gray-900">{{ activity.title }}</p>
                <p class="text-sm text-gray-500">{{ activity.description }}</p>
                <p class="text-xs text-gray-400 mt-1">{{ activity.timeAgo }}</p>
              </div>
            </div>
          </div>
          <div v-else class="text-center py-4">
            <p class="text-sm text-gray-500">No recent activity</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'
import { useRouter } from 'vue-router'
import { useAuthStore } from '@/stores/auth'
import { UserIcon, BriefcaseIcon } from '@heroicons/vue/24/outline'

const router = useRouter()
const authStore = useAuthStore()

// Mock profile data - replace with actual API call
const profile = ref({
  name: '',
  photoUrl: '',
  location: '',
  skills: [],
  completedFields: 0,
  totalFields: 8,
  verificationStatus: 'pending'
})

// Computed properties
const initials = computed(() => {
  if (!profile.value.name) return '?'
  return profile.value.name
    .split(' ')
    .map(n => n[0])
    .join('')
    .toUpperCase()
})

const profileCompletion = computed(() => {
  return Math.round((profile.value.completedFields / profile.value.totalFields) * 100)
})

const verificationStatus = computed(() => {
  switch (profile.value.verificationStatus) {
    case 'verified':
      return 'Verified'
    case 'pending':
      return 'Verification Pending'
    case 'rejected':
      return 'Verification Required'
    default:
      return 'Not Verified'
  }
})

const verificationStatusColor = computed(() => {
  switch (profile.value.verificationStatus) {
    case 'verified':
      return 'text-green-600'
    case 'pending':
      return 'text-yellow-600'
    case 'rejected':
      return 'text-red-600'
    default:
      return 'text-gray-600'
  }
})

// Mock recent activity - replace with actual API call
const recentActivity = ref([
  {
    id: 1,
    title: 'Profile Update',
    description: 'You updated your profile information',
    timeAgo: '2 hours ago',
    icon: 'UserIcon',
    iconBg: 'bg-blue-100',
    iconColor: 'text-blue-600'
  },
  {
    id: 2,
    title: 'New Job Application',
    description: 'You applied for Sound Engineer position at First Apostolic Church',
    timeAgo: '1 day ago',
    icon: 'BriefcaseIcon',
    iconBg: 'bg-green-100',
    iconColor: 'text-green-600'
  }
])

// Logout function
async function logout() {
  await authStore.logout()
  router.push('/login')
}
</script>
