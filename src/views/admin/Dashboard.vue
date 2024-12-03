<template>
  <div class="min-h-screen bg-gray-50 py-8">
    <!-- Quick Actions Bar -->
    <div class="mb-8">
      <div class="flex flex-wrap gap-4">
        <button @click="openVerificationModal" class="flex items-center px-4 py-2 bg-purple-600 text-white rounded-lg hover:bg-purple-700 transition-colors">
          <i class="fas fa-check-circle mr-2"></i>
          Review Verifications
        </button>
        <button @click="openAnnouncementModal" class="flex items-center px-4 py-2 bg-purple-600 text-white rounded-lg hover:bg-purple-700 transition-colors">
          <i class="fas fa-bullhorn mr-2"></i>
          Send Announcement
        </button>
        <button @click="openJobModal" class="flex items-center px-4 py-2 bg-purple-600 text-white rounded-lg hover:bg-purple-700 transition-colors">
          <i class="fas fa-plus-circle mr-2"></i>
          Add Job
        </button>
        <button @click="openReportModal" class="flex items-center px-4 py-2 bg-purple-600 text-white rounded-lg hover:bg-purple-700 transition-colors">
          <i class="fas fa-flag mr-2"></i>
          Review Reports
        </button>
      </div>
    </div>

    <!-- Critical Metrics Cards -->
    <draggable 
      v-model="metricsCards" 
      class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-6"
      item-key="id"
      :animation="200"
      ghost-class="opacity-50"
    >
      <template #item="{ element }">
        <div class="bg-white rounded-lg shadow p-6 cursor-move">
          <div class="flex items-center gap-2 mb-4">
            <h3 class="text-xl font-semibold text-gray-800">{{ element.title }}</h3>
            <InfoTooltip :text="element.tooltip" />
          </div>
          <div class="flex items-center gap-2">
            <div class="text-3xl font-bold text-purple-600">{{ element.value }}</div>
            <div :class="element.changeType === 'positive' ? 'text-green-500' : 'text-red-500'" class="text-sm">
              {{ element.change }}
            </div>
          </div>
        </div>
      </template>
    </draggable>

    <!-- Attention Required Section -->
    <div class="mb-8">
      <h2 class="text-2xl font-semibold text-gray-800 mb-6">Attention Required</h2>
      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        <!-- Verifications Expiring -->
        <div class="bg-white rounded-lg shadow p-6 flex flex-col">
          <div>
            <h3 class="text-xl font-semibold text-gray-800 mb-3">Verifications Expiring</h3>
            <p class="text-gray-600">15 pastoral recommendations need review within 48 hours</p>
          </div>
          <div class="mt-auto pt-4">
            <a href="#" class="text-purple-600 font-medium hover:text-purple-700">Take Action →</a>
          </div>
        </div>

        <!-- Content Reports -->
        <div class="bg-white rounded-lg shadow p-6 flex flex-col">
          <div>
            <h3 class="text-xl font-semibold text-gray-800 mb-3">Content Reports</h3>
            <p class="text-gray-600">3 new user reports need review</p>
          </div>
          <div class="mt-auto pt-4">
            <a href="#" class="text-purple-600 font-medium hover:text-purple-700">Take Action →</a>
          </div>
        </div>

        <!-- System Performance -->
        <div class="bg-white rounded-lg shadow p-6 flex flex-col">
          <div>
            <h3 class="text-xl font-semibold text-gray-800 mb-3">System Performance</h3>
            <p class="text-gray-600">API response time above threshold in US-West region</p>
          </div>
          <div class="mt-auto pt-4">
            <a href="#" class="text-purple-600 font-medium hover:text-purple-700">Take Action →</a>
          </div>
        </div>

        <!-- Expiring Job Posts -->
        <div class="bg-white rounded-lg shadow p-6 flex flex-col">
          <div>
            <h3 class="text-xl font-semibold text-gray-800 mb-3">Expiring Job Posts</h3>
            <p class="text-gray-600">8 job postings expire in the next 48 hours</p>
          </div>
          <div class="mt-auto pt-4">
            <a href="#" class="text-purple-600 font-medium hover:text-purple-700">Take Action →</a>
          </div>
        </div>
      </div>
    </div>

    <!-- Growth Trends and Geographic Distribution -->
    <draggable 
      v-model="mainSections" 
      class="grid grid-cols-1 lg:grid-cols-2 gap-6 mb-8"
      item-key="id"
      :animation="200"
      ghost-class="opacity-50"
      handle=".drag-handle"
    >
      <template #item="{ element }">
        <div :class="{ 'lg:col-span-2': element.type === 'activity' }" 
             class="bg-white rounded-xl shadow-sm p-6 border border-gray-100 cursor-move">
          <div class="flex items-center justify-between mb-6">
            <h2 class="text-2xl font-semibold text-gray-800">
              {{ element.type === 'activity' ? 'Recent Activity' : 
                 element.type === 'verification' ? 'Verification Metrics' : 'Recent Placements' }}
            </h2>
            <span class="drag-handle cursor-move text-gray-400 hover:text-gray-600">⋮</span>
          </div>
          <!-- Recent Activity -->
          <div v-if="element.type === 'activity'">
            <div class="space-y-4">
              <div class="p-3 bg-purple-50 rounded-lg border border-purple-100">
                <div class="flex items-center gap-3">
                  <div class="w-2 h-2 rounded-full bg-purple-500"></div>
                  <div>
                    <p class="text-gray-800 font-medium">New pastoral position</p>
                    <p class="text-sm text-gray-500">10 minutes ago</p>
                  </div>
                </div>
              </div>

              <div class="p-3 bg-blue-50 rounded-lg border border-blue-100">
                <div class="flex items-center gap-3">
                  <div class="w-2 h-2 rounded-full bg-blue-500"></div>
                  <div>
                    <p class="text-gray-800 font-medium">New Member Verification</p>
                    <p class="text-sm text-gray-500">1 hour ago</p>
                  </div>
                </div>
              </div>

              <div class="p-3 bg-green-50 rounded-lg border border-green-100">
                <div class="flex items-center gap-3">
                  <div class="w-2 h-2 rounded-full bg-green-500"></div>
                  <div>
                    <p class="text-gray-800 font-medium">First Assignment Complete</p>
                    <p class="text-sm text-gray-500">2 hours ago</p>
                  </div>
                </div>
              </div>

              <div class="p-3 bg-yellow-50 rounded-lg border border-yellow-100">
                <div class="flex items-center gap-3">
                  <div class="w-2 h-2 rounded-full bg-yellow-500"></div>
                  <div>
                    <p class="text-gray-800 font-medium">New complaint filed</p>
                    <p class="text-sm text-gray-500">3 hours ago</p>
                  </div>
                </div>
              </div>

              <div class="p-3 bg-blue-50 rounded-lg border border-blue-100">
                <div class="flex items-center gap-3">
                  <div class="w-2 h-2 rounded-full bg-blue-500"></div>
                  <div>
                    <p class="text-gray-800 font-medium">Sound Board Verification</p>
                    <p class="text-sm text-gray-500">4 hours ago</p>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- Verification Metrics -->
          <div v-if="element.type === 'verification'">
            <div class="space-y-6">
              <div>
                <div class="flex justify-between mb-2">
                  <span class="text-gray-700">Time to Fill</span>
                  <span class="text-purple-600 font-medium">85%</span>
                </div>
                <div class="w-full bg-gray-200 rounded-full h-2.5">
                  <div class="bg-purple-600 h-2.5 rounded-full" style="width: 85%"></div>
                </div>
              </div>

              <div>
                <div class="flex justify-between mb-2">
                  <span class="text-gray-700">Application Rate</span>
                  <span class="text-blue-600 font-medium">72%</span>
                </div>
                <div class="w-full bg-gray-200 rounded-full h-2.5">
                  <div class="bg-blue-600 h-2.5 rounded-full" style="width: 72%"></div>
                </div>
              </div>

              <div>
                <div class="flex justify-between mb-2">
                  <span class="text-gray-700">Posting Trend</span>
                  <span class="text-green-600 font-medium">93%</span>
                </div>
                <div class="w-full bg-gray-200 rounded-full h-2.5">
                  <div class="bg-green-600 h-2.5 rounded-full" style="width: 93%"></div>
                </div>
              </div>

              <div>
                <div class="flex justify-between mb-2">
                  <span class="text-gray-700">Placement Rate</span>
                  <span class="text-yellow-600 font-medium">68%</span>
                </div>
                <div class="w-full bg-gray-200 rounded-full h-2.5">
                  <div class="bg-yellow-600 h-2.5 rounded-full" style="width: 68%"></div>
                </div>
              </div>
            </div>
          </div>

          <!-- Recent Placements -->
          <div v-if="element.type === 'placements'">
            <div class="space-y-4">
              <div class="flex items-center gap-4">
                <img src="https://randomuser.me/api/portraits/men/1.jpg" alt="John Doe" class="w-12 h-12 rounded-full object-cover">
                <div>
                  <div class="flex items-center gap-2">
                    <span class="font-medium">John Doe</span>
                    <span class="text-gray-400">→</span>
                    <span>First Assembly</span>
                  </div>
                  <div class="text-gray-500">
                    <span>Worship Leader</span>
                    <span class="mx-2">•</span>
                    <span>14 days</span>
                  </div>
                </div>
              </div>

              <div class="flex items-center gap-4">
                <img src="https://randomuser.me/api/portraits/women/1.jpg" alt="Sarah Smith" class="w-12 h-12 rounded-full object-cover">
                <div>
                  <div class="flex items-center gap-2">
                    <span class="font-medium">Sarah Smith</span>
                    <span class="text-gray-400">→</span>
                    <span>Grace Church</span>
                  </div>
                  <div class="text-gray-500">
                    <span>Media Director</span>
                    <span class="mx-2">•</span>
                    <span>21 days</span>
                  </div>
                </div>
              </div>

              <div class="flex items-center gap-4">
                <img src="https://randomuser.me/api/portraits/men/2.jpg" alt="Mike Johnson" class="w-12 h-12 rounded-full object-cover">
                <div>
                  <div class="flex items-center gap-2">
                    <span class="font-medium">Mike Johnson</span>
                    <span class="text-gray-400">→</span>
                    <span>Life Church</span>
                  </div>
                  <div class="text-gray-500">
                    <span>Sound Engineer</span>
                    <span class="mx-2">•</span>
                    <span>10 days</span>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </template>
    </draggable>

    <!-- Activity Feed and Job Market Health -->
    <div class="grid grid-cols-1 lg:grid-cols-3 gap-6 mb-8">
      <!-- Activity Feed -->
      <div class="lg:col-span-2 bg-white rounded-xl shadow-sm p-6 border border-gray-100">
        <h2 class="text-2xl font-semibold text-gray-800 mb-6">Recent Activity</h2>
        <div class="space-y-4">
          <div class="p-3 bg-purple-50 rounded-lg border border-purple-100">
            <div class="flex items-center gap-3">
              <div class="w-2 h-2 rounded-full bg-purple-500"></div>
              <div>
                <p class="text-gray-800 font-medium">New pastoral position</p>
                <p class="text-sm text-gray-500">10 minutes ago</p>
              </div>
            </div>
          </div>

          <div class="p-3 bg-blue-50 rounded-lg border border-blue-100">
            <div class="flex items-center gap-3">
              <div class="w-2 h-2 rounded-full bg-blue-500"></div>
              <div>
                <p class="text-gray-800 font-medium">New Member Verification</p>
                <p class="text-sm text-gray-500">1 hour ago</p>
              </div>
            </div>
          </div>

          <div class="p-3 bg-green-50 rounded-lg border border-green-100">
            <div class="flex items-center gap-3">
              <div class="w-2 h-2 rounded-full bg-green-500"></div>
              <div>
                <p class="text-gray-800 font-medium">First Assignment Complete</p>
                <p class="text-sm text-gray-500">2 hours ago</p>
              </div>
            </div>
          </div>

          <div class="p-3 bg-yellow-50 rounded-lg border border-yellow-100">
            <div class="flex items-center gap-3">
              <div class="w-2 h-2 rounded-full bg-yellow-500"></div>
              <div>
                <p class="text-gray-800 font-medium">New complaint filed</p>
                <p class="text-sm text-gray-500">3 hours ago</p>
              </div>
            </div>
          </div>

          <div class="p-3 bg-blue-50 rounded-lg border border-blue-100">
            <div class="flex items-center gap-3">
              <div class="w-2 h-2 rounded-full bg-blue-500"></div>
              <div>
                <p class="text-gray-800 font-medium">Sound Board Verification</p>
                <p class="text-sm text-gray-500">4 hours ago</p>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Job Market Health -->
      <div class="bg-white rounded-lg shadow p-6">
        <div class="flex items-center gap-2 mb-6">
          <h2 class="text-2xl font-semibold text-gray-800">Job Market Health</h2>
          <InfoTooltip text="Key metrics indicating the health of the job market" />
        </div>
        
        <div class="space-y-6">
          <!-- Time to Fill -->
          <div>
            <div class="flex justify-between mb-2">
              <span class="text-gray-700">Time to Fill</span>
              <span class="text-purple-600 font-medium">85%</span>
            </div>
            <div class="w-full bg-gray-200 rounded-full h-2.5">
              <div class="bg-purple-600 h-2.5 rounded-full" style="width: 85%"></div>
            </div>
          </div>

          <!-- Application Rate -->
          <div>
            <div class="flex justify-between mb-2">
              <span class="text-gray-700">Application Rate</span>
              <span class="text-blue-600 font-medium">72%</span>
            </div>
            <div class="w-full bg-gray-200 rounded-full h-2.5">
              <div class="bg-blue-600 h-2.5 rounded-full" style="width: 72%"></div>
            </div>
          </div>

          <!-- Posting Trend -->
          <div>
            <div class="flex justify-between mb-2">
              <span class="text-gray-700">Posting Trend</span>
              <span class="text-green-600 font-medium">93%</span>
            </div>
            <div class="w-full bg-gray-200 rounded-full h-2.5">
              <div class="bg-green-600 h-2.5 rounded-full" style="width: 93%"></div>
            </div>
          </div>

          <!-- Placement Rate -->
          <div>
            <div class="flex justify-between mb-2">
              <span class="text-gray-700">Placement Rate</span>
              <span class="text-yellow-600 font-medium">68%</span>
            </div>
            <div class="w-full bg-gray-200 rounded-full h-2.5">
              <div class="bg-yellow-600 h-2.5 rounded-full" style="width: 68%"></div>
            </div>
          </div>
        </div>

        <div class="mt-6 text-right">
          <a href="#" class="text-purple-600 hover:text-purple-700 text-sm font-medium">View Details →</a>
        </div>
      </div>
    </div>

    <!-- Verification Metrics and Recent Placements -->
    <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
      <!-- Verification Metrics -->
      <div class="bg-white rounded-lg shadow p-6">
        <div class="flex items-center gap-2 mb-6">
          <h2 class="text-2xl font-semibold text-gray-800">Verification Metrics</h2>
        </div>
        
        <div class="grid grid-cols-2 gap-6">
          <div>
            <div class="flex items-center gap-2">
              <span class="text-gray-600">Pending</span>
              <InfoTooltip text="Number of verification requests awaiting review" />
            </div>
            <div class="mt-2">
              <span class="text-3xl font-semibold">45</span>
              <span class="text-green-500 ml-2">↑ 5%</span>
            </div>
          </div>

          <div>
            <div class="flex items-center gap-2">
              <span class="text-gray-600">Avg Process Time</span>
              <InfoTooltip text="Average time to complete verification" />
            </div>
            <div class="mt-2">
              <span class="text-3xl font-semibold">2.3</span>
              <span class="text-sm ml-1">days</span>
              <span class="text-red-500 ml-2">↓ 12%</span>
            </div>
          </div>

          <div>
            <div class="flex items-center gap-2">
              <span class="text-gray-600">Success Rate</span>
              <InfoTooltip text="Percentage of verifications resulting in successful placements" />
            </div>
            <div class="mt-2">
              <span class="text-3xl font-semibold">92%</span>
              <span class="text-green-500 ml-2">↑ 3%</span>
            </div>
          </div>

          <div>
            <div class="flex items-center gap-2">
              <span class="text-gray-600">Expiring Soon</span>
              <InfoTooltip text="Verifications expiring in the next 48 hours" />
            </div>
            <div class="mt-2">
              <span class="text-3xl font-semibold">15</span>
              <span class="text-green-500 ml-2">↑ 8%</span>
            </div>
          </div>
        </div>
      </div>

      <!-- Recent Placements -->
      <div class="bg-white rounded-lg shadow p-6">
        <h2 class="text-2xl font-semibold text-gray-800 mb-6">Recent Placements</h2>
        
        <div class="space-y-4">
          <div class="flex items-center gap-4">
            <img src="https://randomuser.me/api/portraits/men/1.jpg" alt="John Doe" class="w-12 h-12 rounded-full object-cover">
            <div>
              <div class="flex items-center gap-2">
                <span class="font-medium">John Doe</span>
                <span class="text-gray-400">→</span>
                <span>First Assembly</span>
              </div>
              <div class="text-gray-500">
                <span>Worship Leader</span>
                <span class="mx-2">•</span>
                <span>14 days</span>
              </div>
            </div>
          </div>

          <div class="flex items-center gap-4">
            <img src="https://randomuser.me/api/portraits/women/1.jpg" alt="Sarah Smith" class="w-12 h-12 rounded-full object-cover">
            <div>
              <div class="flex items-center gap-2">
                <span class="font-medium">Sarah Smith</span>
                <span class="text-gray-400">→</span>
                <span>Grace Church</span>
              </div>
              <div class="text-gray-500">
                <span>Media Director</span>
                <span class="mx-2">•</span>
                <span>21 days</span>
              </div>
            </div>
          </div>

          <div class="flex items-center gap-4">
            <img src="https://randomuser.me/api/portraits/men/2.jpg" alt="Mike Johnson" class="w-12 h-12 rounded-full object-cover">
            <div>
              <div class="flex items-center gap-2">
                <span class="font-medium">Mike Johnson</span>
                <span class="text-gray-400">→</span>
                <span>Life Church</span>
              </div>
              <div class="text-gray-500">
                <span>Sound Engineer</span>
                <span class="mx-2">•</span>
                <span>10 days</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'
