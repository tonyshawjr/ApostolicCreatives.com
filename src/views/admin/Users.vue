<template>
  <div class="min-h-screen bg-gray-50 py-8">
    <!-- Header -->
    <div class="flex justify-between items-center mb-6">
      <h1 class="text-2xl font-semibold text-gray-900">User Management</h1>
      <div class="flex items-center gap-4">
        <button
          @click="showMetrics = !showMetrics"
          class="text-gray-600 hover:text-gray-900 px-4 py-2 rounded-lg border border-gray-200 hover:border-gray-300"
        >
          {{ showMetrics ? 'Hide Metrics' : 'Show Metrics' }}
        </button>
        <button
          class="bg-purple-600 text-white px-4 py-2 rounded-lg hover:bg-purple-700 focus:outline-none focus:ring-2 focus:ring-purple-500 focus:ring-offset-2"
        >
          Add New User
        </button>
      </div>
    </div>

    <!-- Metrics Section -->
    <div v-if="showMetrics" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4 mb-6">
      <div v-for="metric in userMetrics" :key="metric.label" class="bg-white p-4 rounded-lg shadow">
        <h3 class="text-sm text-gray-500">{{ metric.label }}</h3>
        <p class="text-2xl font-semibold">{{ metric.value }}</p>
        <div class="flex items-center mt-2">
          <span :class="metric.trend === 'up' ? 'text-green-500' : 'text-red-500'">
            {{ metric.percentage }}%
          </span>
          <span class="text-gray-500 text-sm ml-2">vs last month</span>
        </div>
      </div>
    </div>

    <!-- Filters Section -->
    <div class="mb-8">
      <div class="flex space-x-4 mb-4">
        <!-- Search -->
        <div class="flex-1">
          <input
            type="text"
            v-model="searchQuery"
            :placeholder="getSearchPlaceholder"
            class="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-transparent"
          />
        </div>

        <!-- Role Filter for Team -->
        <div v-if="activeTab === 'team'" class="min-w-[200px]">
          <select
            v-model="roleFilter"
            class="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-transparent"
          >
            <option value="">Filter by Role</option>
            <option v-for="role in uniqueRoles" :key="role" :value="role">
              {{ role }}
            </option>
          </select>
        </div>

        <!-- Partner Filters -->
        <select
          v-if="activeTab === 'partners'"
          v-model="subscriptionFilter"
          class="w-48 px-4 py-2 border rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-transparent bg-white"
        >
          <option value="">All Subscriptions</option>
          <option value="basic">Basic ($29/month)</option>
          <option value="premium">Premium ($99/month)</option>
        </select>

        <!-- Status Filter for Creatives -->
        <div v-if="activeTab === 'creatives'" class="min-w-[150px]">
          <select
            v-model="statusFilter"
            class="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-transparent"
          >
            <option value="">All Status</option>
            <option value="active">Active</option>
            <option value="inactive">Inactive</option>
          </select>
        </div>

        <!-- Pastoral verification filter (creatives only) -->
        <select
          v-if="activeTab === 'creatives'"
          v-model="pastoralVerificationFilter"
          class="px-4 py-2 border rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-transparent bg-white"
        >
          <option value="">Filter by Pastoral Verification</option>
          <option :value="true">Verified by Pastor</option>
          <option :value="false">Not Verified by Pastor</option>
        </select>

        <!-- Skill filter (creatives only) -->
        <select
          v-if="activeTab === 'creatives'"
          v-model="skillFilter"
          class="px-4 py-2 border rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-transparent bg-white"
        >
          <option value="">Filter by Skill</option>
          <option v-for="skill in uniqueSkills" :key="skill" :value="skill">
            {{ skill }}
          </option>
        </select>

        <!-- Department filter (team only) -->
        <select
          v-if="activeTab === 'team'"
          v-model="departmentFilter"
          class="px-4 py-2 border rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-transparent bg-white"
        >
          <option value="">Filter by Department</option>
          <option v-for="dept in uniqueDepartments" :key="dept" :value="dept">
            {{ dept }}
          </option>
        </select>
      </div>
    </div>

    <!-- Tabs -->
    <div class="mb-6">
      <div class="border-b border-gray-200">
        <nav class="-mb-px flex space-x-8">
          <button
            v-for="tab in tabs"
            :key="tab.id"
            @click="activeTab = tab.id"
            :class="[
              activeTab === tab.id
                ? 'border-purple-600 text-purple-600'
                : 'border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300',
              'whitespace-nowrap pb-4 px-1 border-b-2 font-medium text-sm'
            ]"
          >
            {{ tab.name }}
          </button>
        </nav>
      </div>
    </div>

    <!-- User Tables -->
    <div class="overflow-x-auto">
      <!-- Creatives Table -->
      <table v-if="activeTab === 'creatives'" class="min-w-full divide-y divide-gray-200">
        <thead class="bg-gray-50">
          <tr>
            <th v-for="header in creativeHeaders" :key="header" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
              {{ header }}
            </th>
            <th scope="col" class="relative px-6 py-3 w-[120px]">
              <span class="sr-only">Actions</span>
            </th>
          </tr>
        </thead>
        <tbody class="divide-y divide-gray-200">
          <tr v-for="item in paginatedData" :key="item.id" class="hover:bg-gray-50">
            <td class="px-6 py-4 whitespace-nowrap">{{ item.name }}</td>
            <td class="px-6 py-4 whitespace-nowrap">{{ item.primarySkill }}</td>
            <td class="px-6 py-4 whitespace-nowrap">
              <span :class="getActiveStatusClass(item.currentPosition)">
                {{ item.currentPosition ? 'Active' : 'Inactive' }}
              </span>
            </td>
            <td class="px-6 py-4 whitespace-nowrap">
              <span :class="getReferenceStatusClass(item.pastoralVerification)">
                {{ item.pastoralVerification ? 'Current' : 'Expired' }}
              </span>
            </td>
            <td class="px-6 py-4 whitespace-nowrap">{{ item.pastoralReference }}</td>
            <td class="px-6 py-4 whitespace-nowrap">{{ item.lastActive }}</td>
            <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
              <button @click="editUser(item)" class="text-purple-600 hover:text-purple-900 mr-4">Edit</button>
              <button @click="deleteUser(item)" class="text-red-600 hover:text-red-900">Delete</button>
            </td>
          </tr>
        </tbody>
      </table>

      <!-- Partners Table -->
      <table v-if="activeTab === 'partners'" class="min-w-full divide-y divide-gray-200">
        <thead class="bg-gray-50">
          <tr>
            <th v-for="header in partnerHeaders" :key="header" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
              {{ header }}
            </th>
            <th scope="col" class="relative px-6 py-3 w-[120px]">
              <span class="sr-only">Actions</span>
            </th>
          </tr>
        </thead>
        <tbody class="divide-y divide-gray-200">
          <tr v-for="item in paginatedData" :key="item.id" class="hover:bg-gray-50">
            <td class="px-6 py-4 whitespace-nowrap">{{ item.name }}</td>
            <td class="px-6 py-4 whitespace-nowrap">{{ item.pastorName }}</td>
            <td class="px-6 py-4 whitespace-nowrap">{{ item.location }}</td>
            <td class="px-6 py-4 whitespace-nowrap">{{ item.activeJobPosts }}</td>
            <td class="px-6 py-4 whitespace-nowrap">{{ item.memberSince }}</td>
            <td class="px-6 py-4 whitespace-nowrap">
              <span :class="getSubscriptionClass(item.memberCount)">
                {{ getSubscriptionLevel(item.memberCount) }}
              </span>
            </td>
            <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
              <button @click="editUser(item)" class="text-purple-600 hover:text-purple-900 mr-4">Edit</button>
              <button @click="deleteUser(item)" class="text-red-600 hover:text-red-900">Delete</button>
            </td>
          </tr>
        </tbody>
      </table>

      <!-- Team Members Table -->
      <table v-if="activeTab === 'team'" class="min-w-full divide-y divide-gray-200">
        <thead class="bg-gray-50">
          <tr>
            <th v-for="header in teamHeaders" :key="header" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
              {{ header }}
            </th>
            <th scope="col" class="relative px-6 py-3">
              <span class="sr-only">Actions</span>
            </th>
          </tr>
        </thead>
        <tbody class="divide-y divide-gray-200">
          <tr v-for="item in paginatedData" :key="item.id" class="hover:bg-gray-50">
            <td class="px-6 py-4 whitespace-nowrap">{{ item.name }}</td>
            <td class="px-6 py-4 whitespace-nowrap">{{ item.role }}</td>
            <td class="px-6 py-4 whitespace-nowrap">{{ item.permissionLevel }}</td>
            <td class="px-6 py-4 whitespace-nowrap">{{ item.lastLogin }}</td>
            <td class="px-6 py-4 whitespace-nowrap">
              <span :class="getAccountStatusClass(item.accountStatus)" class="px-2 py-1 rounded-full text-xs">
                {{ item.accountStatus }}
              </span>
            </td>
            <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
              <button @click="editUser(item)" class="text-purple-600 hover:text-purple-900 mr-4">Edit</button>
              <button @click="deleteUser(item)" class="text-red-600 hover:text-red-900">Delete</button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>

    <!-- Pagination -->
    <div class="mt-6 flex items-center justify-between">
      <div class="flex items-center">
        <select
          v-model="itemsPerPage"
          class="px-3 py-2 border rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-transparent bg-white"
        >
          <option v-for="n in [10, 20, 30, 40, 50]" :key="n" :value="n">{{ n }}</option>
        </select>
        <span class="ml-2 text-sm text-gray-600">items per page</span>
      </div>
      
      <div class="flex items-center space-x-2">
        <button
          @click="previousPage"
          :disabled="currentPage === 1"
          class="px-4 py-2 border rounded-lg hover:bg-gray-50 disabled:opacity-50 disabled:cursor-not-allowed"
        >
          Previous
        </button>
        <span class="text-sm text-gray-600">
          Page {{ currentPage }} of {{ totalPages }}
        </span>
        <button
          @click="nextPage"
          :disabled="currentPage >= totalPages"
          class="px-4 py-2 border rounded-lg hover:bg-gray-50 disabled:opacity-50 disabled:cursor-not-allowed"
        >
          Next
        </button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, watch } from 'vue'

