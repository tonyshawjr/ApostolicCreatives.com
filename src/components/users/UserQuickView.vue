<template>
  <div v-if="user" class="fixed inset-y-0 right-0 w-96 bg-white shadow-lg border-l border-gray-200 overflow-y-auto">
    <div class="p-6">
      <!-- Header -->
      <div class="flex justify-between items-center mb-6">
        <h3 class="text-xl font-semibold text-gray-800">User Profile</h3>
        <button @click="$emit('close')" class="text-gray-400 hover:text-gray-600">
          <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
          </svg>
        </button>
      </div>

      <!-- Basic Info -->
      <div class="mb-8">
        <div class="flex items-center mb-4">
          <img :src="user.avatar || '/default-avatar.png'" class="w-16 h-16 rounded-full" :alt="user.name">
          <div class="ml-4">
            <h4 class="text-lg font-semibold text-gray-800">{{ user.name }}</h4>
            <p class="text-gray-500">{{ user.email }}</p>
          </div>
        </div>

        <div class="space-y-3">
          <div class="flex justify-between">
            <span class="text-gray-600">Phone</span>
            <span class="text-gray-800">{{ user.phone }}</span>
          </div>
          <div class="flex justify-between">
            <span class="text-gray-600">Location</span>
            <span class="text-gray-800">{{ user.location }}</span>
          </div>
          <div class="flex justify-between">
            <span class="text-gray-600">Member Since</span>
            <span class="text-gray-800">{{ formatDate(user.joinedAt) }}</span>
          </div>
        </div>
      </div>

      <!-- Role Specific Info -->
      <div v-if="user.role === 'creative'" class="mb-8">
        <h4 class="text-lg font-semibold text-gray-800 mb-4">Creative Details</h4>
        <div class="space-y-3">
          <div>
            <span class="text-gray-600 block mb-1">Skills/Expertise</span>
            <div class="flex flex-wrap gap-2">
              <span v-for="skill in user.skills" :key="skill" 
                    class="px-2 py-1 bg-blue-100 text-blue-800 rounded-full text-sm">
                {{ skill }}
              </span>
            </div>
          </div>
          <div>
            <span class="text-gray-600 block mb-1">Current Position</span>
            <span class="text-gray-800">{{ user.currentPosition }}</span>
          </div>
          <div>
            <span class="text-gray-600 block mb-1">Pastoral Reference</span>
            <span class="text-gray-800">{{ user.pastoralReference }}</span>
          </div>
        </div>
      </div>

      <div v-if="user.role === 'church'" class="mb-8">
        <h4 class="text-lg font-semibold text-gray-800 mb-4">Church Details</h4>
        <div class="space-y-3">
          <div>
            <span class="text-gray-600 block">Denomination</span>
            <span class="text-gray-800">{{ user.denomination }}</span>
          </div>
          <div>
            <span class="text-gray-600 block">Size</span>
            <span class="text-gray-800">{{ user.size }} members</span>
          </div>
          <div>
            <span class="text-gray-600 block mb-1">Current Openings</span>
            <div class="space-y-2">
              <div v-for="opening in user.currentOpenings" :key="opening.id" 
                   class="p-2 bg-gray-50 rounded-lg">
                {{ opening.position }}
              </div>
            </div>
          </div>
        </div>
      </div>

      <div v-if="user.role === 'team'" class="mb-8">
        <h4 class="text-lg font-semibold text-gray-800 mb-4">Team Member Details</h4>
        <div class="space-y-3">
          <div>
            <span class="text-gray-600 block">Role</span>
            <span class="text-gray-800">{{ user.teamRole }}</span>
          </div>
          <div>
            <span class="text-gray-600 block mb-1">Permissions</span>
            <div class="space-y-1">
              <div v-for="permission in user.permissions" :key="permission" 
                   class="text-sm text-gray-800">
                {{ permission }}
              </div>
            </div>
          </div>
          <div>
            <span class="text-gray-600 block mb-1">Assigned Areas</span>
            <div class="space-y-1">
              <div v-for="area in user.assignedAreas" :key="area" 
                   class="text-sm text-gray-800">
                {{ area }}
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Activity Logs -->
      <div class="mb-8">
        <h4 class="text-lg font-semibold text-gray-800 mb-4">Recent Activity</h4>
        <div class="space-y-4">
          <div v-for="activity in user.recentActivity" :key="activity.id" 
               class="border-l-2 border-gray-200 pl-4">
            <p class="text-gray-800">{{ activity.description }}</p>
            <p class="text-sm text-gray-500">{{ formatDate(activity.date) }}</p>
          </div>
        </div>
      </div>

      <!-- Actions -->
      <div class="flex gap-2">
        <button @click="$emit('edit')" 
                class="flex-1 px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700">
          Edit Profile
        </button>
        <button @click="$emit('message')" 
                class="flex-1 px-4 py-2 bg-gray-100 text-gray-800 rounded-lg hover:bg-gray-200">
          Send Message
        </button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { defineProps, defineEmits } from 'vue'

const props = defineProps({
  user: {
    type: Object,
    required: true
  }
})

const emit = defineEmits(['close', 'edit', 'message'])

const formatDate = (date) => {
  return new Date(date).toLocaleDateString('en-US', {
    year: 'numeric',
    month: 'long',
    day: 'numeric'
  })
}
</script>
