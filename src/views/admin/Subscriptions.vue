<template>
  <div class="bg-white p-6">
    <h1 class="text-2xl font-bold text-gray-800 mb-6">Subscription Analytics</h1>

    <!-- Stats Overview -->
    <div class="grid grid-cols-1 md:grid-cols-4 gap-4 mb-6">
      <div class="bg-blue-50 p-4 rounded-lg shadow">
        <h3 class="text-blue-600 text-sm font-semibold">Active Subscriptions</h3>
        <p class="text-2xl font-bold">{{ stats.activeSubscriptions }}</p>
        <p class="text-sm text-gray-600">{{ stats.subscriptionGrowth }}% growth</p>
      </div>
      <div class="bg-green-50 p-4 rounded-lg shadow">
        <h3 class="text-green-600 text-sm font-semibold">Monthly Revenue</h3>
        <p class="text-2xl font-bold">${{ stats.monthlyRevenue }}</p>
        <p class="text-sm text-gray-600">{{ stats.revenueGrowth }}% from last month</p>
      </div>
      <div class="bg-purple-50 p-4 rounded-lg shadow">
        <h3 class="text-purple-600 text-sm font-semibold">Avg. Subscription Length</h3>
        <p class="text-2xl font-bold">{{ stats.avgSubscriptionLength }} months</p>
      </div>
      <div class="bg-yellow-50 p-4 rounded-lg shadow">
        <h3 class="text-yellow-600 text-sm font-semibold">Churn Rate</h3>
        <p class="text-2xl font-bold">{{ stats.churnRate }}%</p>
        <p class="text-sm text-gray-600">Last 30 days</p>
      </div>
    </div>

    <!-- Revenue Chart -->
    <div class="mb-8 bg-white p-6 rounded-lg shadow">
      <div class="flex justify-between items-center mb-4">
        <h2 class="text-lg font-semibold">Revenue Overview</h2>
        <select
          v-model="revenueTimeframe"
          class="px-4 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500"
        >
          <option value="7">Last 7 days</option>
          <option value="30">Last 30 days</option>
          <option value="90">Last 90 days</option>
          <option value="365">Last year</option>
        </select>
      </div>
      <div class="h-64">
        <!-- Chart component will be placed here -->
        <div class="w-full h-full flex items-center justify-center text-gray-500">
          Revenue Chart Placeholder
        </div>
      </div>
    </div>

    <!-- Subscription Plans Performance -->
    <div class="mb-8">
      <h2 class="text-lg font-semibold mb-4">Subscription Plans Performance</h2>
      <div class="overflow-x-auto bg-white rounded-lg shadow">
        <table class="min-w-full divide-y divide-gray-200">
          <thead class="bg-gray-50">
            <tr>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Plan</th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Active Users</th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Revenue</th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Growth</th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Churn</th>
            </tr>
          </thead>
          <tbody class="bg-white divide-y divide-gray-200">
            <tr v-for="plan in subscriptionPlans" :key="plan.id">
              <td class="px-6 py-4 whitespace-nowrap">
                <div class="font-medium text-gray-900">{{ plan.name }}</div>
                <div class="text-sm text-gray-500">${{ plan.price }}/month</div>
              </td>
              <td class="px-6 py-4 whitespace-nowrap">
                <div class="text-sm text-gray-900">{{ plan.activeUsers }}</div>
                <div class="text-sm text-gray-500">
                  {{ plan.userGrowth > 0 ? '+' : '' }}{{ plan.userGrowth }}% this month
                </div>
              </td>
              <td class="px-6 py-4 whitespace-nowrap">
                <div class="text-sm text-gray-900">${{ plan.revenue }}</div>
                <div class="text-sm text-gray-500">
                  {{ plan.revenueGrowth > 0 ? '+' : '' }}{{ plan.revenueGrowth }}%
                </div>
              </td>
              <td class="px-6 py-4 whitespace-nowrap">
                <div
                  :class="{
                    'px-2 py-1 text-xs font-medium rounded-full inline-flex items-center': true,
                    'bg-green-100 text-green-800': plan.growth > 0,
                    'bg-red-100 text-red-800': plan.growth < 0,
                    'bg-gray-100 text-gray-800': plan.growth === 0
                  }"
                >
                  <span v-if="plan.growth > 0">↑</span>
                  <span v-else-if="plan.growth < 0">↓</span>
                  <span v-else>−</span>
                  {{ Math.abs(plan.growth) }}%
                </div>
              </td>
              <td class="px-6 py-4 whitespace-nowrap">
                <div class="text-sm text-gray-900">{{ plan.churnRate }}%</div>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>

    <!-- Recent Transactions -->
    <div class="mb-8">
      <h2 class="text-lg font-semibold mb-4">Recent Transactions</h2>
      <div class="overflow-x-auto bg-white rounded-lg shadow">
        <table class="min-w-full divide-y divide-gray-200">
          <thead class="bg-gray-50">
            <tr>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Customer</th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Plan</th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Amount</th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Status</th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Date</th>
            </tr>
          </thead>
          <tbody class="bg-white divide-y divide-gray-200">
            <tr v-for="transaction in recentTransactions" :key="transaction.id">
              <td class="px-6 py-4 whitespace-nowrap">
                <div class="flex items-center">
                  <div class="h-8 w-8 flex-shrink-0">
                    <img
                      :src="transaction.avatar || '/default-avatar.png'"
                      class="h-8 w-8 rounded-full"
                      alt=""
                    />
                  </div>
                  <div class="ml-4">
                    <div class="font-medium text-gray-900">{{ transaction.customer }}</div>
                    <div class="text-sm text-gray-500">{{ transaction.email }}</div>
                  </div>
                </div>
              </td>
              <td class="px-6 py-4 whitespace-nowrap">{{ transaction.plan }}</td>
              <td class="px-6 py-4 whitespace-nowrap">${{ transaction.amount }}</td>
              <td class="px-6 py-4 whitespace-nowrap">
                <span
                  :class="{
                    'px-2 py-1 text-xs font-medium rounded-full': true,
                    'bg-green-100 text-green-800': transaction.status === 'successful',
                    'bg-red-100 text-red-800': transaction.status === 'failed',
                    'bg-yellow-100 text-yellow-800': transaction.status === 'pending'
                  }"
                >
                  {{ transaction.status }}
                </span>
              </td>
              <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                {{ formatDate(transaction.date) }}
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'

