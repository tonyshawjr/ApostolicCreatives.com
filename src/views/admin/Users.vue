<template>
  <div class="bg-white p-6">
    <h1 class="text-3xl font-extrabold tracking-tight text-gray-900 mb-6 sticky top-0 bg-white z-10">User Management</h1>
    <!-- Search and Filter -->
    <div class="mb-6 space-y-4">
      <div class="flex flex-col md:flex-row gap-4">
        <div class="flex-1">
          <input
            type="text"
            v-model="searchQuery"
            placeholder="Search users by name, email, or location..."
            class="w-full px-4 py-2 border border-gray-300 rounded-lg text-gray-900 placeholder-gray-500 focus:ring-2 focus:ring-purple-500 focus:border-purple-500"
            @input="filterUsers"
          />
        </div>
        <div class="flex flex-wrap gap-2 justify-center">
          <button
            v-for="type in userTypes"
            :key="type.value"
            @click="toggleUserType(type.value)"
            :class="{
              'px-4 py-2 rounded-lg font-medium transition-all duration-300': true,
              'bg-gradient-to-r from-purple-800 to-pink-600 text-white hover:from-purple-700 hover:to-pink-500': selectedUserTypes.includes(type.value),
              'bg-gray-100 text-gray-700 hover:bg-gray-200': !selectedUserTypes.includes(type.value)
            }"
          >
            {{ type.label }}
          </button>
        </div>
      </div>
      
      <div class="flex flex-col md:flex-row justify-between items-center gap-4">
        <div class="flex gap-2">
          <select
            v-model="statusFilter"
            class="px-4 py-2 border border-gray-300 rounded-lg text-gray-700 focus:ring-2 focus:ring-purple-500 focus:border-purple-500"
            @change="filterUsers"
          >
            <option value="">All Status</option>
            <option value="active">Active</option>
            <option value="pending">Pending Verification</option>
            <option value="inactive">Inactive</option>
            <option value="reported">Reported</option>
          </select>
        </div>
        
        <div class="flex gap-2">
          <button
            @click="showBulkActions = !showBulkActions"
            :class="{
              'px-4 py-2 rounded-lg font-medium transition-all duration-300': true,
              'bg-gradient-to-r from-purple-800 to-pink-600 text-white hover:from-purple-700 hover:to-pink-500': showBulkActions,
              'bg-gray-100 text-gray-700 hover:bg-gray-200': !showBulkActions
            }"
          >
            Bulk Actions
          </button>
          <button
            @click="exportUserData"
            class="px-4 py-2 bg-gray-100 text-gray-700 rounded-lg hover:bg-gray-200 transition-all duration-300"
          >
            Export Data
          </button>
        </div>
      </div>
    </div>
    <!-- Collapsible Metrics Tab -->
    <div class="mb-6">
      <button @click="showMetrics = !showMetrics" class="w-full px-4 py-2 bg-gray-100 text-gray-700 rounded-lg hover:bg-gray-200 transition-all duration-300">
        {{ showMetrics ? 'Hide Metrics' : 'Show Metrics' }}
      </button>
      <div v-if="showMetrics" class="mt-4">
        <UserMetricsSummary :metrics="userMetrics" />
      </div>
    </div>
    <!-- Users Table -->
    <div class="overflow-x-auto bg-white rounded-lg shadow border border-gray-200">
      <table class="min-w-full divide-y divide-gray-200">
        <thead class="bg-gray-50">
          <tr>
            <th class="px-6 py-3 text-left">
              <input
                type="checkbox"
                v-model="selectAll"
                @change="toggleSelectAll"
                class="rounded border-gray-300 text-purple-600 focus:ring-2 focus:ring-purple-500"
              />
            </th>
            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">User</th>
            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Type</th>
            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Location</th>
            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Join Date</th>
            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Status</th>
            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Last Active</th>
            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Actions</th>
          </tr>
        </thead>
        <tbody class="bg-white divide-y divide-gray-200">
          <tr v-for="user in paginatedUsers" :key="user.id" 
              :class="{ 'bg-purple-50': selectedUsers.includes(user.id) }">
            <td class="px-6 py-4">
              <input
                type="checkbox"
                v-model="selectedUsers"
                :value="user.id"
                class="rounded border-gray-300 text-purple-600 focus:ring-2 focus:ring-purple-500"
              />
            </td>
            <td class="px-6 py-4 whitespace-nowrap">
              <div class="flex items-center">
                <div class="h-10 w-10 flex-shrink-0">
                  <img
                    :src="user.avatar || '/default-avatar.png'"
                    class="h-10 w-10 rounded-full object-cover"
                    alt=""
                  />
                </div>
                <div class="ml-4">
                  <div class="font-medium text-gray-900">{{ user.name }}</div>
                  <div class="text-gray-500">{{ user.email }}</div>
                </div>
              </div>
            </td>
            <td class="px-6 py-4 whitespace-nowrap">
              <span
                :class="{
                  'px-2 py-1 text-xs font-medium rounded-full': true,
                  'bg-purple-100 text-purple-800': user.type === 'creative',
                  'bg-blue-100 text-blue-800': user.type === 'church',
                  'bg-pink-100 text-pink-800': user.type === 'team'
                }"
              >
                {{ user.type }}
              </span>
            </td>
            <td class="px-6 py-4 whitespace-nowrap text-gray-500">{{ user.location }}</td>
            <td class="px-6 py-4 whitespace-nowrap text-gray-500">{{ formatDate(user.joinedAt) }}</td>
            <td class="px-6 py-4 whitespace-nowrap">
              <span
                :class="{
                  'px-2 py-1 text-xs font-medium rounded-full': true,
                  'bg-green-100 text-green-800': user.status === 'active',
                  'bg-yellow-100 text-yellow-800': user.status === 'pending',
                  'bg-gray-100 text-gray-600': user.status === 'inactive',
                  'bg-red-100 text-red-800': user.status === 'reported'
                }"
              >
                {{ user.status }}
              </span>
            </td>
            <td class="px-6 py-4 whitespace-nowrap text-gray-500">{{ formatDate(user.lastActive) }}</td>
            <td class="px-6 py-4 whitespace-nowrap text-sm">
              <button
                @click="viewUser(user)"
                class="text-purple-600 hover:text-purple-900 font-medium mr-2"
              >
                View
              </button>
              <button
                @click="editUser(user)"
                class="text-purple-600 hover:text-purple-900 font-medium mr-2"
              >
                Edit
              </button>
              <button
                @click="toggleUserStatus(user)"
                :class="{
                  'text-red-600 hover:text-red-900 font-medium': user.status === 'active',
                  'text-green-600 hover:text-green-900 font-medium': user.status !== 'active'
                }"
              >
                {{ user.status === 'active' ? 'Deactivate' : 'Activate' }}
              </button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
    <!-- Pagination -->
    <div class="mt-4 flex flex-col md:flex-row items-center justify-between gap-4">
      <div class="flex items-center gap-4">
        <span class="text-sm text-gray-700">
          Showing {{ paginationStart }} to {{ paginationEnd }} of {{ totalUsers }} users
        </span>
        <select
          v-model="itemsPerPage"
          class="px-4 py-2 border border-gray-300 rounded-lg text-gray-700 focus:ring-2 focus:ring-purple-500 focus:border-purple-500"
          @change="updatePagination"
        >
          <option value="10">10</option>
          <option value="20">20</option>
          <option value="50">50</option>
        </select>
      </div>

      <div class="flex gap-2">
        <button
          @click="previousPage"
          :disabled="currentPage === 1"
          class="px-4 py-2 bg-gray-100 text-gray-700 rounded-lg hover:bg-gray-200 transition-all duration-300 disabled:opacity-50"
        >
          Previous
        </button>
        <button
          @click="nextPage"
          :disabled="currentPage === totalPages"
          class="px-4 py-2 bg-gray-100 text-gray-700 rounded-lg hover:bg-gray-200 transition-all duration-300 disabled:opacity-50"
        >
          Next
        </button>
      </div>
    </div>

    <!-- User Quick View Side Panel -->
    <UserQuickView
      v-if="selectedUser"
      :user="selectedUser"
      @close="selectedUser = null"
      @edit="editUser(selectedUser)"
      @message="sendMessage(selectedUser)"
    />
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import UserMetricsSummary from '@/components/users/UserMetricsSummary.vue'
import UserQuickView from '@/components/users/UserQuickView.vue'

