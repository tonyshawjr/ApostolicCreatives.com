<template>
  <div class="bg-white">
    <!-- Hero Section -->
    <div class="relative overflow-hidden bg-gradient-to-b from-[#1F2937] to-[#374151] text-white">
      <div class="max-w-[1280px] mx-auto px-4 sm:px-6 lg:px-8">
        <div class="relative z-10 py-16 sm:py-24 lg:py-32">
          <div class="text-center">
            <h1 class="text-4xl tracking-tight font-extrabold sm:text-5xl md:text-6xl">
              <span class="block">Contact Us</span>
              <span class="block text-purple-400">We're Here to Help</span>
            </h1>
            <p class="mt-3 text-lg text-gray-300 sm:mt-5 sm:text-xl max-w-3xl mx-auto">
              Whether you have questions or need assistance, reach out to us.
            </p>
          </div>
        </div>
      </div>
    </div>

    <!-- Contact Information & Form Section -->
    <div class="py-24 bg-white">
      <div class="max-w-[1280px] mx-auto px-4 sm:px-6 lg:px-8 grid grid-cols-1 md:grid-cols-2 gap-16">
        <!-- Contact Information -->
        <div>
          <h2 class="text-3xl font-extrabold tracking-tight text-gray-900">Contact Information</h2>
          <p class="mt-4 text-lg text-gray-500">
            For specific inquiries, please contact:
          </p>
          <ul class="mt-6 space-y-4">
            <li>
              <span class="font-bold text-gray-900">Partner Development</span><br>
              Evan Grizzle<br>
              <a href="mailto:evan.grizzle@apostoliccreatives.com" class="text-purple-600 hover:underline">evan.grizzle@apostoliccreatives.com</a>
            </li>
            <li>
              <span class="font-bold text-gray-900">Creative Ambassador</span><br>
              Ethan Short<br>
              <a href="mailto:ethan.short@apostoliccreatives.com" class="text-purple-600 hover:underline">ethan.short@apostoliccreatives.com</a>
            </li>
            <li>
              <span class="font-bold text-gray-900">General Support</span><br>
              <a href="mailto:support@apostoliccreatives.com" class="text-purple-600 hover:underline">support@apostoliccreatives.com</a>
            </li>
          </ul>
        </div>

        <!-- Contact Form -->
        <div>
          <h2 class="text-3xl font-extrabold tracking-tight text-gray-900">Send us a message</h2>
          <form @submit.prevent="handleSubmit" class="mt-6 space-y-6">
            <div>
              <label for="name" class="block text-sm font-medium text-gray-700">Name</label>
              <input type="text" name="name" id="name" v-model="form.name" class="mt-1 block w-full shadow-sm border border-gray-300 rounded-md bg-gray-50 focus:bg-white focus:ring-purple-500 focus:border-purple-500 py-3 px-4" required>
            </div>
            <div>
              <label for="email" class="block text-sm font-medium text-gray-700">Email</label>
              <input type="email" name="email" id="email" v-model="form.email" class="mt-1 block w-full shadow-sm border border-gray-300 rounded-md bg-gray-50 focus:bg-white focus:ring-purple-500 focus:border-purple-500 py-3 px-4" required>
            </div>
            <div>
              <label for="subject" class="block text-sm font-medium text-gray-700">Subject</label>
              <input type="text" name="subject" id="subject" v-model="form.subject" class="mt-1 block w-full shadow-sm border border-gray-300 rounded-md bg-gray-50 focus:bg-white focus:ring-purple-500 focus:border-purple-500 py-3 px-4" required>
            </div>
            <div>
              <label for="message" class="block text-sm font-medium text-gray-700">Message</label>
              <textarea id="message" name="message" rows="4" v-model="form.message" class="mt-1 block w-full shadow-sm border border-gray-300 rounded-md bg-gray-50 focus:bg-white focus:ring-purple-500 focus:border-purple-500 py-3 px-4" required></textarea>
            </div>
            <div>
              <button type="submit" class="w-full inline-flex items-center justify-center px-6 py-3 border border-transparent rounded-md shadow-sm text-base font-medium text-white bg-gradient-to-r from-purple-800 to-pink-600 hover:opacity-90 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-purple-500">
                Send Message
              </button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'

const form = ref({
  name: '',
  email: '',
  subject: '',
  message: ''
})

const handleSubmit = async () => {
  // Implement form submission logic here
  console.log('Form submitted:', form.value)
}
</script>