// State
const revenueTimeframe = ref('30')
const stats = ref({
  activeSubscriptions: 0,
  subscriptionGrowth: 0,
  monthlyRevenue: 0,
  revenueGrowth: 0,
  avgSubscriptionLength: 0,
  churnRate: 0
})

const subscriptionPlans = ref([])
const recentTransactions = ref([])

// Mock data - replace with API calls
const fetchAnalytics = async () => {
  // Simulate API call
  stats.value = {
    activeSubscriptions: 250,
    subscriptionGrowth: 15,
    monthlyRevenue: 12500,
    revenueGrowth: 8,
    avgSubscriptionLength: 8,
    churnRate: 2.5
  }

  subscriptionPlans.value = [
    {
      id: 1,
      name: 'Basic',
      price: 29,
      activeUsers: 120,
      userGrowth: 10,
      revenue: 3480,
      revenueGrowth: 8,
      growth: 12,
      churnRate: 2.1
    },
    {
      id: 2,
      name: 'Pro',
      price: 49,
      activeUsers: 85,
      userGrowth: 15,
      revenue: 4165,
      revenueGrowth: 12,
      growth: 18,
      churnRate: 1.8
    },
    {
      id: 3,
      name: 'Enterprise',
      price: 99,
      activeUsers: 45,
      userGrowth: 20,
      revenue: 4455,
      revenueGrowth: 15,
      growth: 25,
      churnRate: 1.2
    }
  ]

  recentTransactions.value = [
    {
      id: 1,
      customer: 'John Doe',
      email: 'john@example.com',
      plan: 'Pro',
      amount: 49,
      status: 'successful',
      date: '2024-01-15',
      avatar: null
    },
    {
      id: 2,
      customer: 'Jane Smith',
      email: 'jane@example.com',
      plan: 'Enterprise',
      amount: 99,
      status: 'successful',
      date: '2024-01-14',
      avatar: null
    }
  ]
}

// Methods
const formatDate = (date) => {
  return new Date(date).toLocaleDateString()
}

// Lifecycle hooks
onMounted(() => {
  fetchAnalytics()
})
</script>