// State
const users = ref([])
const searchQuery = ref('')
const roleFilter = ref('')
const statusFilter = ref('')
const currentPage = ref(1)
const itemsPerPage = ref(10)
const selectedUsers = ref([])
const selectAll = ref(false)
const showBulkActions = ref(false)
const selectedUser = ref(null)
const showMetrics = ref(false)

const userTypes = [
  { value: 'creative', label: 'Creatives' },
  { value: 'church', label: 'Church Partners' },
  { value: 'team', label: 'Team Members' }
]

const selectedUserTypes = ref([])

// Mock user metrics - replace with API call
const userMetrics = ref({
  activeCreatives: 45,
  activeChurches: 28,
  teamMembers: 12,
  pendingVerifications: 15,
  verifiedUsers: 75,
  expiredVerifications: 8,
  newUsersThisMonth: 23,
  recentlyActive: 62,
  inactiveUsers: 18
})

// Mock data - replace with API calls
const fetchUsers = async () => {
  // Simulate API call
  users.value = [
    {
      id: 1,
      name: 'John Doe',
      email: 'john@example.com',
      phone: '+1 (555) 123-4567',
      type: 'creative',
      location: 'New York, NY',
      status: 'active',
      joinedAt: '2023-01-15',
      lastActive: '2023-05-20',
      avatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=200&h=200&q=80',
      skills: ['Worship Leading', 'Piano', 'Vocals'],
      currentPosition: 'Worship Leader',
      pastoralReference: 'Pastor Mike Johnson'
    },
    {
      id: 2,
      name: 'Grace Church',
      email: 'info@gracechurch.org',
      phone: '+1 (555) 987-6543',
      type: 'church',
      location: 'Los Angeles, CA',
      status: 'active',
      joinedAt: '2023-02-20',
      lastActive: '2023-05-19',
      avatar: 'https://images.unsplash.com/photo-1488972685288-c3fd157d7c7a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=200&h=200&q=80',
      denomination: 'Non-denominational',
      size: '500-1000',
      currentOpenings: [
        { id: 1, position: 'Worship Leader' },
        { id: 2, position: 'Media Director' }
      ]
    },
    {
      id: 3,
      name: 'Sarah Wilson',
      email: 'sarah@windcreatives.org',
      phone: '+1 (555) 456-7890',
      type: 'team',
      location: 'Remote',
      status: 'active',
      joinedAt: '2023-03-10',
      lastActive: '2023-05-21',
      avatar: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=200&h=200&q=80',
      teamRole: 'Verification Specialist',
      permissions: ['Verify Users', 'Manage Applications', 'Send Messages'],
      assignedAreas: ['Creative Verification', 'Church Partnership']
    },
    {
      id: 4,
      name: 'Michael Chen',
      email: 'michael@example.com',
      phone: '+1 (555) 234-5678',
      type: 'creative',
      location: 'San Francisco, CA',
      status: 'pending',
      joinedAt: '2023-04-05',
      lastActive: '2023-05-18',
      avatar: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=200&h=200&q=80',
      skills: ['Video Production', 'Photography', 'Live Streaming'],
      currentPosition: 'Media Director',
      pastoralReference: 'Pastor Sarah Lee'
    },
    {
      id: 5,
      name: 'Life Church International',
      email: 'contact@lifechurch.org',
      phone: '+1 (555) 876-5432',
      type: 'church',
      location: 'Chicago, IL',
      status: 'active',
      joinedAt: '2023-01-30',
      lastActive: '2023-05-20',
      avatar: 'https://images.unsplash.com/photo-1514924013411-cbf25faa35bb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=200&h=200&q=80',
      denomination: 'Pentecostal',
      size: '1000+',
      currentOpenings: [
        { id: 1, position: 'Youth Pastor' },
        { id: 2, position: 'Sound Engineer' }
      ]
    },
    {
      id: 6,
      name: 'Emily Rodriguez',
      email: 'emily@windcreatives.org',
      phone: '+1 (555) 345-6789',
      type: 'team',
      location: 'Miami, FL',
      status: 'active',
      joinedAt: '2023-02-15',
      lastActive: '2023-05-21',
      avatar: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=200&h=200&q=80',
      teamRole: 'Church Relations Manager',
      permissions: ['Manage Churches', 'Review Applications', 'Send Messages'],
      assignedAreas: ['Church Outreach', 'Partnership Development']
    }
  ]
}

