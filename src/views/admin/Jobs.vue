<template>
  <div class="bg-white p-6">
    <h1 class="text-2xl font-bold text-gray-800 mb-6">Job Board Management</h1>

    <!-- Stats Cards -->
    <div class="grid grid-cols-1 md:grid-cols-3 gap-4 mb-6">
      <div class="bg-blue-50 p-4 rounded-lg shadow">
        <h3 class="text-blue-600 text-sm font-semibold">Active Jobs</h3>
        <p class="text-2xl font-bold">{{ stats.activeJobs }}</p>
      </div>
      <div class="bg-green-50 p-4 rounded-lg shadow">
        <h3 class="text-green-600 text-sm font-semibold">Jobs Posted This Month</h3>
        <p class="text-2xl font-bold">{{ stats.monthlyJobs }}</p>
      </div>
      <div class="bg-purple-50 p-4 rounded-lg shadow">
        <h3 class="text-purple-600 text-sm font-semibold">Total Applications</h3>
        <p class="text-2xl font-bold">{{ stats.totalApplications }}</p>
      </div>
    </div>

    <!-- Search and Filter -->
    <div class="mb-6 flex flex-wrap gap-4">
      <div class="flex-1">
        <input
          type="text"
          v-model="searchQuery"
          placeholder="Search jobs..."
          class="w-full px-4 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500"
          @input="filterJobs"
        />
      </div>
      <div class="flex gap-2">
        <select
          v-model="statusFilter"
          class="px-4 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500"
          @change="filterJobs"
        >
          <option value="">All Status</option>
          <option value="active">Active</option>
          <option value="expired">Expired</option>
          <option value="draft">Draft</option>
        </select>
        <select
          v-model="typeFilter"
          class="px-4 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500"
          @change="filterJobs"
        >
          <option value="">All Types</option>
          <option value="full-time">Full Time</option>
          <option value="part-time">Part Time</option>
          <option value="contract">Contract</option>
        </select>
      </div>
    </div>

    <!-- Jobs Table -->
    <div class="overflow-x-auto bg-white rounded-lg shadow">
      <table class="min-w-full divide-y divide-gray-200">
        <thead class="bg-gray-50">
          <tr>
            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Title</th>
            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Church</th>
            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Type</th>
            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Status</th>
            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Posted</th>
            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Applications</th>
            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Actions</th>
          </tr>
        </thead>
        <tbody class="bg-white divide-y divide-gray-200">
          <tr v-for="job in paginatedJobs" :key="job.id">
            <td class="px-6 py-4 whitespace-nowrap">
              <div class="font-medium text-gray-900">{{ job.title }}</div>
              <div class="text-sm text-gray-500">{{ job.location }}</div>
            </td>
            <td class="px-6 py-4 whitespace-nowrap">{{ job.church }}</td>
            <td class="px-6 py-4 whitespace-nowrap">
              <span
                :class="{
                  'px-2 py-1 text-xs font-medium rounded-full': true,
                  'bg-blue-100 text-blue-800': job.type === 'full-time',
                  'bg-green-100 text-green-800': job.type === 'part-time',
                  'bg-yellow-100 text-yellow-800': job.type === 'contract'
                }"
              >
                {{ job.type }}
              </span>
            </td>
            <td class="px-6 py-4 whitespace-nowrap">
              <span
                :class="{
                  'px-2 py-1 text-xs font-medium rounded-full': true,
                  'bg-green-100 text-green-800': job.status === 'active',
                  'bg-red-100 text-red-800': job.status === 'expired',
                  'bg-gray-100 text-gray-800': job.status === 'draft'
                }"
              >
                {{ job.status }}
              </span>
            </td>
            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
              {{ formatDate(job.postedAt) }}
            </td>
            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
              {{ job.applications }}
            </td>
            <td class="px-6 py-4 whitespace-nowrap text-sm">
              <button
                @click="editJob(job)"
                class="text-blue-600 hover:text-blue-900 mr-2"
              >
                Edit
              </button>
              <button
                v-if="job.status === 'active'"
                @click="deactivateJob(job.id)"
                class="text-red-600 hover:text-red-900"
              >
                Deactivate
              </button>
              <button
                v-else
                @click="activateJob(job.id)"
                class="text-green-600 hover:text-green-900"
              >
                Activate
              </button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>

    <!-- Pagination -->
    <div class="mt-4 flex items-center justify-between">
      <div class="flex items-center">
        <span class="text-sm text-gray-700">
          Showing {{ paginationStart }} to {{ paginationEnd }} of {{ totalJobs }} jobs
        </span>
      </div>
      <div class="flex items-center space-x-2">
        <button
          @click="previousPage"
          :disabled="currentPage === 1"
          class="px-3 py-1 border rounded-md disabled:opacity-50"
        >
          Previous
        </button>
        <span class="text-sm text-gray-700">Page {{ currentPage }} of {{ totalPages }}</span>
        <button
          @click="nextPage"
          :disabled="currentPage === totalPages"
          class="px-3 py-1 border rounded-md disabled:opacity-50"
        >
          Next
        </button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'

