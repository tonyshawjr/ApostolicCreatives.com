<template>
  <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
    <!-- User Types -->
    <div class="bg-white rounded-xl shadow-sm p-6">
      <h3 class="text-lg font-semibold text-gray-800 mb-4">Users by Type</h3>
      <div class="space-y-4">
        <div class="flex justify-between items-center">
          <span class="text-gray-600">Active Creatives</span>
          <span class="text-blue-600 font-semibold">{{ metrics.activeCreatives }}</span>
        </div>
        <div class="flex justify-between items-center">
          <span class="text-gray-600">Active Churches</span>
          <span class="text-green-600 font-semibold">{{ metrics.activeChurches }}</span>
        </div>
        <div class="flex justify-between items-center">
          <span class="text-gray-600">Team Members</span>
          <span class="text-purple-600 font-semibold">{{ metrics.teamMembers }}</span>
        </div>
      </div>
    </div>

    <!-- Verification Status -->
    <div class="bg-white rounded-xl shadow-sm p-6">
      <h3 class="text-lg font-semibold text-gray-800 mb-4">Verification Status</h3>
      <div class="space-y-4">
        <div class="flex justify-between items-center">
          <span class="text-gray-600">Pending Verifications</span>
          <span class="text-yellow-600 font-semibold">{{ metrics.pendingVerifications }}</span>
        </div>
        <div class="flex justify-between items-center">
          <span class="text-gray-600">Verified Users</span>
          <span class="text-green-600 font-semibold">{{ metrics.verifiedUsers }}</span>
        </div>
        <div class="flex justify-between items-center">
          <span class="text-gray-600">Expired Verifications</span>
          <span class="text-red-600 font-semibold">{{ metrics.expiredVerifications }}</span>
        </div>
      </div>
    </div>

    <!-- Activity Metrics -->
    <div class="bg-white rounded-xl shadow-sm p-6">
      <h3 class="text-lg font-semibold text-gray-800 mb-4">Activity Metrics</h3>
      <div class="space-y-4">
        <div class="flex justify-between items-center">
          <span class="text-gray-600">New This Month</span>
          <span class="text-blue-600 font-semibold">{{ metrics.newUsersThisMonth }}</span>
        </div>
        <div class="flex justify-between items-center">
          <span class="text-gray-600">Recently Active</span>
          <span class="text-green-600 font-semibold">{{ metrics.recentlyActive }}</span>
        </div>
        <div class="flex justify-between items-center">
          <span class="text-gray-600">Inactive Users</span>
          <span class="text-gray-600 font-semibold">{{ metrics.inactiveUsers }}</span>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { defineProps } from 'vue'

const props = defineProps({
  metrics: {
    type: Object,
    required: true,
    default: () => ({
      activeCreatives: 0,
      activeChurches: 0,
      teamMembers: 0,
      pendingVerifications: 0,
      verifiedUsers: 0,
      expiredVerifications: 0,
      newUsersThisMonth: 0,
      recentlyActive: 0,
      inactiveUsers: 0
    })
  }
})
</script>
