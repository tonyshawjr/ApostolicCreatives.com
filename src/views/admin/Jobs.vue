<template>
  <div class="min-h-screen bg-gray-50 py-8">
    <!-- Header -->
    <div class="mb-6">
      <div class="flex flex-wrap items-center justify-between gap-4">
        <h1 class="text-2xl font-semibold text-gray-900">Job Board Management</h1>
        
        <div class="flex items-center gap-3">
          <button
            @click="showMetrics = !showMetrics"
            class="inline-flex items-center px-4 py-2 border border-gray-300 rounded-lg shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-purple-500"
          >
            Show Metrics
          </button>

          <!-- Bulk actions button -->
          <button
            v-if="selectedJobs.length > 0"
            @click="showBulkActions = !showBulkActions"
            class="inline-flex items-center px-4 py-2 border border-transparent rounded-lg shadow-sm text-sm font-medium text-white bg-purple-600 hover:bg-purple-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-purple-500"
          >
            Bulk Actions ({{ selectedJobs.length }})
            <svg class="ml-2 -mr-0.5 h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
              <path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd" />
            </svg>
          </button>

          <button
            @click="openCreateJobPanel"
            class="inline-flex items-center px-4 py-2 border border-transparent rounded-lg shadow-sm text-sm font-medium text-white bg-green-600 hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-green-500"
          >
            Create New Job
          </button>
        </div>
      </div>

      <!-- Bulk Action Buttons -->
      <div v-if="showBulkActions && selectedJobs.length > 0" 
        class="flex flex-wrap gap-3 p-4 mt-4 bg-white rounded-lg shadow"
      >
        <button
          @click="bulkApprove"
          class="inline-flex items-center px-4 py-2 text-sm font-medium text-white bg-purple-700 rounded-lg hover:bg-purple-800 focus:ring-4 focus:outline-none focus:ring-purple-300"
        >
          Approve Selected
        </button>
        <button
          @click="bulkExtend"
          class="inline-flex items-center px-4 py-2 text-sm font-medium text-gray-900 bg-white border border-gray-300 rounded-lg hover:bg-gray-100 focus:ring-4 focus:outline-none focus:ring-gray-200"
        >
          Extend Expiry
        </button>
        <button
          @click="bulkExport"
          class="inline-flex items-center px-4 py-2 text-sm font-medium text-gray-900 bg-white border border-gray-300 rounded-lg hover:bg-gray-100 focus:ring-4 focus:outline-none focus:ring-gray-200"
        >
          Export Data
        </button>
        <button
          @click="bulkDelete"
          class="inline-flex items-center px-4 py-2 text-sm font-medium text-white bg-red-600 rounded-lg hover:bg-red-700 focus:ring-4 focus:outline-none focus:ring-red-300"
        >
          Delete Selected
        </button>
      </div>
    </div>

    <!-- Search and Filters -->
    <div class="mb-8">
      <!-- Search bar -->
      <div class="mb-4">
        <input
          type="text"
          v-model="searchQuery"
          placeholder="Search jobs by title, church, or location..."
          class="block w-full px-4 py-3.5 text-base text-gray-900 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-purple-500"
        >
      </div>

      <!-- Filters - horizontal on all screen sizes -->
      <div class="flex flex-wrap gap-3">
        <select
          v-model="statusFilter"
          class="flex-1 min-w-[120px] px-4 py-2 text-base text-gray-900 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-purple-500"
        >
          <option value="">All Status</option>
          <option value="pending">Pending</option>
          <option value="active">Active</option>
          <option value="filled">Filled</option>
          <option value="paused">Paused</option>
          <option value="closed">Closed</option>
        </select>

        <select
          v-model="typeFilter"
          class="flex-1 min-w-[120px] px-4 py-2 text-base text-gray-900 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-purple-500"
        >
          <option value="">All Types</option>
          <option value="full-time">Full-time</option>
          <option value="part-time">Part-time</option>
          <option value="contract">Contract</option>
        </select>

        <select
          v-model="dateFilter"
          class="flex-1 min-w-[120px] px-4 py-2 text-base text-gray-900 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-purple-500"
        >
          <option value="">All Dates</option>
          <option value="today">Today</option>
          <option value="this-week">This Week</option>
          <option value="this-month">This Month</option>
        </select>
      </div>
    </div>

    <!-- Metrics Section -->
    <div v-if="showMetrics" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4 mb-6">
      <div v-for="metric in jobMetrics" :key="metric.label" 
        class="bg-white p-4 rounded-lg shadow hover:shadow-md transition-shadow"
      >
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

    <!-- Jobs Table -->
    <div class="overflow-x-auto bg-white rounded-lg shadow">
      <div class="min-w-full inline-block align-middle">
        <table class="min-w-full divide-y divide-gray-200">
          <thead class="bg-gray-50">
            <tr>
              <th class="w-8 px-3 py-3">
                <input
                  type="checkbox"
                  v-model="selectAll"
                  class="rounded border-gray-300 text-purple-600 focus:ring-purple-500"
                />
              </th>
              <th v-for="header in tableHeaders" :key="header" 
                class="px-3 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider whitespace-nowrap"
              >
                {{ header }}
              </th>
              <th class="relative px-3 py-3 w-[100px]">
                <span class="sr-only">Actions</span>
              </th>
            </tr>
          </thead>
          <tbody class="divide-y divide-gray-200">
            <tr v-for="job in paginatedJobs" :key="job.id" class="hover:bg-gray-50">
              <td class="px-3 py-4">
                <input
                  type="checkbox"
                  v-model="selectedJobs"
                  :value="job.id"
                  class="rounded border-gray-300 text-purple-600 focus:ring-purple-500"
                />
              </td>
              <td class="px-3 py-4 whitespace-nowrap">
                <div class="text-sm font-medium text-gray-900">{{ job.title }}</div>
                <div class="text-sm text-gray-500">ID: {{ job.id }}</div>
              </td>
              <td class="px-3 py-4 whitespace-nowrap">
                {{ job.church }}
              </td>
              <td class="px-3 py-4 whitespace-nowrap">
                {{ job.location }}
              </td>
              <td class="px-3 py-4 whitespace-nowrap">
                <span :class="getJobTypeClass(job.type)" class="px-2 py-1 text-xs rounded-full">
                  {{ job.type }}
                </span>
              </td>
              <td class="px-3 py-4 whitespace-nowrap">
                <span :class="getStatusClass(job.status)" class="px-2 py-1 text-xs rounded-full">
                  {{ job.status }}
                </span>
              </td>
              <td class="px-3 py-4 whitespace-nowrap">
                {{ formatDate(job.postedDate) }}
              </td>
              <td class="px-3 py-4 whitespace-nowrap">
                {{ formatDate(job.expiryDate) }}
              </td>
              <td class="px-3 py-4 whitespace-nowrap text-center">
                {{ job.applications }}
              </td>
              <td class="px-3 py-4 text-right text-sm font-medium whitespace-nowrap">
                <div class="relative inline-block text-left">
                  <button 
                    @click.stop="toggleActionMenu(job.id, $event)"
                    class="text-gray-400 hover:text-gray-600 actions-button"
                  >
                    <span class="sr-only">Open actions menu</span>
                    <svg class="h-5 w-5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                      <path d="M10 6a2 2 0 110-4 2 2 0 010 4zM10 12a2 2 0 110-4 2 2 0 010 4zM10 18a2 2 0 110-4 2 2 0 010 4z" />
                    </svg>
                  </button>

                  <Teleport to="body">
                    <!-- Dropdown menu -->
                    <div 
                      v-if="activeActionMenu === job.id"
                      :style="menuPosition"
                      class="fixed w-56 rounded-md shadow-lg bg-white ring-1 ring-black ring-opacity-5 divide-y divide-gray-100 focus:outline-none z-50 actions-menu"
                      @click.stop
                    >
                      <div class="py-1">
                        <button
                          @click="handleMenuAction('view', job)"
                          class="group flex items-center px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 hover:text-gray-900 w-full text-left"
                        >
                          <svg class="mr-3 h-5 w-5 text-gray-400 group-hover:text-gray-500" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                            <path d="M10 12a2 2 0 100-4 2 2 0 000 4z" />
                            <path fill-rule="evenodd" d="M.458 10C1.732 5.943 5.522 3 10 3s8.268 2.943 9.542 7c-1.274 4.057-5.064 7-9.542 7S1.732 14.057.458 10zM14 10a4 4 0 11-8 0 4 4 0 018 0z" clip-rule="evenodd" />
                          </svg>
                          View Details
                        </button>
                        <button
                          @click="handleMenuAction('edit', job)"
                          class="group flex items-center px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 hover:text-gray-900 w-full text-left"
                        >
                          <svg class="mr-3 h-5 w-5 text-gray-400 group-hover:text-gray-500" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                            <path d="M17.414 2.586a2 2 0 00-2.828 0L7 10.172V13h2.828l7.586-7.586a2 2 0 000-2.828z" />
                            <path fill-rule="evenodd" d="M2 6a2 2 0 012-2h4a1 1 0 010 2H4v10h10v-4a1 1 0 112 0v4a2 2 0 01-2 2H4a2 2 0 01-2-2V6z" clip-rule="evenodd" />
                          </svg>
                          Edit Job
                        </button>
                      </div>
                      <div class="py-1">
                        <button
                          @click="handleMenuAction('filled', job)"
                          class="group flex items-center px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 hover:text-gray-900 w-full text-left"
                        >
                          <svg class="mr-3 h-5 w-5 text-gray-400 group-hover:text-gray-500" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                            <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd" />
                          </svg>
                          Mark as Filled
                        </button>
                        <button
                          @click="handleMenuAction('toggle', job)"
                          class="group flex items-center px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 hover:text-gray-900 w-full text-left"
                        >
                          <svg class="mr-3 h-5 w-5 text-gray-400 group-hover:text-gray-500" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                            <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7 4a1 1 0 11-2 0 1 1 0 012 0V8a1 1 0 00-1-1v4a1 1 0 00-1 1z" clip-rule="evenodd" />
                          </svg>
                          {{ job.status === 'active' ? 'Pause Listing' : 'Unpause Listing' }}
                        </button>
                        <button
                          @click="handleMenuAction('close', job)"
                          class="group flex items-center px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 hover:text-gray-900 w-full text-left"
                        >
                          <svg class="mr-3 h-5 w-5 text-gray-400 group-hover:text-gray-500" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                            <path fill-rule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clip-rule="evenodd" />
                          </svg>
                          Close Position
                        </button>
                      </div>
                      <div class="py-1">
                        <button
                          @click="handleMenuAction('delete', job)"
                          class="group flex items-center px-4 py-2 text-sm text-red-700 hover:bg-red-100 hover:text-red-900 w-full text-left"
                        >
                          <svg class="mr-3 h-5 w-5 text-red-400 group-hover:text-red-500" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                            <path fill-rule="evenodd" d="M9 2a1 1 0 00-.894.553L7.382 4H4a1 1 0 000 2v10a2 2 0 002 2h8a2 2 0 002-2V6a1 1 0 100-2h-3.382l-.724-1.447A1 1 0 0011 2H9zM7 8a1 1 0 012 0v6a1 1 0 11-2 0V8zm5-1a1 1 0 00-1 1v6a1 1 0 102 0V8a1 1 0 00-1-1z" clip-rule="evenodd" />
                          </svg>
                          Delete Job
                        </button>
                      </div>
                    </div>
                  </Teleport>
                </div>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
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

    <!-- Job Details/Edit Slide-over -->
    <div v-if="activeJob" class="fixed inset-0 overflow-hidden z-50" aria-labelledby="slide-over-title" role="dialog" aria-modal="true">
      <div class="absolute inset-0 overflow-hidden">
        <!-- Background overlay -->
        <div class="absolute inset-0 bg-gray-500 bg-opacity-75 transition-opacity" aria-hidden="true" @click="closeJobPanel"></div>
        
        <div class="pointer-events-none fixed inset-y-0 right-0 flex max-w-full pl-10">
          <div class="pointer-events-auto relative w-screen max-w-2xl">
            <!-- Close button -->
            <div class="absolute top-0 left-0 -ml-8 flex pt-4 pr-2 sm:-ml-10 sm:pr-4">
              <button
                @click="closeJobPanel"
                class="rounded-md text-gray-300 hover:text-white focus:outline-none focus:ring-2 focus:ring-white"
              >
                <span class="sr-only">Close panel</span>
                <svg class="h-6 w-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                </svg>
              </button>
            </div>

            <!-- Panel content -->
            <div class="flex h-full flex-col bg-white shadow-xl">
              <div class="px-4 py-6 sm:px-6">
                <div class="flex items-start justify-between">
                  <h2 class="text-lg font-medium text-gray-900" id="slide-over-title">
                    {{ isEditing ? 'Edit Job' : (activeJob.id ? 'View Job' : 'Create New Job') }}
                  </h2>
                  <div class="ml-3 flex h-7 items-center">
                    <button
                      @click="closeJobPanel"
                      class="rounded-md bg-white text-gray-400 hover:text-gray-500 focus:outline-none focus:ring-2 focus:ring-purple-500"
                    >
                      <span class="sr-only">Close panel</span>
                      <svg class="h-6 w-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                      </svg>
                    </button>
                  </div>
                </div>
              </div>

              <div class="flex-1 overflow-y-auto">
                <div class="px-4 py-6 sm:px-6">
                  <!-- View Mode -->
                  <div v-if="!isEditing && activeJob.id" class="space-y-12">
                    <!-- Essential Job Details Section -->
                    <div>
                      <h3 class="text-xl font-bold text-gray-900 mb-6 border-b border-gray-300 pb-2">Essential Job Details</h3>
                      <div class="space-y-8">
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                          <div>
                            <dt class="text-base font-semibold text-gray-700">Job Title</dt>
                            <dd class="mt-1 text-base text-gray-900">{{ jobDetails.title }}</dd>
                          </div>
                          <div>
                            <dt class="text-base font-semibold text-gray-700">Church/Ministry Name</dt>
                            <dd class="mt-1 text-base text-gray-900">{{ jobDetails.church }}</dd>
                          </div>
                        </div>

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                          <div>
                            <dt class="text-base font-semibold text-gray-700">Location</dt>
                            <dd class="mt-1 text-base text-gray-900">{{ jobDetails.city }}, {{ jobDetails.state }}</dd>
                          </div>
                          <div>
                            <dt class="text-base font-semibold text-gray-700">Job Type</dt>
                            <dd class="mt-1 text-base text-gray-900">{{ jobDetails.type }}</dd>
                          </div>
                        </div>

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                          <div>
                            <dt class="text-base font-semibold text-gray-700">Job Category</dt>
                            <dd class="mt-1 text-base text-gray-900">{{ jobDetails.category }}</dd>
                          </div>
                          <div>
                            <dt class="text-base font-semibold text-gray-700">Expected Start Date</dt>
                            <dd class="mt-1 text-base text-gray-900">{{ jobDetails.startDate }}</dd>
                          </div>
                        </div>

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                          <div>
                            <dt class="text-base font-semibold text-gray-700">Application Deadline</dt>
                            <dd class="mt-1 text-base text-gray-900">{{ jobDetails.deadline }}</dd>
                          </div>
                          <div>
                            <dt class="text-base font-semibold text-gray-700">Salary Range</dt>
                            <dd class="mt-1 text-base text-gray-900">{{ jobDetails.salaryRange }}</dd>
                          </div>
                        </div>
                      </div>
                    </div>

                    <!-- Job Description Section -->
                    <div>
                      <h3 class="text-xl font-bold text-gray-900 mb-6 border-b border-gray-300 pb-2">Job Description</h3>
                      <div class="space-y-8">
                        <div>
                          <dt class="text-base font-semibold text-gray-700">About the Church/Ministry</dt>
                          <dd class="mt-1 text-base text-gray-900">{{ jobDetails.aboutChurch }}</dd>
                        </div>

                        <div>
                          <dt class="text-base font-semibold text-gray-700">Position Overview</dt>
                          <dd class="mt-1 text-base text-gray-900">{{ jobDetails.overview }}</dd>
                        </div>

                        <div>
                          <dt class="text-base font-semibold text-gray-700">Key Responsibilities</dt>
                          <dd class="mt-1 text-base text-gray-900">{{ jobDetails.responsibilities }}</dd>
                        </div>

                        <div>
                          <dt class="text-base font-semibold text-gray-700">Required Skills/Experience</dt>
                          <dd class="mt-1 text-base text-gray-900">{{ jobDetails.requiredSkills }}</dd>
                        </div>

                        <div>
                          <dt class="text-base font-semibold text-gray-700">Spiritual Requirements</dt>
                          <dd class="mt-1 text-base text-gray-900">{{ jobDetails.spiritualRequirements }}</dd>
                        </div>

                        <div>
                          <dt class="text-base font-semibold text-gray-700">Education Requirements</dt>
                          <dd class="mt-1 text-base text-gray-900">{{ jobDetails.educationRequirements }}</dd>
                        </div>

                        <div>
                          <dt class="text-base font-semibold text-gray-700">Additional Qualifications</dt>
                          <dd class="mt-1 text-base text-gray-900">{{ jobDetails.additionalQualifications }}</dd>
                        </div>
                      </div>
                    </div>

                    <!-- Contact/Application Info Section -->
                    <div>
                      <h3 class="text-xl font-bold text-gray-900 mb-6 border-b border-gray-300 pb-2">Contact & Application Information</h3>
                      <div class="space-y-8">
                        <div>
                          <dt class="text-base font-semibold text-gray-700">Application Instructions</dt>
                          <dd class="mt-1 text-base text-gray-900">{{ jobDetails.applicationInstructions }}</dd>
                        </div>

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                          <div>
                            <dt class="text-base font-semibold text-gray-700">Contact Person</dt>
                            <dd class="mt-1 text-base text-gray-900">{{ jobDetails.contactPerson }}</dd>
                          </div>
                          <div>
                            <dt class="text-base font-semibold text-gray-700">Contact Email</dt>
                            <dd class="mt-1 text-base text-gray-900">{{ jobDetails.contactEmail }}</dd>
                          </div>
                        </div>

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                          <div>
                            <dt class="text-base font-semibold text-gray-700">Phone</dt>
                            <dd class="mt-1 text-base text-gray-900">{{ jobDetails.contactPhone }}</dd>
                          </div>
                          <div>
                            <dt class="text-base font-semibold text-gray-700">Preferred Contact Method</dt>
                            <dd class="mt-1 text-base text-gray-900">{{ jobDetails.preferredContact }}</dd>
                          </div>
                        </div>
                      </div>
                    </div>

                    <!-- Administrative Details Section -->
                    <div>
                      <h3 class="text-xl font-bold text-gray-900 mb-6 border-b border-gray-300 pb-2">Administrative Details</h3>
                      <div class="space-y-8">
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                          <div>
                            <dt class="text-base font-semibold text-gray-700">Job Status</dt>
                            <dd class="mt-1 text-base text-gray-900">{{ jobDetails.status }}</dd>
                          </div>
                          <div>
                            <dt class="text-base font-semibold text-gray-700">Number of Positions</dt>
                            <dd class="mt-1 text-base text-gray-900">{{ jobDetails.positionCount }}</dd>
                          </div>
                        </div>

                        <div>
                          <dt class="text-base font-semibold text-gray-700">Remote Work Options</dt>
                          <dd class="mt-1 text-base text-gray-900">{{ jobDetails.remoteWork }}</dd>
                        </div>

                        <div>
                          <dt class="text-base font-semibold text-gray-700">Visa/Work Authorization Requirements</dt>
                          <dd class="mt-1 text-base text-gray-900">{{ jobDetails.visaRequirements }}</dd>
                        </div>
                      </div>
                    </div>

                    <!-- Benefits Section -->
                    <div>
                      <h3 class="text-xl font-bold text-gray-900 mb-6 border-b border-gray-300 pb-2">Benefits & Additional Information</h3>
                      <div class="space-y-8">
                        <div>
                          <dt class="text-base font-semibold text-gray-700">Benefits Package</dt>
                          <dd class="mt-1 text-base text-gray-900">{{ jobDetails.benefits }}</dd>
                        </div>

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                          <div>
                            <dt class="text-base font-semibold text-gray-700">Housing Provided</dt>
                            <dd class="mt-1 text-base text-gray-900">{{ jobDetails.housingProvided }}</dd>
                          </div>
                          <div>
                            <dt class="text-base font-semibold text-gray-700">Relocation Assistance</dt>
                            <dd class="mt-1 text-base text-gray-900">{{ jobDetails.relocationAssistance }}</dd>
                          </div>
                        </div>

                        <div>
                          <dt class="text-base font-semibold text-gray-700">Professional Development</dt>
                          <dd class="mt-1 text-base text-gray-900">{{ jobDetails.professionalDevelopment }}</dd>
                        </div>

                        <div>
                          <dt class="text-base font-semibold text-gray-700">Additional Perks</dt>
                          <dd class="mt-1 text-base text-gray-900">{{ jobDetails.additionalPerks }}</dd>
                        </div>
                      </div>
                    </div>
                  </div>

                  <!-- Edit/Create Mode -->
                  <form v-if="isEditing || !activeJob.id" @submit.prevent="saveJob" class="space-y-8">
                    <!-- Church Selection for New Job -->
                    <div v-if="!activeJob.id" class="space-y-8">
                      <h3 class="text-xl font-bold text-gray-900 mb-6 border-b border-gray-300 pb-2">Attach to Church/Ministry</h3>
                      <div>
                        <label class="block text-base font-semibold text-gray-700 mb-2">Select Church/Ministry</label>
                        <div class="relative">
                          <input
                            type="text"
                            v-model="churchSearchQuery"
                            @input="filterChurches"
                            placeholder="Search by church name or ID..."
                            class="block w-full px-4 py-3.5 text-base text-gray-900 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-purple-500"
                          />
                          <!-- Dropdown for filtered churches -->
                          <div v-if="showChurchDropdown && filteredChurches.length > 0" 
                            class="absolute z-10 w-full mt-1 bg-white shadow-lg max-h-60 rounded-md py-1 text-base overflow-auto focus:outline-none sm:text-sm"
                          >
                            <div v-for="church in filteredChurches" 
                              :key="church.id"
                              @click="selectChurch(church)"
                              class="cursor-pointer select-none relative py-2 pl-3 pr-9 hover:bg-purple-50"
                            >
                              <div class="flex items-center">
                                <span class="block truncate font-medium text-gray-900">{{ church.name }}</span>
                                <span class="ml-1 truncate text-gray-400 text-sm">ID:{{ church.id }}</span>
                              </div>
                            </div>
                          </div>
                        </div>
                        <!-- Selected church display -->
                        <div v-if="selectedChurch" class="mt-2 flex items-center text-sm">
                          <span class="font-medium text-gray-900">Selected:</span>
                          <span class="ml-2 text-gray-700">{{ selectedChurch.name }}</span>
                          <span class="ml-1 text-gray-400 text-sm">ID:{{ selectedChurch.id }}</span>
                        </div>
                      </div>
                    </div>

                    <!-- Essential Job Details Section -->
                    <div>
                      <h3 class="text-xl font-bold text-gray-900 mb-6 border-b border-gray-300 pb-2">Essential Job Details</h3>
                      <div class="space-y-8">
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                          <div>
                            <label class="block text-base font-semibold text-gray-700 mb-2">Job Title</label>
                            <input 
                              type="text" 
                              v-model="editedJob.title" 
                              class="block w-full px-4 py-3.5 text-base text-gray-900 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-purple-500"
                              placeholder="Worship Leader"
                            >
                          </div>

                          <div>
                            <label class="block text-base font-semibold text-gray-700 mb-2">Church/Ministry Name</label>
                            <input 
                              type="text" 
                              :value="selectedChurch ? selectedChurch.name : ''"
                              class="block w-full px-4 py-3.5 text-base text-gray-900 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-purple-500"
                              disabled
                            >
                          </div>
                        </div>

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                          <div>
                            <label class="block text-base font-semibold text-gray-700 mb-2">Expected Start Date</label>
                            <input 
                              type="date" 
                              v-model="editedJob.expectedStartDate"
                              class="block w-full px-4 py-3.5 text-base text-gray-900 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-purple-500"
                            >
                          </div>

                          <div>
                            <label class="block text-base font-semibold text-gray-700 mb-2">Application Deadline</label>
                            <input 
                              type="date" 
                              v-model="editedJob.applicationDeadline"
                              class="block w-full px-4 py-3.5 text-base text-gray-900 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-purple-500"
                            >
                          </div>
                        </div>

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                          <div>
                            <label class="block text-base font-semibold text-gray-700 mb-2">Job Type</label>
                            <select 
                              v-model="editedJob.jobType" 
                              class="block w-full px-4 py-3.5 text-base text-gray-900 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-purple-500"
                            >
                              <option value="">Select Job Type</option>
                              <option value="Full-time">Full-time</option>
                              <option value="Part-time">Part-time</option>
                              <option value="Contract">Contract</option>
                              <option value="Temporary">Temporary</option>
                              <option value="Volunteer">Volunteer</option>
                              <option value="Internship">Internship</option>
                            </select>
                          </div>

                          <div>
                            <label class="block text-base font-semibold text-gray-700 mb-2">Job Category</label>
                            <select 
                              v-model="editedJob.jobCategory" 
                              class="block w-full px-4 py-3.5 text-base text-gray-900 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-purple-500"
                            >
                              <option value="">Select Category</option>
                              <option value="Pastoral">Pastoral</option>
                              <option value="Music/Worship">Music/Worship</option>
                              <option value="Youth/Children">Youth/Children</option>
                              <option value="Administration">Administration</option>
                              <option value="Education">Education</option>
                              <option value="Media/Technology">Media/Technology</option>
                              <option value="Outreach/Missions">Outreach/Missions</option>
                              <option value="Counseling">Counseling</option>
                              <option value="Other">Other</option>
                            </select>
                          </div>
                        </div>

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                          <div>
                            <label class="block text-base font-semibold text-gray-700 mb-2">Location</label>
                            <input 
                              type="text" 
                              v-model="editedJob.location" 
                              class="block w-full px-4 py-3.5 text-base text-gray-900 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-purple-500"
                              placeholder="Houston, TX"
                            >
                          </div>

                          <div>
                            <label class="block text-base font-semibold text-gray-700 mb-2">Salary Range</label>
                            <input 
                              type="text" 
                              v-model="editedJob.salaryRange" 
                              class="block w-full px-4 py-3.5 text-base text-gray-900 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-purple-500"
                              placeholder="$40,000 - $50,000/year"
                            >
                          </div>
                        </div>
                      </div>
                    </div>

                    <!-- Job Description Section -->
                    <div>
                      <h3 class="text-xl font-bold text-gray-900 mb-6 border-b border-gray-300 pb-2">Job Description</h3>
                      <div class="space-y-8">
                        <div>
                          <label class="block text-base font-semibold text-gray-700 mb-2">About the Church/Ministry</label>
                          <textarea 
                            v-model="editedJob.aboutChurch" 
                            rows="4"
                            class="block w-full px-4 py-3.5 text-base text-gray-900 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-purple-500"
                            placeholder="Describe your church/ministry's mission, vision, size, and culture"
                          ></textarea>
                        </div>

                        <div>
                          <label class="block text-base font-semibold text-gray-700 mb-2">Position Overview</label>
                          <textarea 
                            v-model="editedJob.positionOverview" 
                            rows="4"
                            class="block w-full px-4 py-3.5 text-base text-gray-900 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-purple-500"
                            placeholder="Provide a brief overview of the role and its importance to the ministry"
                          ></textarea>
                        </div>

                        <div>
                          <label class="block text-base font-semibold text-gray-700 mb-2">Key Responsibilities</label>
                          <textarea 
                            v-model="editedJob.keyResponsibilities" 
                            rows="4"
                            class="block w-full px-4 py-3.5 text-base text-gray-900 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-purple-500"
                            placeholder="- Lead worship services