// State
const jobs = ref([])
const searchQuery = ref('')
const statusFilter = ref('')
const typeFilter = ref('')
const currentPage = ref(1)
const itemsPerPage = 10

const stats = ref({
  activeJobs: 0,
  monthlyJobs: 0,
  totalApplications: 0
})

// Mock data - replace with API calls
const fetchJobs = async () => {
  // Simulate API call
  jobs.value = [
    {
      id: 1,
      title: 'Worship Leader',
      church: 'First Assembly',
      type: 'full-time',
      status: 'active',
      location: 'Dallas, TX',
      postedAt: '2024-01-15',
      applications: 12
    },
    {
      id: 2,
      title: 'Media Director',
      church: 'Grace Chapel',
      type: 'part-time',
      status: 'active',
      location: 'Houston, TX',
      postedAt: '2024-01-20',
      applications: 8
    }
  ]

  stats.value = {
    activeJobs: 45,
    monthlyJobs: 12,
    totalApplications: 156
  }
}

// Computed properties
const filteredJobs = computed(() => {
  let filtered = jobs.value

  if (searchQuery.value) {
    const query = searchQuery.value.toLowerCase()
    filtered = filtered.filter(job => 
      job.title.toLowerCase().includes(query) ||
      job.church.toLowerCase().includes(query) ||
      job.location.toLowerCase().includes(query)
    )
  }

  if (statusFilter.value) {
    filtered = filtered.filter(job => job.status === statusFilter.value)
  }

  if (typeFilter.value) {
    filtered = filtered.filter(job => job.type === typeFilter.value)
  }

  return filtered
})

const totalJobs = computed(() => filteredJobs.value.length)
const totalPages = computed(() => Math.ceil(totalJobs.value / itemsPerPage))
const paginationStart = computed(() => (currentPage.value - 1) * itemsPerPage + 1)
const paginationEnd = computed(() => Math.min(currentPage.value * itemsPerPage, totalJobs.value))

const paginatedJobs = computed(() => {
  const start = (currentPage.value - 1) * itemsPerPage
  const end = start + itemsPerPage
  return filteredJobs.value.slice(start, end)
})

// Methods
const filterJobs = () => {
  currentPage.value = 1
}

const formatDate = (date) => {
  return new Date(date).toLocaleDateString()
}

const editJob = (job) => {
  // Implement edit job functionality
  console.log('Edit job:', job)
}

const deactivateJob = async (jobId) => {
  try {
    // Implement API call to deactivate job
    console.log('Deactivate job:', jobId)
  } catch (error) {
    console.error('Error deactivating job:', error)
  }
}

const activateJob = async (jobId) => {
  try {
    // Implement API call to activate job
    console.log('Activate job:', jobId)
  } catch (error) {
    console.error('Error activating job:', error)
  }
}

const previousPage = () => {
  if (currentPage.value > 1) {
    currentPage.value--
  }
}

const nextPage = () => {
  if (currentPage.value < totalPages.value) {
    currentPage.value++
  }
}

// Lifecycle hooks
onMounted(() => {
  fetchJobs()
})
</script>
