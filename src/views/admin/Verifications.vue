<template>
  <div class="bg-white p-6">
    <h1 class="text-2xl font-bold text-gray-800 mb-6">Pastor Verification Management</h1>

    <!-- Stats Cards -->
    <div class="grid grid-cols-1 md:grid-cols-3 gap-4 mb-6">
      <div class="bg-yellow-50 p-4 rounded-lg shadow">
        <h3 class="text-yellow-600 text-sm font-semibold">Pending Verifications</h3>
        <p class="text-2xl font-bold">{{ stats.pending }}</p>
      </div>
      <div class="bg-green-50 p-4 rounded-lg shadow">
        <h3 class="text-green-600 text-sm font-semibold">Approved This Month</h3>
        <p class="text-2xl font-bold">{{ stats.approvedThisMonth }}</p>
      </div>
      <div class="bg-red-50 p-4 rounded-lg shadow">
        <h3 class="text-red-600 text-sm font-semibold">Rejected This Month</h3>
        <p class="text-2xl font-bold">{{ stats.rejectedThisMonth }}</p>
      </div>
    </div>

    <!-- Filter Controls -->
    <div class="mb-6 flex flex-wrap gap-4">
      <div class="flex-1">
        <input
          type="text"
          v-model="searchQuery"
          placeholder="Search by name or church..."
          class="w-full px-4 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500"
          @input="filterRequests"
        />
      </div>
      <div class="flex gap-2">
        <select
          v-model="statusFilter"
          class="px-4 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500"
          @change="filterRequests"
        >
          <option value="">All Status</option>
          <option value="pending">Pending</option>
          <option value="approved">Approved</option>
          <option value="rejected">Rejected</option>
        </select>
      </div>
    </div>

    <!-- Verification Requests Table -->
    <div class="overflow-x-auto bg-white rounded-lg shadow">
      <table class="min-w-full divide-y divide-gray-200">
        <thead class="bg-gray-50">
          <tr>
            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Pastor</th>
            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Church</th>
            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Documents</th>
            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Status</th>
            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Submitted</th>
            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Actions</th>
          </tr>
        </thead>
        <tbody class="bg-white divide-y divide-gray-200">
          <tr v-for="request in paginatedRequests" :key="request.id">
            <td class="px-6 py-4 whitespace-nowrap">
              <div class="flex items-center">
                <div class="h-10 w-10 flex-shrink-0">
                  <img
                    :src="request.avatar || '/default-avatar.png'"
                    class="h-10 w-10 rounded-full"
                    alt=""
                  />
                </div>
                <div class="ml-4">
                  <div class="font-medium text-gray-900">{{ request.name }}</div>
                  <div class="text-sm text-gray-500">{{ request.email }}</div>
                </div>
              </div>
            </td>
            <td class="px-6 py-4 whitespace-nowrap">
              <div class="text-sm text-gray-900">{{ request.church }}</div>
              <div class="text-sm text-gray-500">{{ request.location }}</div>
            </td>
            <td class="px-6 py-4 whitespace-nowrap">
              <button
                @click="viewDocuments(request)"
                class="text-blue-600 hover:text-blue-900"
              >
                View Documents
              </button>
            </td>
            <td class="px-6 py-4 whitespace-nowrap">
              <span
                :class="{
                  'px-2 py-1 text-xs font-medium rounded-full': true,
                  'bg-yellow-100 text-yellow-800': request.status === 'pending',
                  'bg-green-100 text-green-800': request.status === 'approved',
                  'bg-red-100 text-red-800': request.status === 'rejected'
                }"
              >
                {{ request.status }}
              </span>
            </td>
            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
              {{ formatDate(request.submittedAt) }}
            </td>
            <td class="px-6 py-4 whitespace-nowrap text-sm">
              <div class="flex space-x-2">
                <button
                  v-if="request.status === 'pending'"
                  @click="approveRequest(request.id)"
                  class="text-green-600 hover:text-green-900"
                >
                  Approve
                </button>
                <button
                  v-if="request.status === 'pending'"
                  @click="rejectRequest(request.id)"
                  class="text-red-600 hover:text-red-900"
                >
                  Reject
                </button>
                <button
                  v-if="request.status !== 'pending'"
                  @click="resetRequest(request.id)"
                  class="text-gray-600 hover:text-gray-900"
                >
                  Reset
                </button>
              </div>
            </td>
          </tr>
        </tbody>
      </table>
    </div>

    <!-- Pagination -->
    <div class="mt-4 flex items-center justify-between">
      <div class="flex items-center">
        <span class="text-sm text-gray-700">
          Showing {{ paginationStart }} to {{ paginationEnd }} of {{ totalRequests }} requests
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

    <!-- Document Preview Modal -->
    <div v-if="showDocumentModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center">
      <div class="bg-white rounded-lg p-6 max-w-2xl w-full mx-4">
        <div class="flex justify-between items-center mb-4">
          <h2 class="text-xl font-bold">Verification Documents</h2>
          <button @click="closeDocumentModal" class="text-gray-500 hover:text-gray-700">
            <span class="sr-only">Close</span>
            <svg class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
            </svg>
          </button>
        </div>
        <div class="space-y-4">
          <div v-for="doc in selectedRequest.documents" :key="doc.id" class="border rounded p-4">
            <div class="flex justify-between items-center">
              <div>
                <h3 class="font-medium">{{ doc.name }}</h3>
                <p class="text-sm text-gray-500">{{ doc.type }}</p>
              </div>
              <button
                @click="downloadDocument(doc)"
                class="text-blue-600 hover:text-blue-900"
              >
                Download
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'

