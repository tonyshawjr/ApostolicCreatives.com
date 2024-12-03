<template>
  <div class="bg-white">
    <!-- Header -->
    <div class="max-w-[1280px] mx-auto px-4 sm:px-6 lg:px-8 py-16 sm:py-24">
      <div class="text-center">
        <h1 class="text-4xl font-extrabold sm:text-5xl sm:tracking-tight lg:text-6xl bg-gradient-to-r from-purple-800 to-pink-600 bg-clip-text text-transparent">
          Success Stories
        </h1>
        <p class="max-w-xl mt-5 mx-auto text-xl text-gray-500">
          Hear from our community of creatives and churches who found their perfect match
        </p>
      </div>
    </div>

    <!-- Featured Testimonial -->
    <div class="relative bg-gradient-to-b from-[#1F2937] to-[#374151] text-white">
      <div class="max-w-[1280px] mx-auto px-4 sm:px-6 lg:px-8 py-16 sm:py-24">
        <div class="relative">
          <blockquote class="mt-8">
            <div class="max-w-3xl mx-auto text-center text-2xl font-medium leading-9 text-white">
              <p>
                "Finding the right creative talent for our church was always a challenge until we discovered Apostolic Creatives. The platform made it incredibly easy to connect with skilled professionals who understand our vision and values."
              </p>
            </div>
            <footer class="mt-8">
              <div class="md:flex md:items-center md:justify-center">
                <div class="md:flex-shrink-0">
                  <img class="mx-auto h-16 w-16 rounded-full" src="https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80" alt="" />
                </div>
                <div class="mt-3 text-center md:mt-0 md:ml-4 md:flex md:items-center">
                  <div class="text-lg font-medium text-white">Sarah Johnson</div>
                  <svg class="hidden md:block mx-1 h-5 w-5 text-pink-300" fill="currentColor" viewBox="0 0 20 20">
                    <path d="M11 0h3L9 20H6l5-20z" />
                  </svg>
                  <div class="text-base font-medium text-pink-200">Worship Pastor, Grace Community Church</div>
                </div>
              </div>
            </footer>
          </blockquote>
        </div>
      </div>
    </div>

    <!-- Testimonial Grid -->
    <div class="max-w-[1280px] mx-auto px-4 sm:px-6 lg:px-8 py-16 sm:py-24">
      <div class="grid gap-8 lg:grid-cols-3">
        <!-- Testimonial 1 -->
        <div class="bg-white rounded-2xl shadow-sm p-8 border border-gray-200">
          <div class="flex items-center mb-6">
            <img class="h-12 w-12 rounded-full" src="https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80" alt="" />
            <div class="ml-4">
              <h3 class="text-lg font-medium text-gray-900">Michael Brown</h3>
              <p class="text-gray-500">Media Director</p>
            </div>
          </div>
          <p class="text-gray-500">
            "The quality of creative professionals on this platform is outstanding. We've found amazing talent that has helped transform our church's media presence."
          </p>
        </div>

        <!-- Testimonial 2 -->
        <div class="bg-white rounded-2xl shadow-sm p-8 border border-gray-200">
          <div class="flex items-center mb-6">
            <img class="h-12 w-12 rounded-full" src="https://images.unsplash.com/photo-1517841905240-472988babdf9?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80" alt="" />
            <div class="ml-4">
              <h3 class="text-lg font-medium text-gray-900">Emily Davis</h3>
              <p class="text-gray-500">Graphic Designer</p>
            </div>
          </div>
          <p class="text-gray-500">
            "As a creative professional, finding churches that value and understand creative work was difficult. This platform has opened up amazing opportunities for me."
          </p>
        </div>

        <!-- Testimonial 3 -->
        <div class="bg-white rounded-2xl shadow-sm p-8 border border-gray-200">
          <div class="flex items-center mb-6">
            <img class="h-12 w-12 rounded-full" src="https://images.unsplash.com/photo-1519345182560-3f2917c472ef?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80" alt="" />
            <div class="ml-4">
              <h3 class="text-lg font-medium text-gray-900">David Wilson</h3>
              <p class="text-gray-500">Sound Engineer</p>
            </div>
          </div>
          <p class="text-gray-500">
            "The platform's focus on the Apostolic community makes it unique. I've found projects that align perfectly with my values and expertise."
          </p>
        </div>
      </div>
    </div>

    <!-- CTA Section -->
    <div class="bg-gray-50">
      <div class="max-w-[1280px] mx-auto px-4 sm:px-6 lg:px-8 py-16 sm:py-24">
        <div class="text-center">
          <h2 class="text-3xl font-extrabold text-gray-900 sm:text-4xl">
            Ready to share your story?
          </h2>
          <p class="mt-4 text-lg text-gray-500">
            Join our community and connect with churches and creatives who share your vision.
          </p>
          <div class="mt-8">
            <router-link to="/register" class="inline-flex items-center justify-center px-8 py-3 border border-transparent text-base font-medium rounded-lg text-white bg-gradient-to-r from-purple-800 to-pink-600 hover:opacity-90 transition-opacity md:text-lg">
              Get started today
            </router-link>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
// Component logic here
</script>