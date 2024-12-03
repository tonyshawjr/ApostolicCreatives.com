<template>
  <div class=" bg-white">
    <!-- Hero section -->
    <div class="relative overflow-hidden bg-gradient-to-b from-[#1F2937] to-[#374151] text-white">
      <div class="max-w-[1280px] mx-auto px-4 sm:px-6 lg:px-8">
        <div class="relative z-10 py-16 sm:py-24 lg:py-32">
          <div class="text-center">
            <h1 class="text-4xl tracking-tight font-extrabold sm:text-5xl md:text-6xl">
              <span class="block">Pricing Plans</span>
              <span class="block text-purple-400">Choose the Right Plan for You</span>
            </h1>
            <p class="mt-3 text-lg text-gray-300 sm:mt-5 sm:text-xl max-w-3xl mx-auto">
              Find the perfect plan to fit your needs and help your church thrive.
            </p>
          </div>
        </div>
      </div>
    </div>
    <!-- Pricing Section -->
<div class="py-24">
  <div class="max-w-[1280px] mx-auto px-4 sm:px-6 lg:px-8 pb-24">
    <div class="grid lg:grid-cols-3 gap-8">
      <!-- Creative Plan -->
      <div class="relative p-10 bg-white border border-gray-200 rounded-2xl shadow-sm flex flex-col">
        <div class="flex-1">
          <h3 class="text-xl font-semibold text-gray-900">Creative</h3>
          <p class="mt-4 flex items-baseline text-gray-900">
            <span class="text-5xl font-extrabold tracking-tight">$0</span>
            <span class="ml-1 text-xl font-semibold">/month</span>
          </p>
          <p class="mt-6 text-gray-500">Perfect for creatives to get started and explore opportunities.</p>
          <!-- Feature List -->
          <ul role="list" class="mt-6 space-y-6">
            <li class="flex">
              <span class="text-purple-600">
                <svg class="h-6 w-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                </svg>
              </span>
              <span class="ml-3 text-gray-500">Profile listing</span>
            </li>
            <li class="flex">
              <span class="text-purple-600">
                <svg class="h-6 w-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                </svg>
              </span>
              <span class="ml-3 text-gray-500">Browse opportunities</span>
            </li>
            <li class="flex">
              <span class="text-purple-600">
                <svg class="h-6 w-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                </svg>
              </span>
              <span class="ml-3 text-gray-500">Community access</span>
            </li>
          </ul>
        </div>
        <router-link to="/register" class="mt-8 block w-full py-3 px-6 border border-transparent rounded-md text-center font-medium text-purple-700 bg-purple-50 hover:bg-purple-100 transition-colors">
          Get started
        </router-link>
      </div>
      <!-- Up to 150 Members Plan -->
      <div class="relative p-10 bg-white border-2 border-purple-600 rounded-2xl shadow-sm flex flex-col">
        <div class="absolute top-0 right-0 mt-[-1rem] mr-8 inline-flex px-4 py-1 rounded-full text-sm font-semibold tracking-wide bg-gradient-to-r from-purple-800 to-pink-600 text-white">
          Most Popular
        </div>
        <div class="flex-1">
          <h3 class="text-xl font-semibold text-gray-900">Up to 150 members</h3>
          <p class="mt-4 flex items-baseline text-gray-900">
            <span class="text-5xl font-extrabold tracking-tight">$29</span>
            <span class="ml-1 text-xl font-semibold">/month</span>
          </p>
          <p class="mt-6 text-gray-500">Ideal for small churches looking to expand.</p>
          <!-- Feature List -->
          <ul role="list" class="mt-6 space-y-6">
            <li class="flex">
              <span class="text-purple-600">
                <svg class="h-6 w-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                </svg>
              </span>
              <span class="ml-3 text-gray-500">Enhanced profile with portfolio</span>
            </li>
            <li class="flex">
              <span class="text-purple-600">
                <svg class="h-6 w-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                </svg>
              </span>
              <span class="ml-3 text-gray-500">Priority job matching</span>
            </li>
            <li class="flex">
              <span class="text-purple-600">
                <svg class="h-6 w-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                </svg>
              </span>
              <span class="ml-3 text-gray-500">Direct messaging</span>
            </li>
            <li class="flex">
              <span class="text-purple-600">
                <svg class="h-6 w-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                </svg>
              </span>
              <span class="ml-3 text-gray-500">Professional resources</span>
            </li>
          </ul>
        </div>
        <router-link to="/register" class="mt-8 block w-full py-3 px-6 border border-transparent rounded-md text-center font-medium text-white bg-gradient-to-r from-purple-800 to-pink-600 hover:opacity-90 transition-opacity">
          Get started
        </router-link>
      </div>
      <!-- Over 250 Members Plan -->
      <div class="relative p-10 bg-white border border-gray-200 rounded-2xl shadow-sm flex flex-col">
        <div class="flex-1">
          <h3 class="text-xl font-semibold text-gray-900">Over 250 members</h3>
          <p class="mt-4 flex items-baseline text-gray-900">
            <span class="text-5xl font-extrabold tracking-tight">$99</span>
            <span class="ml-1 text-xl font-semibold">/month</span>
          </p>
          <p class="mt-6 text-gray-500">Advanced features for larger churches and organizations.</p>
          <!-- Feature List -->
          <ul role="list" class="mt-6 space-y-6">
            <li class="flex">
              <span class="text-purple-600">
                <svg class="h-6 w-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                </svg>
              </span>
              <span class="ml-3 text-gray-500">Multiple team members</span>
            </li>
            <li class="flex">
              <span class="text-purple-600">
                <svg class="h-6 w-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                </svg>
              </span>
              <span class="ml-3 text-gray-500">Advanced analytics</span>
            </li>
            <li class="flex">
              <span class="text-purple-600">
                <svg class="h-6 w-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                </svg>
              </span>
              <span class="ml-3 text-gray-500">Dedicated support</span>
            </li>
            <li class="flex">
              <span class="text-purple-600">
                <svg class="h-6 w-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                </svg>
              </span>
              <span class="ml-3 text-gray-500">Custom integrations</span>
            </li>
          </ul>
        </div>
        <router-link to="/register" class="mt-8 block w-full py-3 px-6 border border-transparent rounded-md text-center font-medium text-purple-700 bg-purple-50 hover:bg-purple-100 transition-colors">
          Contact sales
        </router-link>
      </div>
    </div>
  </div>