// Tab state
const activeTab = ref('creatives')
const tabs = [
  { id: 'creatives', name: 'Creatives' },
  { id: 'partners', name: 'Partners' },
  { id: 'team', name: 'Team Members' }
]

// Search and filter state
const searchQuery = ref('')
const statusFilter = ref('')
const skillFilter = ref('')
const departmentFilter = ref('')
const pastoralVerificationFilter = ref('')
const roleFilter = ref('')
const currentPage = ref(1)
const itemsPerPage = ref(10)
const totalItems = ref(0)
const subscriptionFilter = ref('')

// Table headers
const creativeHeaders = [
  'Name',
  'Primary Skill',
  'Status',
  'Reference Status',
  'Pastor',
  'Last Active'
]

const partnerHeaders = [
  'Church Name',
  'Pastor Name',
  'Location',
  'Active Job Posts',
  'Member Since',
  'Subscription'
]

const teamHeaders = [
  'Name',
  'Role',
  'Permission Level',
  'Last Login',
  'Account Status'
]

// Mock data
const creativesData = [
  {
    id: 1,
    name: 'John Doe',
    primarySkill: 'Worship Leader',
    location: 'New York, NY',
    verificationStatus: 'verified',
    pastoralVerification: true,
    pastoralReference: 'Smith Anderson',
    currentPosition: 'Music Director',
    lastActive: '2 hours ago'
  },
  {
    id: 2,
    name: 'Sarah Johnson',
    primarySkill: 'Vocals',
    location: 'Los Angeles, CA',
    verificationStatus: 'pending',
    pastoralVerification: false,
    pastoralReference: 'Williams Taylor',
    currentPosition: 'Worship Team',
    lastActive: '1 day ago'
  },
  {
    id: 3,
    name: 'Michael Brown',
    primarySkill: 'Sound Engineer',
    location: 'Chicago, IL',
    verificationStatus: 'verified',
    pastoralVerification: true,
    pastoralReference: 'James Wilson',
    currentPosition: 'Tech Lead',
    lastActive: '3 hours ago'
  },
  {
    id: 4,
    name: 'Emily Davis',
    primarySkill: 'Piano',
    location: 'Houston, TX',
    verificationStatus: 'verified',
    pastoralVerification: true,
    pastoralReference: 'Robert Johnson',
    currentPosition: 'Pianist',
    lastActive: '5 hours ago'
  },
  {
    id: 5,
    name: 'David Wilson',
    primarySkill: 'Guitar',
    location: 'Miami, FL',
    verificationStatus: 'pending',
    pastoralVerification: false,
    pastoralReference: 'Marcus Thompson',
    currentPosition: 'Lead Guitarist',
    lastActive: '1 week ago'
  },
  {
    id: 6,
    name: 'Lisa Anderson',
    primarySkill: 'Drums',
    location: 'Seattle, WA',
    verificationStatus: 'verified',
    pastoralVerification: true,
    pastoralReference: 'Michael Davis',
    currentPosition: 'Drummer',
    lastActive: '2 days ago'
  },
  {
    id: 7,
    name: 'James Taylor',
    primarySkill: 'Bass Guitar',
    location: 'Denver, CO',
    verificationStatus: 'unverified',
    pastoralVerification: false,
    pastoralReference: 'Christopher Lee',
    currentPosition: 'Bassist',
    lastActive: '4 days ago'
  },
  {
    id: 8,
    name: 'Maria Garcia',
    primarySkill: 'Vocals',
    location: 'Phoenix, AZ',
    verificationStatus: 'verified',
    pastoralVerification: true,
    pastoralReference: 'Wilson Clark',
    currentPosition: 'Lead Singer',
    lastActive: '6 hours ago'
  },
  {
    id: 9,
    name: 'Robert Martinez',
    primarySkill: 'Media Production',
    location: 'San Diego, CA',
    verificationStatus: 'pending',
    pastoralVerification: false,
    pastoralReference: 'Samuel Rodriguez',
    currentPosition: 'Media Director',
    lastActive: '3 days ago'
  },
  {
    id: 10,
    name: 'Jennifer Lee',
    primarySkill: 'Keyboard',
    location: 'Portland, OR',
    verificationStatus: 'verified',
    pastoralVerification: true,
    pastoralReference: 'Thomas King',
    currentPosition: 'Keyboardist',
    lastActive: '1 day ago'
  },
  {
    id: 11,
    name: 'William Turner',
    primarySkill: 'Worship Leader',
    location: 'Atlanta, GA',
    verificationStatus: 'verified',
    pastoralVerification: true,
    pastoralReference: 'David Wright',
    currentPosition: 'Assistant Director',
    lastActive: '5 days ago'
  },
  {
    id: 12,
    name: 'Amanda White',
    primarySkill: 'Vocals',
    location: 'Dallas, TX',
    verificationStatus: 'pending',
    pastoralVerification: false,
    pastoralReference: 'Richard Martinez',
    currentPosition: 'Worship Team',
    lastActive: '4 hours ago'
  },
  {
    id: 13,
    name: 'Christopher King',
    primarySkill: 'Guitar',
    location: 'Boston, MA',
    verificationStatus: 'verified',
    pastoralVerification: true,
    pastoralReference: 'Andrew Turner',
    currentPosition: 'Lead Guitarist',
    lastActive: '2 days ago'
  }
]