- Develop and implement worship strategies
- Collaborate with other ministry teams
- Train and mentor worship team members"
                          ></textarea>
                        </div>

                        <div>
                          <label class="block text-base font-semibold text-gray-700 mb-2">Required Skills/Experience</label>
                          <textarea 
                            v-model="editedJob.requiredSkills" 
                            rows="4"
                            class="block w-full px-4 py-3.5 text-base text-gray-900 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-purple-500"
                            placeholder="- 3+ years of pastoral experience
- Strong leadership and communication skills
- Experience with youth ministry
- Proficiency in social media management"
                          ></textarea>
                        </div>

                        <div>
                          <label class="block text-base font-semibold text-gray-700 mb-2">Spiritual Requirements</label>
                          <textarea 
                            v-model="editedJob.spiritualRequirements" 
                            rows="4"
                            class="block w-full px-4 py-3.5 text-base text-gray-900 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-purple-500"
                            placeholder="- Committed Christian with a strong faith
- Agreement with our church's doctrine and values
- Active involvement in church ministry
- Heart for serving others"
                          ></textarea>
                        </div>

                        <div>
                          <label class="block text-base font-semibold text-gray-700 mb-2">Education Requirements</label>
                          <textarea 
                            v-model="editedJob.educationRequirements" 
                            rows="4"
                            class="block w-full px-4 py-3.5 text-base text-gray-900 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-purple-500"
                            placeholder="- Bachelor's degree in a related field
