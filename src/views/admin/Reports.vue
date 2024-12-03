<template>
  <div class="bg-white p-6">
    <h1 class="text-2xl font-bold text-gray-800 mb-6">Reports</h1>

    <!-- Report Types -->
    <div class="grid grid-cols-1 md:grid-cols-3 gap-4 mb-8">
      <div
        v-for="report in reportTypes"
        :key="report.id"
        class="p-4 border rounded-lg hover:shadow-md cursor-pointer"
        :class="{ 'border-blue-500 bg-blue-50': selectedReport === report.id }"
        @click="selectReport(report.id)"
      >
        <div class="flex items-center">
          <div
            class="w-10 h-10 rounded-full flex items-center justify-center mr-3"
            :class="report.iconBg"
          >
            <i :class="[report.icon, report.iconColor]"></i>
          </div>
          <div>
            <h3 class="font-medium text-gray-900">{{ report.name }}</h3>
            <p class="text-sm text-gray-500">{{ report.description }}</p>
          </div>
        </div>
      </div>
    </div>

    <!-- Report Configuration -->
    <div class="mb-8 bg-white p-6 rounded-lg shadow" v-if="selectedReport">
      <h2 class="text-lg font-semibold mb-4">Report Configuration</h2>
      
      <!-- Date Range -->
      <div class="grid grid-cols-1 md:grid-cols-2 gap-4 mb-6">
        <div>
          <label class="block text-sm font-medium text-gray-700 mb-1">Start Date</label>
          <input
            type="date"
            v-model="startDate"
            class="w-full px-4 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500"
          />
        </div>
        <div>
          <label class="block text-sm font-medium text-gray-700 mb-1">End Date</label>
          <input
            type="date"
            v-model="endDate"
            class="w-full px-4 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500"
          />
        </div>
      </div>

      <!-- Filters -->
      <div class="grid grid-cols-1 md:grid-cols-3 gap-4 mb-6">
        <div>
          <label class="block text-sm font-medium text-gray-700 mb-1">Group By</label>
          <select
            v-model="groupBy"
            class="w-full px-4 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500"
          >
            <option value="day">Day</option>
            <option value="week">Week</option>
            <option value="month">Month</option>
          </select>
        </div>
        <div>
          <label class="block text-sm font-medium text-gray-700 mb-1">Format</label>
          <select
            v-model="format"
            class="w-full px-4 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500"
          >
            <option value="table">Table</option>
            <option value="chart">Chart</option>
            <option value="both">Both</option>
          </select>
        </div>
        <div>
          <label class="block text-sm font-medium text-gray-700 mb-1">Export As</label>
          <select
            v-model="exportFormat"
            class="w-full px-4 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500"
          >
            <option value="pdf">PDF</option>
            <option value="excel">Excel</option>
            <option value="csv">CSV</option>
          </select>
        </div>
      </div>

      <!-- Additional Filters -->
      <div class="mb-6">
        <h3 class="text-sm font-medium text-gray-700 mb-2">Additional Filters</h3>
        <div class="space-y-2">
          <label v-for="filter in reportFilters" :key="filter.id" class="flex items-center">
            <input
              type="checkbox"
              v-model="selectedFilters"
              :value="filter.id"
              class="h-4 w-4 text-blue-600 focus:ring-blue-500 border-gray-300 rounded"
            />
            <span class="ml-2 text-sm text-gray-700">{{ filter.name }}</span>
          </label>
        </div>
      </div>

      <!-- Generate Report Button -->
      <div class="flex justify-end">
        <button
          @click="generateReport"
          class="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2"
        >
          Generate Report
        </button>
      </div>
    </div>

    <!-- Report Preview -->
    <div v-if="reportData" class="mb-8">
      <div class="flex justify-between items-center mb-4">
        <h2 class="text-lg font-semibold">Report Preview</h2>
        <button
          @click="downloadReport"
          class="px-4 py-2 bg-green-600 text-white rounded-lg hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-green-500 focus:ring-offset-2"
        >
          Download Report
        </button>
      </div>

      <!-- Report Content -->
      <div class="bg-white rounded-lg shadow overflow-hidden">
        <!-- Table View -->
        <div v-if="format !== 'chart'" class="overflow-x-auto">
          <table class="min-w-full divide-y divide-gray-200">
            <thead class="bg-gray-50">
              <tr>
                <th
                  v-for="column in reportColumns"
                  :key="column"
                  class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase"
                >
                  {{ column }}
                </th>
              </tr>
            </thead>
            <tbody class="bg-white divide-y divide-gray-200">
              <tr v-for="(row, index) in reportData" :key="index">
                <td
                  v-for="column in reportColumns"
                  :key="column"
                  class="px-6 py-4 whitespace-nowrap text-sm text-gray-900"
                >
                  {{ row[column] }}
                </td>
              </tr>
            </tbody>
          </table>
        </div>

        <!-- Chart View -->
        <div v-if="format !== 'table'" class="p-4">
          <div class="h-96">
            <!-- Chart component will be placed here -->
            <div class="w-full h-full flex items-center justify-center text-gray-500">
              Chart Placeholder
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'