const partnersData = [
  {
    id: 1,
    name: 'First Apostolic Church',
    pastorName: 'John Smith',
    location: 'New York, NY',
    activeJobPosts: 3,
    memberCount: 750,
    memberSince: 'Jan 2023'
  },
  {
    id: 2,
    name: 'Grace Community Church',
    pastorName: 'Michael Johnson',
    location: 'Los Angeles, CA',
    activeJobPosts: 1,
    memberCount: 350,
    memberSince: 'Mar 2023'
  },
  {
    id: 3,
    name: 'Living Word Fellowship',
    pastorName: 'David Williams',
    location: 'Chicago, IL',
    activeJobPosts: 2,
    memberCount: 525,
    memberSince: 'Feb 2023'
  },
  {
    id: 4,
    name: 'New Life Tabernacle',
    pastorName: 'Robert Brown',
    location: 'Houston, TX',
    activeJobPosts: 0,
    memberCount: 450,
    memberSince: 'Apr 2023'
  },
  {
    id: 5,
    name: 'Faith Apostolic Center',
    pastorName: 'James Wilson',
    location: 'Phoenix, AZ',
    activeJobPosts: 4,
    memberCount: 600,
    memberSince: 'Dec 2022'
  },
  {
    id: 6,
    name: 'Abundant Life Church',
    pastorName: 'Thomas Davis',
    location: 'Miami, FL',
    activeJobPosts: 1,
    memberCount: 400,
    memberSince: 'May 2023'
  },
  {
    id: 7,
    name: 'Kingdom Worship Center',
    pastorName: 'William Taylor',
    location: 'Seattle, WA',
    activeJobPosts: 2,
    memberCount: 550,
    memberSince: 'Jan 2023'
  }
]