- Master's degree preferred
- Bible college or seminary training a plus
- Relevant certifications welcome"
                          ></textarea>
                        </div>

                        <div>
                          <label class="block text-base font-semibold text-gray-700 mb-2">Additional Qualifications</label>
                          <textarea 
                            v-model="editedJob.additionalQualifications" 
                            rows="4"
                            class="block w-full px-4 py-3.5 text-base text-gray-900 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-purple-500"
                            placeholder="- Experience with church management software
- Certification in a related field
- Bilingual abilities a plus
- Worship planning experience"
                          ></textarea>
                        </div>
                      </div>
                    </div>

                    <!-- Contact & Application Information -->
                    <div>
                      <h3 class="text-xl font-bold text-gray-900 mb-6 border-b border-gray-300 pb-2">Contact & Application Information</h3>
                      <div class="space-y-8">
                        <div>
                          <label class="block text-base font-semibold text-gray-700 mb-2">Application Instructions</label>
                          <textarea 
                            v-model="editedJob.applicationInstructions" 
                            rows="4"
                            class="block w-full px-4 py-3.5 text-base text-gray-900 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-purple-500"
                            placeholder="Email resume and cover letter to [insert email]
Apply online through our website"
                          ></textarea>
                        </div>

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                          <div>
                            <label class="block text-base font-semibold text-gray-700 mb-2">Contact Person</label>
                            <input 
                              type="text" 
                              v-model="editedJob.contactPerson" 
                              class="block w-full px-4 py-3.5 text-base text-gray-900 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-purple-500"
                              placeholder="John Doe"
                            >
                          </div>

                          <div>
                            <label class="block text-base font-semibold text-gray-700 mb-2">Contact Email</label>
                            <input 
                              type="email" 
                              v-model="editedJob.contactEmail" 
                              class="block w-full px-4 py-3.5 text-base text-gray-900 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-purple-500"
                              placeholder="johndoe@example.com"
                            >
                          </div>
                        </div>

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                          <div>
                            <label class="block text-base font-semibold text-gray-700 mb-2">Phone</label>
                            <input 
                              type="tel" 
                              v-model="editedJob.phone" 
                              class="block w-full px-4 py-3.5 text-base text-gray-900 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-purple-500"
                              placeholder="555-555-5555"
                            >
                          </div>

                          <div>
                            <label class="block text-base font-semibold text-gray-700 mb-2">Preferred Contact Method</label>
                            <select
                              v-model="editedJob.preferredContactMethod" 
                              class="block w-full px-4 py-3.5 text-base text-gray-900 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-purple-500"
                            >
                              <option value="">Select Preferred Contact Method</option>
                              <option value="Email">Email</option>
                              <option value="Phone">Phone</option>
                            </select>
                          </div>
                        </div>
                      </div>
                    </div>

                    <!-- Administrative Details -->
                    <div>
                      <h3 class="text-xl font-bold text-gray-900 mb-6 border-b border-gray-300 pb-2">Administrative Details</h3>
                      <div class="space-y-8">
                        <div>
                          <label class="block text-base font-semibold text-gray-700 mb-2">Job Status</label>
                          <select 
                            v-model="editedJob.status" 
                            class="block w-full px-4 py-3.5 text-base text-gray-900 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-purple-500"
                          >
                            <option value="">Select Job Status</option>
                            <option value="pending">Pending</option>
                            <option value="active">Active</option>
                            <option value="filled">Filled</option>
                            <option value="paused">Paused</option>
                            <option value="closed">Closed</option>
                          </select>
                        </div>

                        <div>
                          <label class="block text-base font-semibold text-gray-700 mb-2">Number of Positions</label>
                          <input 
                            type="number" 
                            v-model="editedJob.numberOfPositions" 
                            class="block w-full px-4 py-3.5 text-base text-gray-900 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-purple-500"
                            placeholder="1"
                          >
                        </div>

                        <div>
                          <label class="block text-base font-semibold text-gray-700 mb-2">Remote Work Options</label>
                          <select 
                            v-model="editedJob.remoteWorkOptions" 
                            class="block w-full px-4 py-3.5 text-base text-gray-900 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-purple-500"
                          >
                            <option value="">Select Remote Work Option</option>
                            <option value="No remote work">No remote work</option>
                            <option value="Hybrid">Hybrid</option>
                            <option value="Remote">Fully remote</option>
                            <option value="Temporarily remote">Temporarily remote</option>
                          </select>
                        </div>

                        <div>
                          <label class="block text-base font-semibold text-gray-700 mb-2">Visa/Work Authorization Requirements</label>
                          <textarea 
                            v-model="editedJob.visaRequirements" 
                            rows="4"
                            class="block w-full px-4 py-3.5 text-base text-gray-900 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-purple-500"
                            placeholder="Must have valid work visa