// State
const selectedReport = ref(null)
const startDate = ref('')
const endDate = ref('')
const groupBy = ref('month')
const format = ref('both')
const exportFormat = ref('pdf')
const selectedFilters = ref([])
const reportData = ref(null)

// Mock data
const reportTypes = [
  {
    id: 'user-activity',
    name: 'User Activity',
    description: 'Track user engagement and activity patterns',
    icon: 'fas fa-users',
    iconColor: 'text-blue-600',
    iconBg: 'bg-blue-100'
  },
  {
    id: 'revenue',
    name: 'Revenue Analysis',
    description: 'Analyze revenue streams and trends',
    icon: 'fas fa-chart-line',
    iconColor: 'text-green-600',
    iconBg: 'bg-green-100'
  },
  {
    id: 'job-metrics',
    name: 'Job Metrics',
    description: 'Monitor job posting performance',
    icon: 'fas fa-briefcase',
    iconColor: 'text-purple-600',
    iconBg: 'bg-purple-100'
  }
]

const reportFilters = [
  { id: 'include-inactive', name: 'Include Inactive Users' },
  { id: 'include-canceled', name: 'Include Canceled Subscriptions' },
  { id: 'detailed-breakdown', name: 'Show Detailed Breakdown' }
]

const reportColumns = computed(() => {
  switch (selectedReport.value) {
    case 'user-activity':
      return ['Date', 'Active Users', 'New Users', 'Returning Users', 'Avg. Session Duration']
    case 'revenue':
      return ['Date', 'Total Revenue', 'New Subscriptions', 'Renewals', 'Cancellations']
    case 'job-metrics':
      return ['Date', 'Posted Jobs', 'Active Jobs', 'Applications', 'Conversion Rate']
    default:
      return []
  }
})

// Methods
const selectReport = (reportId) => {
  selectedReport.value = reportId
  reportData.value = null // Reset report data when switching reports
}

const generateReport = async () => {
  try {
    // Simulate API call
    const mockData = Array.from({ length: 5 }, (_, i) => {
      const date = new Date()
      date.setDate(date.getDate() - i)
      
      switch (selectedReport.value) {
        case 'user-activity':
          return {
            Date: date.toLocaleDateString(),
            'Active Users': Math.floor(Math.random() * 1000),
            'New Users': Math.floor(Math.random() * 100),
            'Returning Users': Math.floor(Math.random() * 900),
            'Avg. Session Duration': `${Math.floor(Math.random() * 30)} min`
          }
        case 'revenue':
          return {
            Date: date.toLocaleDateString(),
            'Total Revenue': `$${Math.floor(Math.random() * 10000)}`,
            'New Subscriptions': Math.floor(Math.random() * 50),
            'Renewals': Math.floor(Math.random() * 200),
            'Cancellations': Math.floor(Math.random() * 10)
          }
        case 'job-metrics':
          return {
            Date: date.toLocaleDateString(),
            'Posted Jobs': Math.floor(Math.random() * 50),
            'Active Jobs': Math.floor(Math.random() * 200),
            'Applications': Math.floor(Math.random() * 500),
            'Conversion Rate': `${Math.floor(Math.random() * 100)}%`
          }
      }
    })

    reportData.value = mockData
  } catch (error) {
    console.error('Error generating report:', error)
  }
}

const downloadReport = () => {
  // Implement report download functionality
  console.log('Downloading report:', {
    type: selectedReport.value,
    format: exportFormat.value,
    filters: selectedFilters.value
  })
}
</script>