import InfoTooltip from '@/components/InfoTooltip.vue'
import LineChart from '@/components/LineChart.vue'
import DistributionMap from '@/components/DistributionMap.vue'
import draggable from 'vuedraggable'

// State variables for all sections
const creativesRatio = ref(2.5)  // Ratio of creatives to churches (e.g., 2.5:1)
const ratioTrend = ref(5)        // Percentage change in ratio (e.g., +5%)
const activeJobs = ref(124)      // Total number of active job postings
const newJobsToday = ref(12)     // New job postings today
const pendingVerifications = ref(45)  // Total pending pastoral verifications
const urgentVerifications = ref(8)    // Verifications needing immediate attention

// Attention alerts for urgent matters
const attentionAlerts = ref([
  {
    id: 1,
    type: 'verification',
    priority: 'high',
    title: '15 Verifications Expiring',
    message: 'Pastoral recommendations need review within 48 hours'
  },
  {
    id: 2,
    type: 'report',
    priority: 'medium',
    title: 'Content Reports',
    message: '3 new user reports need review'
  },
  {
    id: 3,
    type: 'system',
    priority: 'low',
    title: 'System Performance',
    message: 'API response time above threshold in US-West region'
  },
  {
    id: 4,
    type: 'job',
    priority: 'medium',
    title: 'Expiring Job Posts',
    message: '8 job postings expire in the next 48 hours'
  }
])