Sponsorship available for qualified candidates"
                          ></textarea>
                        </div>
                      </div>
                    </div>

                    <!-- Benefits & Additional Information -->
                    <div>
                      <h3 class="text-xl font-bold text-gray-900 mb-6 border-b border-gray-300 pb-2">Benefits & Additional Information</h3>
                      <div class="space-y-8">
                        <div>
                          <label class="block text-base font-semibold text-gray-700 mb-2">Benefits Package</label>
                          <textarea 
                            v-model="editedJob.benefitsPackage" 
                            rows="4"
                            class="block w-full px-4 py-3.5 text-base text-gray-900 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-purple-500"
                            placeholder="Health insurance
Retirement plan
Paid time off
Professional development budget
Cell phone allowance"
                          ></textarea>
                        </div>

                        <div>
                          <label class="block text-base font-semibold text-gray-700 mb-2">Housing Provided</label>
                          <select 
                            v-model="editedJob.housingProvided" 
                            class="block w-full px-4 py-3.5 text-base text-gray-900 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-purple-500"
                          >
                            <option value="">Select Housing Option</option>
                            <option value="No">No</option>
                            <option value="Yes">Yes</option>
                            <option value="Housing allowance">Housing allowance provided</option>
                            <option value="Negotiable">Negotiable</option>
                          </select>
                        </div>

                        <div>
                          <label class="block text-base font-semibold text-gray-700 mb-2">Relocation Assistance</label>
                          <textarea 
                            v-model="editedJob.relocationAssistance" 
                            rows="4"
                            class="block w-full px-4 py-3.5 text-base text-gray-900 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-purple-500"
                            placeholder="Moving expenses reimbursed up to $5,000