const teamData = [
  {
    id: 1,
    name: 'Alice Cooper',
    role: 'Platform Administrator',
    permissionLevel: 'Admin',
    lastLogin: '30 minutes ago',
    accountStatus: 'active'
  },
  {
    id: 2,
    name: 'Bob Wilson',
    role: 'Partner Development',
    permissionLevel: 'Editor',
    lastLogin: '2 hours ago',
    accountStatus: 'active'
  },
  {
    id: 3,
    name: 'Carol Martinez',
    role: 'Creative Ambassador',
    permissionLevel: 'Editor',
    lastLogin: '1 hour ago',
    accountStatus: 'active'
  },
  {
    id: 4,
    name: 'David Brown',
    role: 'Technical Lead',
    permissionLevel: 'Admin',
    lastLogin: '45 minutes ago',
    accountStatus: 'active'
  },
  {
    id: 5,
    name: 'Emma Davis',
    role: 'Community Manager',
    permissionLevel: 'Editor',
    lastLogin: '3 hours ago',
    accountStatus: 'active'
  },
  {
    id: 6,
    name: 'Frank Johnson',
    role: 'Partner Development',
    permissionLevel: 'Editor',
    lastLogin: '5 hours ago',
    accountStatus: 'active'
  },
  {
    id: 7,
    name: 'Grace Lee',
    role: 'Creative Ambassador',
    permissionLevel: 'Editor',
    lastLogin: '1 day ago',
    accountStatus: 'active'
  },
  {
    id: 8,
    name: 'Henry Zhang',
    role: 'Platform Support',
    permissionLevel: 'Editor',
    lastLogin: '4 hours ago',
    accountStatus: 'active'
  }
]