// Job market health metrics
const jobMarketMetrics = ref([
  {
    label: 'Time to Fill',
    value: '18 days',
    percentage: 75,
    description: 'Average time taken to fill an open position from posting to placement'
  },
  {
    label: 'Application Rate',
    value: '4.2 per job',
    percentage: 85,
    description: 'Average number of applications received per job posting'
  },
  {
    label: 'Posting Trend',
    value: '+15%',
    percentage: 65,
    description: 'Month-over-month change in new job postings'
  },
  {
    label: 'Placement Rate',
    value: '68%',
    percentage: 68,
    description: 'Percentage of job postings that result in successful placements'
  }
])

// Verification process metrics
const verificationMetrics = ref([
  {
    label: 'Pending',
    value: '45',
    trend: 5,  // Percentage change
    description: 'Total number of verifications currently pending review'
  },
  {
    label: 'Avg Process Time',
    value: '2.3 days',
    trend: -12,
    description: 'Average time to complete a verification'
  },
  {
    label: 'Success Rate',
    value: '92%',
    trend: 3,
    description: 'Percentage of verifications resulting in successful placements'
  },
  {
    label: 'Expiring Soon',
    value: '15',
    trend: 8,
    description: 'Number of verifications expiring in the next 48 hours'
  }
])

// Recent successful placements
const recentPlacements = ref([
  {
    id: 1,
    creative: 'John Doe',
    church: 'First Assembly',
    position: 'Worship Leader',
    timeToFill: '14 days',
    churchLogo: '/path/to/logo'
  },
  {
    id: 2,
    creative: 'Sarah Smith',
    church: 'Grace Church',
    position: 'Media Director',
    timeToFill: '21 days',
    churchLogo: '/path/to/logo'
  },
  {
    id: 3,
    creative: 'Mike Johnson',
    church: 'Life Church',
    position: 'Sound Engineer',
    timeToFill: '10 days',
    churchLogo: '/path/to/logo'
  }
])