Temporary housing provided for 3 months"
                          ></textarea>
                        </div>

                        <div>
                          <label class="block text-base font-semibold text-gray-700 mb-2">Professional Development</label>
                          <textarea 
                            v-model="editedJob.professionalDevelopment" 
                            rows="4"
                            class="block w-full px-4 py-3.5 text-base text-gray-900 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-purple-500"
                            placeholder="Annual conference attendance
Quarterly training sessions"
                          ></textarea>
                        </div>

                        <div>
                          <label class="block text-base font-semibold text-gray-700 mb-2">Additional Perks</label>
                          <textarea 
                            v-model="editedJob.additionalPerks" 
                            rows="4"
                            class="block w-full px-4 py-3.5 text-base text-gray-900 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-purple-500"
                            placeholder="Free parking
On-site fitness center"
                          ></textarea>
                        </div>
                      </div>
                    </div>
                  </form>
                </div>
              </div>

              <!-- Action buttons -->
              <div class="flex flex-shrink-0 justify-end px-4 py-4 gap-4">
                <button
                  @click="closeJobPanel"
                  class="inline-flex items-center px-4 py-2 text-sm font-medium text-gray-700 bg-white border border-gray-300 rounded-md hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-purple-500"
                >
                  {{ isEditing ? 'Cancel' : 'Close' }}
                </button>
                <button
                  v-if="isEditing"
                  @click="saveJob"
                  class="inline-flex items-center px-4 py-2 text-sm font-medium text-white bg-purple-600 border border-transparent rounded-md hover:bg-purple-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-purple-500"
                >
                  Save Changes
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, watch, onMounted, onUnmounted, nextTick } from 'vue'