// Computed properties
const uniqueSkills = computed(() => {
  return [...new Set(creativesData.map(user => user.primarySkill))].sort()
})

const uniqueDepartments = computed(() => {
  return [...new Set([
    'Management',
    'Partner Success',
    'Creative Success',
    'Engineering',
    'Community',
    'Support'
  ])].sort()
})

const uniqueRoles = computed(() => {
  return [...new Set(teamData.map(member => member.role))].sort()
})

const getSearchPlaceholder = computed(() => {
  switch (activeTab.value) {
    case 'creatives':
      return 'Search by name, skill, or location...'
    case 'partners':
      return 'Search by church name, pastor name, or location...'
    case 'team':
      return 'Search by name, role, or department...'
    default:
      return 'Search...'
  }
})

// Filtered and paginated data
const filteredData = computed(() => {
  let data = []
  
  // Select data based on active tab
  switch (activeTab.value) {
    case 'creatives':
      data = creativesData
      break
    case 'partners':
      data = partnersData
      break
    case 'team':
      data = teamData
      break
    default:
      return []
  }

  // Apply search filter
  if (searchQuery.value.trim()) {
    const query = searchQuery.value.toLowerCase()
    data = data.filter(item => {
      if (activeTab.value === 'creatives') {
        return (
          item.name.toLowerCase().includes(query) ||
          item.primarySkill.toLowerCase().includes(query) ||
          item.currentPosition.toLowerCase().includes(query)
        )
      } else if (activeTab.value === 'partners') {
        return (
          item.name.toLowerCase().includes(query) ||
          item.pastorName.toLowerCase().includes(query)
        )
      } else {
        return (
          item.name.toLowerCase().includes(query) ||
          item.role.toLowerCase().includes(query)
        )
      }
    })
  }

  // Inside filteredData computed property, add this after the search filter:
// Apply subscription filter for partners
if (activeTab.value === 'partners' && subscriptionFilter.value) {
  data = data.filter(item => {
    if (subscriptionFilter.value === 'basic') {
      return parseInt(item.memberCount) < 500
    } else if (subscriptionFilter.value === 'premium') {
      return parseInt(item.memberCount) >= 500
    }
    return true
  })
}

  // Apply status filter
  if (statusFilter.value) {
    data = data.filter(item => {
      if (activeTab.value === 'creatives') {
        return item.verificationStatus === statusFilter.value
      } else if (activeTab.value === 'partners') {
        return item.subscriptionStatus === statusFilter.value
      } else {
        return item.accountStatus === statusFilter.value
      }
    })
  }

  // Apply skill filter (creatives only)
  if (activeTab.value === 'creatives' && skillFilter.value) {
    data = data.filter(item => item.primarySkill === skillFilter.value)
  }

  // Apply department filter (team only)
  if (activeTab.value === 'team' && departmentFilter.value) {
    data = data.filter(item => item.department === departmentFilter.value)
  }

  // Apply pastoral verification filter (creatives only)
  if (activeTab.value === 'creatives' && pastoralVerificationFilter.value !== '') {
    data = data.filter(item => item.pastoralVerification === pastoralVerificationFilter.value)
  }

  // Apply role filter for team members
  if (activeTab.value === 'team' && roleFilter.value) {
    data = data.filter(item => item.role === roleFilter.value)
  }

  // Update total items for pagination
  totalItems.value = data.length

  return data
})