// Recent platform activity
const recentActivities = ref([
  {
    id: 1,
    type: 'job',
    title: 'New pastoral position',
    time: '10 minutes ago'
  },
  {
    id: 2,
    type: 'verification',
    title: 'New Member Verification',
    time: '1 hour ago'
  },
  {
    id: 3,
    type: 'placement',
    title: 'First Assignment Complete',
    time: '2 hours ago'
  },
  {
    id: 4,
    type: 'report',
    title: 'New complaint filed',
    time: '3 hours ago'
  },
  {
    id: 5,
    type: 'verification',
    title: 'Sound Board Verification',
    time: '4 hours ago'
  }
])

// Growth trends data for the multi-line chart
const growthTrendsData = ref({
  labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
  datasets: [
    {
      label: 'Creative Signups',
      data: [30, 45, 55, 65, 85, 95],
      borderColor: '#8B5CF6',
      backgroundColor: 'rgba(139, 92, 246, 0.1)',
      tension: 0.4
    },
    {
      label: 'Church Signups',
      data: [20, 25, 30, 35, 40, 45],
      borderColor: '#2563EB',
      backgroundColor: 'rgba(37, 99, 235, 0.1)',
      tension: 0.4
    },
    {
      label: 'Job Postings',
      data: [15, 25, 35, 40, 50, 55],
      borderColor: '#059669',
      backgroundColor: 'rgba(5, 150, 105, 0.1)',
      tension: 0.4
    },
    {
      label: 'Placements',
      data: [10, 15, 20, 25, 35, 40],
      borderColor: '#DC2626',
      backgroundColor: 'rgba(220, 38, 38, 0.1)',
      tension: 0.4
    }
  ]
})

