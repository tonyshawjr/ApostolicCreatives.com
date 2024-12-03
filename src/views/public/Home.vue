<template>
  <div class=" bg-white">
    <!-- Hero Section -->
    <div class="relative min-h-[60vh] bg-gradient-to-b from-[#1F2937] to-[#374151] text-white overflow-hidden">
      <!-- Background Image with Overlay -->
      <div class="absolute inset-0">
        <img 
          src="https://images.unsplash.com/photo-1517457373958-b7bdd4587205?ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80" 
          alt="Worship service" 
          class="w-full h-full object-cover animate-ken-burns"
        />
        <div class="absolute inset-0 bg-gradient-to-b from-gray-900/80 via-gray-900/70 to-gray-900/90"></div>
        <!-- Animated Geometric Background -->
        <div class="absolute inset-0 geometric-shapes mix-blend-soft-light">
          <div class="shape-1"></div>
          <div class="shape-2"></div>
          <div class="shape-3"></div>
          <div class="shape-4"></div>
        </div>
      </div>
      
      <div class="relative z-10 max-w-[1280px] mx-auto px-4 sm:px-6 lg:px-8 min-h-[60vh] flex items-center">
        <div class="w-full text-center max-w-3xl mx-auto py-16">
          <h1 class="text-4xl tracking-tight font-extrabold sm:text-5xl md:text-6xl">
            <span class="block animate-fade-in-up">Connecting Apostolic</span>
            <span class="block text-purple-400 animate-fade-in-up-delay">Creatives with Apostolic Churches</span>
          </h1>
          <p class="mt-6 text-xl text-gray-300 animate-fade-in-up-delay-2 max-w-2xl mx-auto">
            Apostolic Creatives is the premier platform designed to connect skilled creatives with churches that need their expertise. Whether you're looking to serve or searching for talent, we make the process simple, efficient, and aligned with apostolic values.
          </p>
          <div class="mt-10 flex flex-col sm:flex-row gap-4 justify-center items-center animate-fade-in-up-delay-3">
            <router-link to="/register" class="group w-full sm:w-auto inline-flex items-center justify-center px-8 py-4 border border-transparent text-lg font-semibold rounded-xl text-white bg-gradient-to-r from-purple-800 to-pink-600 hover:from-purple-700 hover:to-pink-500 transition-all duration-300">
              Join as a Creative
              <svg class="ml-3 h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 7l5 5m0 0l-5 5m5-5H6" />
              </svg>
            </router-link>
            <router-link to="/register" class="group w-full sm:w-auto inline-flex items-center justify-center px-8 py-4 border-2 border-white text-lg font-semibold rounded-xl text-white hover:bg-white hover:text-gray-900 transition-all duration-300">
              Hire a Creative
              <svg class="ml-3 h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 7l5 5m0 0l-5 5m5-5H6" />
              </svg>
            </router-link>
          </div>
        </div>
      </div>
    </div>

    <!-- For Creatives Section -->
    <div class="py-24 bg-white">
      <div class="max-w-[1280px] mx-auto px-4 sm:px-6 lg:px-8">
        <div class="lg:grid lg:grid-cols-12 lg:gap-16 items-center">
          <div class="lg:col-span-5 mb-12 lg:mb-0">
            <h2 class="text-4xl font-extrabold tracking-tight text-gray-900 sm:text-5xl mb-6">
              Share Your Ministry
            </h2>
            <p class="text-xl text-gray-600 mb-8">
              Your creative talents can make a real difference. Connect with churches that value your skills and share your apostolic vision.
            </p>

            <div class="space-y-6">
              <div class="flex items-start">
                <div class="flex-shrink-0 h-8 w-8">
                  <div class="h-8 w-8 rounded-lg bg-gradient-to-r from-purple-800 to-pink-600 flex items-center justify-center">
                    <svg class="h-5 w-5 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
                    </svg>
                  </div>
                </div>
                <div class="ml-4">
                  <h3 class="text-lg font-semibold text-gray-900">Professional Profile</h3>
                  <p class="mt-1 text-gray-600">Showcase your skills and experience with a verified creative profile.</p>
                </div>
              </div>

              <div class="flex items-start">
                <div class="flex-shrink-0 h-8 w-8">
                  <div class="h-8 w-8 rounded-lg bg-gradient-to-r from-purple-800 to-pink-600 flex items-center justify-center">
                    <svg class="h-5 w-5 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 13.255A23.931 23.931 0 0112 15c-3.183 0-6.22-.62-9-1.745M16 6V4a2 2 0 00-2-2h-4a2 2 0 00-2 2v2m4 6h.01M5 20h14a2 2 0 002-2V8a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" />
                    </svg>
                  </div>
                </div>
                <div class="ml-4">
                  <h3 class="text-lg font-semibold text-gray-900">Tailored Opportunities</h3>
                  <p class="mt-1 text-gray-600">Find roles that match your skills, from music to media production.</p>
                </div>
              </div>

              <div class="flex items-start">
                <div class="flex-shrink-0 h-8 w-8">
                  <div class="h-8 w-8 rounded-lg bg-gradient-to-r from-purple-800 to-pink-600 flex items-center justify-center">
                    <svg class="h-5 w-5 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z" />
                    </svg>
                  </div>
                </div>
                <div class="ml-4">
                  <h3 class="text-lg font-semibold text-gray-900">Pastor Verification</h3>
                  <p class="mt-1 text-gray-600">Stand out with pastoral approval that builds trust with churches.</p>
                </div>
              </div>

              <div class="flex items-start">
                <div class="flex-shrink-0 h-8 w-8">
                  <div class="h-8 w-8 rounded-lg bg-gradient-to-r from-purple-800 to-pink-600 flex items-center justify-center">
                    <svg class="h-5 w-5 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                    </svg>
                  </div>
                </div>
                <div class="ml-4">
                  <h3 class="text-lg font-semibold text-gray-900">Always Free</h3>
                  <p class="mt-1 text-gray-600">No cost to join, create your profile, or apply to opportunities.</p>
                </div>
              </div>
            </div>

            <div class="mt-10">
              <router-link
                to="/register"
                class="inline-flex items-center px-8 py-4 border border-transparent text-lg font-semibold rounded-xl text-white bg-gradient-to-r from-purple-800 to-pink-600 hover:from-purple-700 hover:to-pink-500 transition-all duration-300"
              >
                Create Your Free Profile
                <svg class="ml-3 h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 7l5 5m0 0l-5 5m5-5H6" />
                </svg>
              </router-link>
            </div>
          </div>

          <div class="lg:col-span-7 relative">
            <div class="relative rounded-2xl overflow-hidden h-[600px]">
              <img 
                class="w-full h-full object-cover" 
                src="https://images.unsplash.com/photo-1517457373958-b7bdd4587205?ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80" 
                alt="Worship service" 
              />
              <div class="absolute inset-0 bg-gradient-to-t from-gray-900/50 to-transparent"></div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- For Churches Section -->
    <div class="py-24 bg-gray-50">
      <div class="max-w-[1280px] mx-auto px-4 sm:px-6 lg:px-8">
        <div class="lg:grid lg:grid-cols-12 lg:gap-16 items-center">
          <div class="lg:col-span-7 relative mb-12 lg:mb-0">
            <div class="relative rounded-2xl overflow-hidden h-[600px]">
              <img 
                class="w-full h-full object-cover" 
                src="https://images.unsplash.com/photo-1438232992991-995b7058bbb3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1950&q=80" 
                alt="Church worship service" 
              />
              <div class="absolute inset-0 bg-gradient-to-t from-gray-900/50 to-transparent"></div>
            </div>
          </div>

          <div class="lg:col-span-5">
            <h2 class="text-4xl font-extrabold tracking-tight text-gray-900 sm:text-5xl mb-6">
              Find the Perfect Fit
            </h2>
            <p class="text-xl text-gray-600 mb-8">
              From worship leaders to sound engineers, connect with skilled individuals who understand your ministry's vision.
            </p>

            <div class="space-y-6">
              <div class="flex items-start">
                <div class="flex-shrink-0 h-8 w-8">
                  <div class="h-8 w-8 rounded-lg bg-gradient-to-r from-purple-800 to-pink-600 flex items-center justify-center">
                    <svg class="h-5 w-5 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                    </svg>
                  </div>
                </div>
                <div class="ml-4">
                  <h3 class="text-lg font-semibold text-gray-900">Verified Creatives</h3>
                  <p class="mt-1 text-gray-600">Browse a directory of pastor-approved creatives ready to serve.</p>
                </div>
              </div>

              <div class="flex items-start">
                <div class="flex-shrink-0 h-8 w-8">
                  <div class="h-8 w-8 rounded-lg bg-gradient-to-r from-purple-800 to-pink-600 flex items-center justify-center">
                    <svg class="h-5 w-5 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z" />
                    </svg>
                  </div>
                </div>
                <div class="ml-4">
                  <h3 class="text-lg font-semibold text-gray-900">Easy Job Posting</h3>
                  <p class="mt-1 text-gray-600">Share your ministry's needs and reach passionate, skilled individuals.</p>
                </div>
              </div>

              <div class="flex items-start">
                <div class="flex-shrink-0 h-8 w-8">
                  <div class="h-8 w-8 rounded-lg bg-gradient-to-r from-purple-800 to-pink-600 flex items-center justify-center">
                    <svg class="h-5 w-5 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                    </svg>
                  </div>
                </div>
                <div class="ml-4">
                  <h3 class="text-lg font-semibold text-gray-900">Affordable Plans</h3>
                  <div class="mt-1 text-gray-600">
                    <p class="mb-1">• Small Ministries (under 150): $29/month</p>
                    <p>• Larger Ministries: $99/month</p>
                  </div>
                </div>
              </div>
            </div>

            <div class="mt-10">
              <router-link
                to="/register"
                class="inline-flex items-center px-8 py-4 border border-transparent text-lg font-semibold rounded-xl text-white bg-gradient-to-r from-purple-800 to-pink-600 hover:from-purple-700 hover:to-pink-500 transition-all duration-300"
              >
                Post Your First Job
                <svg class="ml-3 h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 7l5 5m0 0l-5 5m5-5H6" />
                </svg>
              </router-link>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Why Choose Section -->
    <div class="py-24 bg-white">
      <div class="max-w-[1280px] mx-auto px-4 sm:px-6 lg:px-8">
        <div class="text-center max-w-3xl mx-auto">
          <h2 class="text-3xl font-extrabold tracking-tight text-gray-900 sm:text-4xl">
            Why Choose Apostolic Creatives?
          </h2>
          <p class="mt-4 text-lg text-gray-500">
            This isn't just another job board—it's a platform specifically designed for the unique needs of apostolic creatives and churches.
          </p>
        </div>
        <div class="mt-16 grid gap-8 md:grid-cols-2 lg:grid-cols-4">
          <div class="relative p-6 bg-white rounded-2xl hover:shadow-lg transition-shadow duration-300">
            <div class="absolute -top-4 left-4">
              <div class="rounded-lg bg-gradient-to-r from-purple-800 to-pink-600 p-3 text-white">
                <svg class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6" />
                </svg>
              </div>
            </div>
            <h3 class="mt-8 text-lg font-semibold text-gray-900">Built for Apostolic Ministries</h3>
            <p class="mt-2 text-base text-gray-500">
              A platform specifically designed for the unique needs of apostolic creatives and churches.
            </p>
          </div>

          <div class="relative p-6 bg-white rounded-2xl hover:shadow-lg transition-shadow duration-300">
            <div class="absolute -top-4 left-4">
              <div class="rounded-lg bg-gradient-to-r from-purple-800 to-pink-600 p-3 text-white">
                <svg class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z" />
                </svg>
              </div>
            </div>
            <h3 class="mt-8 text-lg font-semibold text-gray-900">Pastor Verification</h3>
            <p class="mt-2 text-base text-gray-500">
              Trust that every creative is backed by pastoral approval for credibility and integrity.
            </p>
          </div>

          <div class="relative p-6 bg-white rounded-2xl hover:shadow-lg transition-shadow duration-300">
            <div class="absolute -top-4 left-4">
              <div class="rounded-lg bg-gradient-to-r from-purple-800 to-pink-600 p-3 text-white">
                <svg class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z" />
                </svg>
              </div>
            </div>
            <h3 class="mt-8 text-lg font-semibold text-gray-900">Effortless Connections</h3>
            <p class="mt-2 text-base text-gray-500">
              Whether you're applying or hiring, our tools make the process simple and effective.
            </p>
          </div>

          <div class="relative p-6 bg-white rounded-2xl hover:shadow-lg transition-shadow duration-300">
            <div class="absolute -top-4 left-4">
              <div class="rounded-lg bg-gradient-to-r from-purple-800 to-pink-600 p-3 text-white">
                <svg class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z" />
                </svg>
              </div>
            </div>
            <h3 class="mt-8 text-lg font-semibold text-gray-900">Community-Driven</h3>
            <p class="mt-2 text-base text-gray-500">
              Join a network of apostolic individuals and ministries working together to make an impact.
            </p>
          </div>
        </div>
      </div>
    </div>

    <!-- Platform with Purpose Section -->
    <div class="py-24 bg-gradient-to-r from-purple-800 to-pink-600 text-white relative overflow-hidden">
      <div class="absolute inset-0 geometric-shapes mix-blend-soft-light">
        <div class="shape-1"></div>
        <div class="shape-2"></div>
        <div class="shape-3"></div>
        <div class="shape-4"></div>
      </div>
      <div class="max-w-[1280px] mx-auto px-4 sm:px-6 lg:px-8 relative z-10">
        <div class="text-center max-w-3xl mx-auto">
          <h2 class="text-3xl font-extrabold sm:text-4xl">
            A Platform with Purpose
          </h2>
          <p class="mt-6 text-xl text-gray-100">
            Apostolic Creatives bridges the gap between creative talent and ministry needs, enabling both to grow and succeed. Our mission is to make finding and hiring the right people seamless so that churches and creatives can focus on their work in the Kingdom.
          </p>
          <div class="mt-10">
            <router-link
              to="/register"
              class="group inline-flex items-center px-8 py-4 border-2 border-white text-lg font-semibold rounded-xl text-white hover:bg-white hover:text-gray-900 transition-all duration-300"
            >
              Get Started Today
              <svg class="ml-3 h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 7l5 5m0 0l-5 5m5-5H6" />
              </svg>
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