// State
const isMobile = ref(window.innerWidth < 768)
const showMetrics = ref(!isMobile.value)
const searchQuery = ref('')
const statusFilter = ref('')
const typeFilter = ref('')
const dateFilter = ref('')
const currentPage = ref(1)
const itemsPerPage = ref(10)
const selectAll = ref(false)
const selectedJobs = ref([])
const showBulkActions = ref(false)

// Action menu state
const activeActionMenu = ref(null)
const menuPosition = ref({})

// Table headers
const tableHeaders = [
  'Job Title',
  'Hiring Church',
  'Location',
  'Type',
  'Status',
  'Posted Date',
  'Expiry Date',
  'Applications'
]

// Mock metrics data
const jobMetrics = [
  {
    label: 'Active Jobs',
    value: '124',
    percentage: '12',
    trend: 'up'
  },
  {
    label: 'Pending Approvals',
    value: '8',
    percentage: '5',
    trend: 'down'
  },
  {
    label: 'Fill Rate',
    value: '76%',
    percentage: '8',
    trend: 'up'
  },
  {
    label: 'Avg. Time to Fill',
    value: '18 days',
    percentage: '15',
    trend: 'up'
  }
]

// Mock jobs data
const jobsData = [
  {
    id: 1,
    title: 'Worship Leader',
    church: 'First Apostolic Church',
    location: 'Houston, TX',
    type: 'full-time',
    status: 'active',
    postedDate: '2024-01-15',
    expiryDate: '2024-02-15',
    applications: 12,
    description: 'We are seeking a Worship Leader to lead our congregation in worship.',
    requirements: 'Must have experience leading worship and playing an instrument.'
  },
  {
    id: 2,
    title: 'Media Director',
    church: 'Life Tabernacle',
    location: 'Dallas, TX',
    type: 'full-time',
    status: 'pending',
    postedDate: '2024-01-16',
    expiryDate: '2024-02-16',
    applications: 5,
    description: 'We are seeking a Media Director to oversee our media department.',
    requirements: 'Must have experience with video production and live streaming.'
  },
  {
    id: 3,
    title: 'Sound Technician',
    church: 'Grace Apostolic',
    location: 'Austin, TX',
    type: 'part-time',
    status: 'active',
    postedDate: '2024-01-14',
    expiryDate: '2024-02-14',
    applications: 8,
    description: 'We are seeking a Sound Technician to assist with our sound needs.',
    requirements: 'Must have experience with sound equipment and live sound.'
  }
]