// Geographic distribution data
const geographicData = ref({
  churches: 125,  // Total number of church partners
  creatives: 320  // Total number of registered creatives
})

// Church metrics with active jobs
const churchMetrics = ref({
  activeChurches: 85,         // Churches with active job posts
  totalJobs: 153,             // Total jobs in system
  activeJobs: 50,            // Currently active job posts
  jobsPerChurch: computed(() => (churchMetrics.value.totalJobs / churchMetrics.value.activeChurches).toFixed(1))
})

// Creative employment metrics with unemployment rate
const creativeEmployment = ref({
  placed: 160,               // Creatives in roles
  total: 320,               // Total creatives
  unemploymentRate: computed(() => {
    return Math.round((1 - creativeEmployment.value.placed / creativeEmployment.value.total) * 100)
  })
})

// Job metrics with fill rate
const jobMetrics = ref({
  filled: 103,              // Filled positions
  open: 50,                // Open positions
  total: computed(() => jobMetrics.value.filled + jobMetrics.value.open),
  fillRate: computed(() => Math.round((jobMetrics.value.filled / 
    (jobMetrics.value.filled + jobMetrics.value.open)) * 100)),
  placementRate: computed(() => Math.round((jobMetrics.value.filled / 
    (jobMetrics.value.filled + jobMetrics.value.open)) * 100))
})