<style>
.animate-fade-in-up {
  animation: fadeInUp 0.6s ease-out;
}

.animate-fade-in-up-delay {
  animation: fadeInUp 0.6s ease-out 0.2s both;
}

.animate-fade-in-up-delay-2 {
  animation: fadeInUp 0.6s ease-out 0.4s both;
}

.animate-fade-in-up-delay-3 {
  animation: fadeInUp 0.6s ease-out 0.6s both;
}

@keyframes fadeInUp {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

/* Ken Burns effect for hero image */
.animate-ken-burns {
  animation: ken-burns 20s ease-in-out infinite alternate;
  transform-origin: center;
}

@keyframes ken-burns {
  from {
    transform: scale(1);
  }
  to {
    transform: scale(1.1);
  }
}

/* Geometric shapes */
.geometric-shapes {
  overflow: hidden;
  opacity: 0.15;
}

.shape-1, .shape-2, .shape-3, .shape-4 {
  position: absolute;
  background: linear-gradient(45deg, #8B5CF6, #EC4899);
  border-radius: 30% 70% 70% 30% / 30% 30% 70% 70%;
  mix-blend-mode: overlay;
}

.shape-1 {
  top: -15%;
  right: -15%;
  width: 60%;
  height: 60%;
  animation: morph1 15s linear infinite;
}

.shape-2 {
  top: 40%;
  left: -15%;
  width: 40%;
  height: 40%;
  animation: morph2 18s linear infinite;
}

.shape-3 {
  bottom: -15%;
  right: 20%;
  width: 50%;
  height: 50%;
  animation: morph3 20s linear infinite;
}

.shape-4 {
  top: 20%;
  right: 30%;
  width: 30%;
  height: 30%;
  animation: morph4 22s linear infinite;
}

@keyframes morph1 {
  0%, 100% {
    border-radius: 30% 70% 70% 30% / 30% 30% 70% 70%;
    transform: rotate(0deg);
  }
  50% {
    border-radius: 70% 30% 30% 70% / 70% 70% 30% 30%;
    transform: rotate(180deg);
  }
}

@keyframes morph2 {
  0%, 100% {
    border-radius: 70% 30% 30% 70% / 70% 70% 30% 30%;
    transform: rotate(0deg);
  }
  50% {
    border-radius: 30% 70% 70% 30% / 30% 30% 70% 70%;
    transform: rotate(-180deg);
  }
}

@keyframes morph3 {
  0%, 100% {
    border-radius: 40% 60% 60% 40% / 40% 40% 60% 60%;
    transform: rotate(0deg);
  }
  50% {
    border-radius: 60% 40% 40% 60% / 60% 60% 40% 40%;
    transform: rotate(180deg);
  }
}

@keyframes morph4 {
  0%, 100% {
    border-radius: 60% 40% 40% 60% / 60% 60% 40% 40%;
    transform: rotate(0deg);
  }
  50% {
    border-radius: 40% 60% 60% 40% / 40% 40% 60% 60%;
    transform: rotate(-180deg);
  }
}

.hero-image-pulse {
  animation: pulse 4s ease-in-out infinite;
}

@keyframes pulse {
  0%, 100% {
    transform: scale(1);
  }
  50% {
    transform: scale(1.05);
  }
}
</style>