// Computed properties
const filteredUsers = computed(() => {
  let filtered = users.value

  if (searchQuery.value) {
    const query = searchQuery.value.toLowerCase()
    filtered = filtered.filter(user => 
      user.name.toLowerCase().includes(query) ||
      user.email.toLowerCase().includes(query) ||
      user.location.toLowerCase().includes(query)
    )
  }

  if (selectedUserTypes.value.length > 0) {
    filtered = filtered.filter(user => selectedUserTypes.value.includes(user.type))
  }

  if (statusFilter.value) {
    filtered = filtered.filter(user => user.status === statusFilter.value)
  }

  return filtered
})

const paginatedUsers = computed(() => {
  const start = (currentPage.value - 1) * itemsPerPage.value
  const end = start + itemsPerPage.value
  return filteredUsers.value.slice(start, end)
})

const totalUsers = computed(() => filteredUsers.value.length)
const totalPages = computed(() => Math.ceil(totalUsers.value / itemsPerPage.value))
const paginationStart = computed(() => (currentPage.value - 1) * itemsPerPage.value + 1)
const paginationEnd = computed(() => Math.min(currentPage.value * itemsPerPage.value, totalUsers.value))

// Methods
const filterUsers = () => {
  currentPage.value = 1
}

const formatDate = (date) => {
  return new Date(date).toLocaleDateString('en-US', {
    year: 'numeric',
    month: 'long',
    day: 'numeric'
  })
}

