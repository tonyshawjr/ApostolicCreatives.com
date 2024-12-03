
<template>
  <div class="bg-white">
    <!-- Header -->
    <div class="relative overflow-hidden bg-gradient-to-b from-[#1F2937] to-[#374151] text-white">
      <div class="max-w-[1280px] mx-auto px-4 sm:px-6 lg:px-8">
        <div class="relative z-10 py-16 sm:py-24 lg:py-32">
          <div class="text-center">
            <h1 class="text-4xl tracking-tight font-extrabold sm:text-5xl md:text-6xl">
              <span class="block">Creative Insights</span>
              <span class="block text-purple-400">Stories and Resources</span>
            </h1>
            <p class="mt-3 text-lg text-gray-300 sm:mt-5 sm:text-xl max-w-3xl mx-auto">
              Stories, tips, and resources for Apostolic creatives and churches
            </p>
          </div>
        </div>
      </div>
    </div>

    <!-- Featured Post -->
    <div class="relative py-24">
      <div class="max-w-[1280px] mx-auto px-4 sm:px-6 lg:px-8">
        <div class="relative lg:grid lg:grid-cols-7 lg:gap-8">
          <div class="lg:col-span-4">
            <img class="w-full rounded-2xl shadow-lg object-cover" src="https://images.unsplash.com/photo-1516450360452-9312f5e86fc7?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1950&q=80" alt="Featured blog post" style="height: 400px;" />
          </div>
          <div class="mt-8 lg:mt-0 lg:col-span-3">
            <div class="flex items-center text-sm text-gray-500">
              <time datetime="2024-03-16">March 16, 2024</time>
              <span class="mx-1">&middot;</span>
              <span>8 min read</span>
            </div>
            <a href="#" class="block mt-2">
              <h2 class="text-3xl font-extrabold text-gray-900">
                The Evolution of Church Media Ministry
              </h2>
              <p class="mt-4 text-lg text-gray-500">
                Exploring how modern churches are leveraging technology and creative talent to enhance their ministry impact and reach more people with the Gospel.
              </p>
            </a>
            <div class="mt-6">
              <router-link to="/blog/evolution-church-media" class="text-purple-600 hover:text-purple-700 font-medium">
                Read full story
                <span aria-hidden="true"> &rarr;</span>
              </router-link>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Blog Grid -->
    <div class="">
      <div class="max-w-[1280px] mx-auto px-4 sm:px-6 lg:px-8">
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          <!-- Blog Post 1 -->
          <div class="bg-white rounded-2xl shadow-sm overflow-hidden hover:shadow-lg transition-shadow">
            <div class="relative h-48">
              <img src="https://images.unsplash.com/photo-1581091226825-a6a2a5aee158?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1950&q=80" alt="Blog post" class="w-full h-full object-cover">
            </div>
            <div class="p-6">
              <div class="text-sm text-gray-500 mb-2">March 10, 2024</div>
              <h3 class="text-xl font-semibold text-gray-900 mb-3">Tips for Building an Effective Church Media Team</h3>
              <p class="text-gray-600 mb-4">Learn how to recruit, train, and manage a volunteer media team that can handle your church's creative needs.</p>
              <a href="#" class="text-purple-600 hover:text-purple-700 font-medium">Read more →</a>
            </div>
          </div>

          <!-- Blog Post 2 -->
          <div class="bg-white rounded-2xl shadow-sm overflow-hidden hover:shadow-lg transition-shadow">
            <div class="relative h-48">
              <img src="https://images.unsplash.com/photo-1524758631624-e2822e304c36?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1950&q=80" alt="Blog post" class="w-full h-full object-cover">
            </div>
            <div class="p-6">
              <div class="text-sm text-gray-500 mb-2">March 8, 2024</div>
              <h3 class="text-xl font-semibold text-gray-900 mb-3">Designing Sacred Spaces</h3>
              <p class="text-gray-600 mb-4">A guide to creating meaningful and impactful church environments through thoughtful design and architecture.</p>
              <a href="#" class="text-purple-600 hover:text-purple-700 font-medium">Read more →</a>
            </div>
          </div>

          <!-- Blog Post 3 -->
          <div class="bg-white rounded-2xl shadow-sm overflow-hidden hover:shadow-lg transition-shadow">
            <div class="relative h-48">
              <img src="https://images.unsplash.com/photo-1516450360452-9312f5e86fc7?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1950&q=80" alt="Blog post" class="w-full h-full object-cover">
            </div>
            <div class="p-6">
              <div class="text-sm text-gray-500 mb-2">March 5, 2024</div>
              <h3 class="text-xl font-semibold text-gray-900 mb-3">The Future of Church Tech</h3>
              <p class="text-gray-600 mb-4">Exploring emerging technologies and how they're shaping the future of worship and community engagement.</p>
              <a href="#" class="text-purple-600 hover:text-purple-700 font-medium">Read more →</a>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Load More Button -->
    <div class="mt-12 text-center pb-24">
      <button class="inline-flex items-center px-8 py-3 border border-transparent text-base font-medium rounded-lg text-white bg-gradient-to-r from-purple-800 to-pink-600 hover:opacity-90 transition-opacity md:text-lg">
        Load more articles
      </button>
    </div>

    <!-- Newsletter Section -->
    <div class="bg-gray-50">
      <div class="max-w-[1280px] mx-auto px-4 sm:px-6 lg:px-8 py-16 sm:py-24">
        <div class="relative rounded-2xl overflow-hidden bg-gradient-to-b from-[#1F2937] to-[#374151] py-16 sm:py-24 px-6 lg:px-8">
          <div class="relative">
            <div class="sm:text-center">
              <h2 class="text-3xl font-extrabold text-white tracking-tight sm:text-4xl">
                Get the latest creative insights
              </h2>
              <p class="mt-4 text-lg text-gray-300 max-w-2xl mx-auto">
                Sign up for our newsletter to receive tips, resources, and inspiration for your ministry.
              </p>
            </div>
            <form class="mt-8 sm:flex sm:justify-center">
              <div class="min-w-0 flex-1 max-w-lg mx-auto sm:mx-0">
                <label for="email" class="sr-only">Email address</label>
                <input 
                  id="email" 
                  type="email" 
                  class="block w-full px-4 py-3 text-base text-gray-900 placeholder-gray-500 border border-transparent rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-600 focus:border-purple-600" 
                  placeholder="Enter your email" 
                />
              </div>
              <div class="mt-4 sm:mt-0 sm:ml-3">
                <button 
                  type="submit" 
                  class="block w-full px-8 py-3 font-medium text-white bg-gradient-to-r from-purple-800 to-pink-600 border border-transparent rounded-lg shadow hover:opacity-90 focus:outline-none focus:ring-2 focus:ring-purple-600 focus:ring-offset-2 focus:ring-offset-gray-800 transition-opacity sm:px-10"
                >
                  Subscribe
                </button>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
// Component logic here
</script>