// Paginated data
const paginatedData = computed(() => {
  const start = (currentPage.value - 1) * itemsPerPage.value
  const end = start + itemsPerPage.value
  return filteredData.value.slice(start, end)
})

// Total pages
const totalPages = computed(() => Math.ceil(totalItems.value / itemsPerPage.value))

// Reset filters when changing tabs
watch(activeTab, () => {
  searchQuery.value = ''
  statusFilter.value = ''
  roleFilter.value = ''
  subscriptionFilter.value = '' // Add this line
  currentPage.value = 1
})

// Metrics data
const showMetrics = ref(false)
const userMetrics = [
  {
    label: 'Total Creatives',
    value: '1,234',
    trend: 'up',
    percentage: 12
  },
  {
    label: 'Active Churches',
    value: '567',
    trend: 'up',
    percentage: 8
  },
  {
    label: 'Team Members',
    value: '45',
    trend: 'down',
    percentage: 3
  },
  {
    label: 'Pending Verifications',
    value: '89',
    trend: 'up',
    percentage: 15
  }
]

// Status helper functions
const getVerificationStatusClass = (status) => {
  switch (status) {
    case 'verified':
      return 'bg-green-100 text-green-800'
    case 'pending':
      return 'bg-yellow-100 text-yellow-800'
    case 'unverified':
      return 'bg-red-100 text-red-800'
    default:
      return 'bg-gray-100 text-gray-800'
  }
}

const getSubscriptionStatusClass = (status) => {
  switch (status) {
    case 'active':
      return 'bg-green-100 text-green-800'
    case 'trial':
      return 'bg-blue-100 text-blue-800'
    case 'expired':
      return 'bg-red-100 text-red-800'
    default:
      return 'bg-gray-100 text-gray-800'
  }
}

const getAccountStatusClass = (status) => {
  switch (status) {
    case 'active':
      return 'bg-green-100 text-green-800'
    case 'inactive':
      return 'bg-yellow-100 text-yellow-800'
    case 'suspended':
      return 'bg-red-100 text-red-800'
    default:
      return 'bg-gray-100 text-gray-800'
  }
}

const getActiveStatusClass = (position) => {
  return position 
    ? 'px-2 py-1 text-sm rounded-full bg-green-100 text-green-800'
    : 'px-2 py-1 text-sm rounded-full bg-gray-100 text-gray-800'
}

const getReferenceStatusClass = (verified) => {
  return verified
    ? 'px-2 py-1 text-sm rounded-full bg-emerald-100 text-emerald-800'
    : 'px-2 py-1 text-sm rounded-full bg-orange-100 text-orange-800'
}

const getSubscriptionLevel = (memberCount) => {
  return memberCount >= 500 ? '$99/month' : '$29/month'
}

const getSubscriptionClass = (memberCount) => {
  return memberCount >= 500
    ? 'px-2 py-1 text-sm rounded-full bg-purple-100 text-purple-800'
    : 'px-2 py-1 text-sm rounded-full bg-blue-100 text-blue-800'
}

// Pagination methods
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

// User actions
const editUser = (user) => {
  console.log('Edit user:', user)
}

const deleteUser = (user) => {
  console.log('Delete user:', user)
}

// Role descriptions for tooltips or documentation
const roleDescriptions = {
  'Platform Administrator': 'Manages overall platform operations and access',
  'Partner Development': 'Onboards and supports church partners',
  'Creative Ambassador': 'Onboards and supports creative professionals',
  'Technical Lead': 'Manages platform technical infrastructure',
  'Community Manager': 'Facilitates community engagement and growth',
  'Platform Support': 'Provides technical and general platform support'
}
</script>