// Computed properties
const filteredJobs = computed(() => {
  let jobs = jobsData

  // Apply search filter
  if (searchQuery.value) {
    const query = searchQuery.value.toLowerCase()
    jobs = jobs.filter(job => 
      job.title.toLowerCase().includes(query) ||
      job.church.toLowerCase().includes(query) ||
      job.location.toLowerCase().includes(query)
    )
  }

  // Apply status filter
  if (statusFilter.value) {
    jobs = jobs.filter(job => job.status === statusFilter.value)
  }

  // Apply type filter
  if (typeFilter.value) {
    jobs = jobs.filter(job => job.type === typeFilter.value)
  }

  // Apply date filter
  if (dateFilter.value) {
    const today = new Date()
    switch (dateFilter.value) {
      case 'today':
        jobs = jobs.filter(job => isToday(new Date(job.postedDate)))
        break
      case 'week':
        jobs = jobs.filter(job => isThisWeek(new Date(job.postedDate)))
        break
      case 'month':
        jobs = jobs.filter(job => isThisMonth(new Date(job.postedDate)))
        break
    }
  }

  return jobs
})

const paginatedJobs = computed(() => {
  const start = (currentPage.value - 1) * itemsPerPage.value
  const end = start + itemsPerPage.value
  return filteredJobs.value.slice(start, end)
})

const totalJobs = computed(() => filteredJobs.value.length)
const totalPages = computed(() => Math.ceil(totalJobs.value / itemsPerPage.value))
const paginationStart = computed(() => ((currentPage.value - 1) * itemsPerPage.value) + 1)
const paginationEnd = computed(() => Math.min(currentPage.value * itemsPerPage.value, totalJobs.value))

// Job panel state
const activeJob = ref(null)
const isEditing = ref(false)
const editedJob = ref(null)

// Format label for display
const formatLabel = (key) => {
  return key.charAt(0).toUpperCase() + key.slice(1).replace(/([A-Z])/g, ' $1')
}

// Computed job details for view mode
const jobDetails = computed(() => {
  if (!activeJob.value) return {}
  return {
    title: activeJob.value.title,
    church: activeJob.value.church,
    location: activeJob.value.location,
    type: activeJob.value.type,
    status: activeJob.value.status,
    postedDate: formatDate(activeJob.value.postedDate),
    expiryDate: formatDate(activeJob.value.expiryDate),
    description: activeJob.value.description,
    requirements: activeJob.value.requirements,
  }
})

// Methods
const formatDate = (date) => {
  return new Date(date).toLocaleDateString('en-US', {
    year: 'numeric',
    month: 'short',
    day: 'numeric'
  })
}

const getJobTypeClass = (type) => {
  const classes = {
    'full-time': 'bg-blue-100 text-blue-800',
    'part-time': 'bg-green-100 text-green-800',
    'contract': 'bg-yellow-100 text-yellow-800'
  }
  return classes[type] || ''
}

const getStatusClass = (status) => {
  switch (status) {
    case 'pending':
      return 'bg-orange-100 text-orange-800'
    case 'active':
      return 'bg-green-100 text-green-800'
    case 'filled':
      return 'bg-blue-100 text-blue-800'
    case 'paused':
      return 'bg-yellow-100 text-yellow-800'
    case 'closed':
      return 'bg-gray-100 text-gray-800'
    default:
      return 'bg-gray-100 text-gray-800'
  }
}

const isToday = (date) => {
  const today = new Date()
  return date.getDate() === today.getDate() &&
    date.getMonth() === today.getMonth() &&
    date.getFullYear() === today.getFullYear()
}

const isThisWeek = (date) => {
  const today = new Date()
  const weekStart = new Date(today.setDate(today.getDate() - today.getDay()))
  const weekEnd = new Date(today.setDate(today.getDate() + 6))
  return date >= weekStart && date <= weekEnd
}

