<template>
  <footer class="bg-[#1F2937] text-white mt-auto">
    <div class="max-w-[1280px] mx-auto px-4 sm:px-6">
      <!-- Main Footer Content -->
      <div class="py-12 grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-8">
        <!-- Company Info -->
        <div class="space-y-4 text-center sm:text-left">
          <h3 class="text-lg font-bold">Apostolic Creatives</h3>
          <p class="text-gray-300 text-sm">
            Connecting apostolic churches with apostolic creatives and leaders. From musicians to ministry leaders, we’re building a trusted network that empowers both talent and churches to grow and succeed.
          </p>
          <div class="flex justify-center sm:justify-start space-x-4">
            <!-- Social Media Icons -->
            <a href="#" class="text-gray-300 hover:text-white">
              <svg class="h-6 w-6" fill="currentColor" viewBox="0 0 24 24">
                <path d="M24 12.073c0-6.627-5.373-12-12-12s-12 5.373-12 12c0 5.99 4.388 10.954 10.125 11.854v-8.385H7.078v-3.47h3.047V9.43c0-3.007 1.792-4.669 4.533-4.669 1.312 0 2.686.235 2.686.235v2.953H15.83c-1.491 0-1.956.925-1.956 1.874v2.25h3.328l-.532 3.47h-2.796v8.385C19.612 23.027 24 18.062 24 12.073z" />
              </svg>
            </a>
            <a href="#" class="text-gray-300 hover:text-white">
              <svg class="h-6 w-6" fill="currentColor" viewBox="0 0 24 24">
                <path d="M23.953 4.57a10 10 0 01-2.825.775 4.958 4.958 0 002.163-2.723c-.951.555-2.005.959-3.127 1.184a4.92 4.92 0 00-8.384 4.482C7.69 8.095 4.067 6.13 1.64 3.162a4.822 4.822 0 00-.666 2.475c0 1.71.87 3.213 2.188 4.096a4.904 4.904 0 01-2.228-.616v.06a4.923 4.923 0 003.946 4.827 4.996 4.996 0 01-2.212.085 4.936 4.936 0 004.604 3.417 9.867 9.867 0 01-6.102 2.105c-.39 0-.779-.023-1.17-.067a13.995 13.995 0 007.557 2.209c9.053 0 13.998-7.496 13.998-13.985 0-.21 0-.42-.015-.63A9.935 9.935 0 0024 4.59z" />
              </svg>
            </a>
            <a href="#" class="text-gray-300 hover:text-white">
              <svg class="h-6 w-6" fill="currentColor" viewBox="0 0 24 24">
                <path d="M12 0C5.373 0 0 5.373 0 12s5.373 12 12 12 12-5.373 12-12S18.627 0 12 0zm5.016 18.6h-2.472v-3.9c0-.923-.017-2.109-1.285-2.109-1.287 0-1.484 1.003-1.484 2.042v3.967H9.303V9.75h2.372v1.086h.033c.33-.627 1.137-1.287 2.34-1.287 2.504 0 2.968 1.648 2.968 3.791v4.26zm-10.5-10.02a1.434 1.434 0 11-.001-2.87 1.434 1.434 0 01.001 2.87zm1.237 10.02H5.28V9.75h2.473v8.85z" />
              </svg>
            </a>
            <a href="#" class="text-gray-300 hover:text-white">
              <svg class="h-6 w-6" fill="currentColor" viewBox="0 0 24 24">
                <path d="M12.017 0C5.396 0 .029 5.367.029 11.987c0 5.079 3.158 9.417 7.618 11.162-.105-.949-.199-2.403.041-3.439.219-.937 1.406-5.957 1.406-5.957s-.359-.72-.359-1.781c0-1.663.967-2.911 2.168-2.911 1.024 0 1.518.769 1.518 1.688 0 1.029-.653 2.567-.992 3.992-.285 1.193.6 2.165 1.775 2.165 2.128 0 3.768-2.245 3.768-5.487 0-2.861-2.063-4.869-5.008-4.869-3.41 0-5.409 2.562-5.409 5.199 0 1.033.394 2.143.889 2.741.099.12.112.225.085.345-.09.375-.293 1.199-.334 1.363-.053.225-.172.271-.401.165-1.495-.69-2.433-2.878-2.433-4.646 0-3.776 2.748-7.252 7.92-7.252 4.158 0 7.392 2.967 7.392 6.923 0 4.135-2.607 7.462-6.233 7.462-1.214 0-2.354-.629-2.758-1.379l-.749 2.848c-.269 1.045-1.004 2.352-1.498 3.146 1.123.345 2.306.535 3.55.535 6.607 0 11.985-5.365 11.985-11.987C23.97 5.39 18.592.026 11.985.026L12.017 0z" />
              </svg>
            </a>
          </div>
        </div>

        <!-- Quick Links -->
        <div class="space-y-4 text-center sm:text-left">
          <h3 class="text-lg font-bold">Quick Links</h3>
          <ul class="space-y-2">
            <li v-if="isAuthenticated"><router-link to="/dashboard" class="text-gray-300 hover:text-white text-sm">Dashboard</router-link></li>
            <li v-else><router-link to="/" class="text-gray-300 hover:text-white text-sm">Home</router-link></li>
            <li><router-link to="/about" class="text-gray-300 hover:text-white text-sm">About</router-link></li>
            <li><router-link to="/why-us" class="text-gray-300 hover:text-white text-sm">Why Us</router-link></li>
            <li><router-link to="/pricing" class="text-gray-300 hover:text-white text-sm">Pricing</router-link></li>
            <li><router-link to="/testimonials" class="text-gray-300 hover:text-white text-sm">Testimonials</router-link></li>
            <li><router-link to="/faq" class="text-gray-300 hover:text-white text-sm">FAQ</router-link></li>
          </ul>
        </div>

        <!-- Support -->
        <div class="space-y-4 text-center sm:text-left">
          <h3 class="text-lg font-bold">Support</h3>
          <ul class="space-y-2">
            <li><router-link to="/faq" class="text-gray-300 hover:text-white text-sm">Help Center</router-link></li>
            <li><router-link to="/contact" class="text-gray-300 hover:text-white text-sm">Contact Us</router-link></li>
            <li><a href="#" class="text-gray-300 hover:text-white text-sm">Privacy Policy</a></li>
            <li><a href="#" class="text-gray-300 hover:text-white text-sm">Terms of Service</a></li>
          </ul>
        </div>

        <!-- Newsletter -->
        <div class="space-y-4 text-center sm:text-left">
          <h3 class="text-lg font-bold">Stay Updated</h3>
          <p class="text-gray-300 text-sm">Subscribe to our newsletter for updates and opportunities.</p>
          <form @submit.prevent="subscribeNewsletter" class="space-y-2">
            <input type="email" placeholder="Enter your email" class="w-full px-4 py-2 bg-gray-800 text-white rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-600" />
            <button type="submit" class="w-full px-4 py-2 bg-gradient-to-r from-purple-800 to-pink-600 text-white rounded-lg hover:opacity-90 transition-opacity">
              Subscribe
            </button>
          </form>
        </div>
      </div>

      <!-- Bottom Bar -->
      <div class="border-t border-gray-800 py-6">
        <div class="flex flex-col items-center space-y-4 sm:space-y-0 sm:flex-row sm:justify-between">
          <p class="text-sm text-gray-400 text-center sm:text-left">
            &copy; {{ new Date().getFullYear() }} Apostolic Creatives. All rights reserved.
          </p>
          <div class="flex space-x-6">
            <a href="#" class="text-sm text-gray-400 hover:text-white">Privacy</a>
            <a href="#" class="text-sm text-gray-400 hover:text-white">Terms</a>
            <a href="#" class="text-sm text-gray-400 hover:text-white">Sitemap</a>
          </div>
        </div>
      </div>
    </div>
  </footer>
</template>

<script>
export default {
  name: 'AppFooter',
  props: {
    isAuthenticated: {
      type: Boolean,
      default: false
    }
  },
  methods: {
    subscribeNewsletter() {
      // Implement newsletter subscription logic
      console.log('Newsletter subscription');
    }
  }
}
</script>