const viewUser = (user) => {
  selectedUser.value = user
}

const editUser = (user) => {
  // Implement edit user functionality
  console.log('Edit user:', user)
}

const sendMessage = (user) => {
  // Implement send message functionality
  console.log('Send message to:', user)
}

const toggleUserStatus = (user) => {
  // Implement toggle user status functionality
  user.status = user.status === 'active' ? 'inactive' : 'active'
}

const sendMessageToSelected = () => {
  // Implement send message to selected users functionality
  console.log('Send message to selected users:', selectedUsers.value)
}

const updateSelectedStatus = (status) => {
  // Implement update selected users status functionality
  selectedUsers.value.forEach(userId => {
    const user = users.value.find(u => u.id === userId)
    if (user) {
      user.status = status
    }
  })
  selectedUsers.value = []
  showBulkActions.value = false
}

const exportUserData = () => {
  // Implement export user data functionality
  const data = selectedUsers.value.length > 0
    ? users.value.filter(user => selectedUsers.value.includes(user.id))
    : users.value

  // Convert to CSV or Excel format
  console.log('Export user data:', data)
}

const toggleUserType = (type) => {
  if (selectedUserTypes.value.includes(type)) {
    selectedUserTypes.value = selectedUserTypes.value.filter(t => t !== type)
  } else {
    selectedUserTypes.value = [...selectedUserTypes.value, type]
  }
  filterUsers()
}

const toggleSelectAll = () => {
  if (selectAll.value) {
    selectedUsers.value = filteredUsers.value.map(user => user.id)
  } else {
    selectedUsers.value = []
  }
}

const updatePagination = () => {
  currentPage.value = 1
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
  fetchUsers()
})
</script>

<style>
  /* Add styles for better mobile layout, collapsible table columns, responsive filters and actions, card view for mobile, improved loading states, better spacing and touch targets, and sticky header and actions */
  @media (max-width: 768px) {
    .users-table {
      display: block;
      overflow-x: auto;
    }
    .users-table th, .users-table td {
      display: block;
    }
    .users-table th {
      position: sticky;
      top: 0;
      background-color: #fff;
    }
    .users-table td {
      padding: 10px;
    }
    .bulk-actions {
      position: sticky;
      top: 0;
      background-color: #fff;
    }
    .filters {
      display: flex;
      flex-wrap: wrap;
      justify-content: space-between;
    }
    .filter {
      margin-bottom: 10px;
    }
  }
</style>