const isThisMonth = (date) => {
  const today = new Date()
  return date.getMonth() === today.getMonth() &&
    date.getFullYear() === today.getFullYear()
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

const openJobMenu = (job) => {
  console.log('Open job menu for:', job)
}

const openBulkActions = () => {
  if (selectedJobs.value.length > 0) {
    showBulkActions.value = true
  }
}

const closeBulkActions = () => {
  showBulkActions.value = false
}

const toggleActionMenu = (jobId, event) => {
  event.stopPropagation()
  
  // If already open, close it
  if (activeActionMenu.value === jobId) {
    activeActionMenu.value = null
    return
  }

  // Close any other open menu first
  activeActionMenu.value = null
  
  // Wait for next tick to ensure proper positioning
  nextTick(() => {
    // Get button position
    const button = event.currentTarget
    const rect = button.getBoundingClientRect()
    
    menuPosition.value = {
      position: 'fixed',
      top: `${rect.bottom + 4}px`,
      right: `${window.innerWidth - rect.right}px`
    }
    
    // Set active menu after positioning is calculated
    activeActionMenu.value = jobId
  })
}

const viewJobDetails = (job) => {
  activeJob.value = { ...job }
  isEditing.value = false
  editedJob.value = null
}

const editJob = (job) => {
  activeJob.value = { ...job }
  editedJob.value = { ...job }
  isEditing.value = true
}

const markAsFilled = (job) => {
  // Implement mark as filled
  console.log('Mark as filled:', job)
  activeActionMenu.value = null
}

const toggleJobStatus = (job) => {
  // Implement toggle status
  console.log('Toggle status:', job)
  activeActionMenu.value = null
}

const closePosition = (job) => {
  // Implement close position
  console.log('Close position:', job)
  activeActionMenu.value = null
}

const confirmDeleteJob = (job) => {
  if (confirm('Are you sure you want to delete this job? This action cannot be undone.')) {
    // Implement delete job
    console.log('Delete job:', job)
  }
  activeActionMenu.value = null
}

const bulkApprove = () => {
  if (selectedJobs.value.length === 0) return
  // Implement bulk approve logic
  console.log('Bulk approve:', selectedJobs.value)
}

const bulkDelete = () => {
  if (selectedJobs.value.length === 0) return
  if (confirm(`Are you sure you want to delete ${selectedJobs.value.length} jobs? This action cannot be undone.`)) {
    // Implement bulk delete logic
    console.log('Bulk delete:', selectedJobs.value)
  }
}

const bulkExtend = () => {
  // Implement bulk extend logic
  console.log('Bulk extend:', selectedJobs.value)
}

const bulkExport = () => {
  // Implement bulk export logic
  console.log('Bulk export:', selectedJobs.value)
}

const closeJobPanel = () => {
  activeJob.value = null
  isEditing.value = false
  editedJob.value = null
}

const saveJob = async () => {
  try {
    // Here you would update the job in your backend
    // await updateJob(editedJob.value)
    
    // Update local state
    const index = jobsData.findIndex(j => j.id === editedJob.value.id)
    if (index !== -1) {
      jobsData[index] = { ...editedJob.value }
    }
    
    // Close panel
    closeJobPanel()
  } catch (error) {
    console.error('Error saving job:', error)
  }
}

const createJob = async () => {
  try {
    // Here you would create a new job in your backend
    // await createJob(editedJob.value)
    
    // Update local state
    jobsData.push({ ...editedJob.value })
    
    // Close panel
    closeJobPanel()
  } catch (error) {
    console.error('Error creating job:', error)
  }
}

const handleMenuAction = (action, job) => {
  switch (action) {
    case 'view':
      viewJobDetails(job)
      break
    case 'edit':
      editJob(job)
      break
    case 'filled':
      markAsFilled(job)
      break
    case 'toggle':
      toggleJobStatus(job)
      break
    case 'close':
      closePosition(job)
      break
    case 'delete':
      confirmDeleteJob(job)
      break
  }
  activeActionMenu.value = null
}

const openCreateJobPanel = () => {
  activeJob.value = {}  // Ensure the panel opens by setting activeJob to an empty object
  isEditing.value = false  // Set to false since we're creating a new job
  editedJob.value = {
    title: '',
    churchName: '',
    location: '',
    jobType: '',
    jobCategory: '',
    startDate: '',
    deadline: '',
    salaryRange: '',
    aboutChurch: '',
    positionOverview: '',
    keyResponsibilities: '',
    requiredSkills: '',
    spiritualRequirements: '',
    educationRequirements: '',
    additionalQualifications: '',
    applicationInstructions: '',
    contactPerson: '',
    contactEmail: '',
    phone: '',
    contactMethod: '',
    internalNotes: '',
  }
}

// Close menu when clicking outside
const closeMenuOnClickOutside = (event) => {
  // Don't close if clicking the button or inside the menu
  if (event.target.closest('.actions-button') || event.target.closest('.actions-menu')) {
    return
  }
  activeActionMenu.value = null
}

// Close menu when scrolling table
const closeMenuOnScroll = () => {
  if (activeActionMenu.value !== null) {
    activeActionMenu.value = null
  }
}

// Handle window resize
const handleResize = () => {
  isMobile.value = window.innerWidth < 768
  if (isMobile.value) {
    showMetrics.value = false
  }
}

// Add and remove event listeners
onMounted(() => {
  window.addEventListener('click', closeMenuOnClickOutside)
  window.addEventListener('scroll', closeMenuOnScroll, { passive: true })
  window.addEventListener('resize', handleResize)
})

onUnmounted(() => {
  window.removeEventListener('click', closeMenuOnClickOutside)
  window.removeEventListener('scroll', closeMenuOnScroll)
  window.removeEventListener('resize', handleResize)
})
// Watch for selectAll changes
watch(selectAll, (value) => {
  if (value) {
    selectedJobs.value = paginatedJobs.value.map(job => job.id)
  } else {
    selectedJobs.value = []
  }
})

// Watch selectedJobs and hide bulk actions if none selected
watch(selectedJobs, (newVal) => {
  if (newVal.length === 0) {
    showBulkActions.value = false
  }
})

// Church list for dropdown
const churchList = ref([
  { id: 1, name: 'First Apostolic Church' },
  { id: 2, name: 'Life Tabernacle' },
  { id: 3, name: 'Grace Apostolic' },
  // Add more churches here...
])

// Selected church for new job
const selectedChurch = ref(null)

// Church search query
const churchSearchQuery = ref('')

// Filtered churches
const filteredChurches = computed(() => {
  if (!churchSearchQuery.value) return churchList.value
  const query = churchSearchQuery.value.toLowerCase()
  return churchList.value.filter(church => 
    church.name.toLowerCase().includes(query) || 
    church.id.toString().includes(query)
  )
})

// Show church dropdown
const showChurchDropdown = computed(() => {
  return churchSearchQuery.value && filteredChurches.value.length > 0
})

// Select church
const selectChurch = (church) => {
  selectedChurch.value = church
  churchSearchQuery.value = ''
}

</script>