// Market health computation
const marketHealth = computed(() => {
  const availableCreatives = creativeEmployment.value.total - creativeEmployment.value.placed
  const openJobs = jobMetrics.value.open
  const ratio = availableCreatives / openJobs

  return {
    isBalanced: ratio >= 0.8 && ratio <= 1.2,
    supplyDemandRatio: ratio.toFixed(1),
    availableCreatives,
    openJobs,
    supplyPercentage: Math.round((availableCreatives / (availableCreatives + openJobs)) * 100),
    demandPercentage: Math.round((openJobs / (availableCreatives + openJobs)) * 100)
  }
})

// Tooltip text definitions
const tooltips = ref({
  marketBalance: "This ratio helps assess if we have enough creatives to meet church demands. A ratio close to 1:1 indicates a healthy balance.",
  churchActivity: "Shows how actively churches are engaging with the platform. Higher numbers indicate more church participation.",
  creativeStatus: "Shows the percentage of creatives currently not in roles. Lower rates indicate better job placement success.",
  jobFillRate: "Represents the percentage of total positions successfully filled. Higher rates indicate effective matching.",
  growthTrends: "Visualizes the growth of creatives, churches, and job placements over time.",
  geographicDist: "Shows the distribution of churches and creatives across different regions.",
  recentActivity: "Latest updates including new job postings, verifications, and important changes.",
  marketHealth: "Overall health metrics for the creative marketplace including supply/demand balance."
})