</div>
    <!-- FAQ Section -->
    <div class="py-12 bg-gray-50">
      <div class="max-w-[1280px] mx-auto px-4 sm:px-6 lg:px-8">
        <h2 class="text-3xl font-extrabold text-gray-900">Frequently Asked Questions</h2>
        <div class="mt-8 grid grid-cols-1 md:grid-cols-2 gap-8">
          <div class="bg-white p-6 rounded-lg shadow-md">
            <h3 class="text-lg font-medium text-gray-900">What is included in the Basic plan?</h3>
            <p class="mt-2 text-base text-gray-500">The Basic plan includes access to our community and basic profile listing.</p>
          </div>
          <div class="bg-white p-6 rounded-lg shadow-md">
            <h3 class="text-lg font-medium text-gray-900">Can I upgrade my plan later?</h3>
            <p class="mt-2 text-base text-gray-500">Yes, you can upgrade to a higher plan at any time from your account settings.</p>
          </div>
          <div class="bg-white p-6 rounded-lg shadow-md">
            <h3 class="text-lg font-medium text-gray-900">Is there a discount for annual billing?</h3>
            <p class="mt-2 text-base text-gray-500">Yes, we offer a 10% discount if you choose to pay annually.</p>
          </div>
          <div class="bg-white p-6 rounded-lg shadow-md">
            <h3 class="text-lg font-medium text-gray-900">How can I contact support?</h3>
            <p class="mt-2 text-base text-gray-500">You can contact support through our help center or by emailing support@example.com.</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script setup>
// Component logic here
</script>
<style>
/* Add any custom styles here */
</style>