// State
const requests = ref([])
const searchQuery = ref('')
const statusFilter = ref('')
const currentPage = ref(1)
const itemsPerPage = 10
const showDocumentModal = ref(false)
const selectedRequest = ref(null)

const stats = ref({
  pending: 0,
  approvedThisMonth: 0,
  rejectedThisMonth: 0
})

// Mock data - replace with API calls
const fetchRequests = async () => {
  // Simulate API call
  requests.value = [
    {
      id: 1,
      name: 'John Doe',
      email: 'john@example.com',
      church: 'First Assembly',
      location: 'Dallas, TX',
      status: 'pending',
      submittedAt: '2024-01-15',
      avatar: null,
      documents: [
        { id: 1, name: 'Ordination Certificate', type: 'PDF' },
        { id: 2, name: 'Church ID', type: 'Image' }
      ]
    },
    {
      id: 2,
      name: 'Jane Smith',
      email: 'jane@example.com',
      church: 'Grace Chapel',
      location: 'Houston, TX',
      status: 'approved',
      submittedAt: '2024-01-20',
      avatar: null,
      documents: [
        { id: 3, name: 'Ordination Certificate', type: 'PDF' },
        { id: 4, name: 'Church ID', type: 'Image' }
      ]
    }
  ]

  stats.value = {
    pending: 5,
    approvedThisMonth: 12,
    rejectedThisMonth: 3
  }
}

// Computed properties
const filteredRequests = computed(() => {
  let filtered = requests.value

  if (searchQuery.value) {
    const query = searchQuery.value.toLowerCase()
    filtered = filtered.filter(request => 
      request.name.toLowerCase().includes(query) ||
      request.church.toLowerCase().includes(query)
    )
  }

  if (statusFilter.value) {
    filtered = filtered.filter(request => request.status === statusFilter.value)
  }

  return filtered
})

const totalRequests = computed(() => filteredRequests.value.length)
const totalPages = computed(() => Math.ceil(totalRequests.value / itemsPerPage))
const paginationStart = computed(() => (currentPage.value - 1) * itemsPerPage + 1)
const paginationEnd = computed(() => Math.min(currentPage.value * itemsPerPage, totalRequests.value))

const paginatedRequests = computed(() => {
  const start = (currentPage.value - 1) * itemsPerPage
  const end = start + itemsPerPage
  return filteredRequests.value.slice(start, end)
})

// Methods
const filterRequests = () => {
  currentPage.value = 1
}

const formatDate = (date) => {
  return new Date(date).toLocaleDateString()
}

const viewDocuments = (request) => {
  selectedRequest.value = request
  showDocumentModal.value = true
}

const closeDocumentModal = () => {
  showDocumentModal.value = false
  selectedRequest.value = null
}

const downloadDocument = (document) => {
  // Implement document download functionality
  console.log('Download document:', document)
}

const approveRequest = async (requestId) => {
  try {
    // Implement API call to approve request
    console.log('Approve request:', requestId)
  } catch (error) {
    console.error('Error approving request:', error)
  }
}

const rejectRequest = async (requestId) => {
  try {
    // Implement API call to reject request
    console.log('Reject request:', requestId)
  } catch (error) {
    console.error('Error rejecting request:', error)
  }
}

const resetRequest = async (requestId) => {
  try {
    // Implement API call to reset request status
    console.log('Reset request:', requestId)
  } catch (error) {
    console.error('Error resetting request:', error)
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
  fetchRequests()
})
</script>