// Define reactive arrays for each section
const metricsCards = ref([
  { id: 'market-balance', title: 'Market Balance', value: '3.2:1', change: '-5%', changeType: 'negative', tooltip: 'This ratio helps assess if we have enough creatives to meet church demands. A ratio close to 1:1 indicates a healthy balance.' },
  { id: 'church-activity', title: 'Church Activity', value: '1.8', change: '+12%', changeType: 'positive', tooltip: 'Shows how actively churches are engaging with the platform. Higher numbers indicate more church participation.' },
  { id: 'active-jobs', title: 'Active Job Postings', value: '124', change: '+12 today', changeType: 'positive', tooltip: 'Total number of active job postings' },
  { id: 'pending-verifications', title: 'Pending Verifications', value: '45', change: '8 urgent', changeType: 'negative', tooltip: 'Total number of verifications currently pending review' },
  { id: 'creative-status', title: 'Creative Status', value: '50%', change: '-5%', changeType: 'negative', tooltip: 'Shows the percentage of creatives currently not in roles. Lower rates indicate better job placement success.' },
  { id: 'job-fill-rate', title: 'Job Fill Rate', value: '67%', change: '+3%', changeType: 'positive', tooltip: 'Represents the percentage of total positions successfully filled. Higher rates indicate effective matching.' },
  { id: 'placement-rate', title: 'Placement Rate', value: '67%', change: '+5%', changeType: 'positive', tooltip: 'Percentage of job postings that result in successful placements' }
])

const mainSections = ref([
  { id: 'recent-activity', type: 'activity' },
  { id: 'verification-metrics', type: 'verification' },
  { id: 'recent-placements', type: 'placements' }
])

// Functions
function getAlertClass(priority) {
  return {
    high: 'bg-red-50 border-red-100',
    medium: 'bg-yellow-50 border-yellow-100',
    low: 'bg-blue-50 border-blue-100'
  }[priority]
}

function getAlertIcon(type) {
  return {
    verification: 'fas fa-user-check text-red-500',
    report: 'fas fa-flag text-yellow-500',
    system: 'fas fa-server text-blue-500'
  }[type]
}

function getActivityIconClass(type) {
  return {
    verification: 'bg-purple-100 text-purple-600',
    job: 'bg-blue-100 text-blue-600',
    report: 'bg-yellow-100 text-yellow-600'
  }[type]
}

function getActivityIcon(type) {
  return {
    verification: 'fas fa-check-circle',
    job: 'fas fa-briefcase',
    report: 'fas fa-flag'
  }[type]
}

// Modal handlers
function openVerificationModal() {
  // Implementation
}

function openAnnouncementModal() {
  // Implementation
}

function openJobModal() {
  // Implementation
}

function openReportModal() {
  // Implementation
}

// Fetch data on mount
// onMounted(() => {
//   // Fetch dashboard data
// })
</script>

<style scoped>
.drag-handle {
  cursor: move;
  user-select: none;
}
.opacity-50 {
  opacity: 0.5;
}
</style>