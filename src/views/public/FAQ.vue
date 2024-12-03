<template>
  <div class=" bg-white">
    <!-- Hero section -->
    <div class="relative overflow-hidden bg-gradient-to-b from-[#1F2937] to-[#374151] text-white">
      <div class="max-w-[1280px] mx-auto px-4 sm:px-6 lg:px-8">
        <div class="relative z-10 py-16 sm:py-24 lg:py-32">
          <div class="text-center">
            <h1 class="text-4xl tracking-tight font-extrabold sm:text-5xl md:text-6xl">
              <span class="block">Frequently Asked Questions</span>
              <span class="block text-purple-400">Find Quick Answers</span>
            </h1>
            <p class="mt-3 text-lg text-gray-300 sm:mt-5 sm:text-xl max-w-3xl mx-auto">
              Get answers to common questions about our platform, services, and how we can help you succeed.
            </p>
          </div>
        </div>
      </div>
    </div>

    <!-- FAQ Content -->
    <div class="py-24">
      <div class="max-w-[1280px] mx-auto px-4 sm:px-6 lg:px-8">
        <div class="grid lg:grid-cols-4 gap-8">
          <!-- Left sidebar with categories -->
          <div class="lg:col-span-1">
            <nav class="space-y-2" aria-label="FAQ Categories">
              <button 
                v-for="(category, index) in categories" 
                :key="index"
                @click="activeCategory = category.id"
                :class="[
                  activeCategory === category.id 
                    ? 'bg-gradient-to-r from-purple-800 to-pink-600 text-white' 
                    : 'text-gray-600 hover:text-gray-900 hover:bg-gray-50',
                  'w-full px-4 py-3 text-left text-base font-medium rounded-lg transition-colors'
                ]"
              >
                {{ category.name }}
              </button>
            </nav>

            <!-- Contact Support Card -->
            <div class="mt-8 rounded-2xl bg-gradient-to-b from-[#1F2937] to-[#374151] p-6 text-white">
              <h3 class="text-lg font-semibold">Need more help?</h3>
              <p class="mt-2 text-sm text-gray-300">
                Can't find what you're looking for? Our support team is here to help.
              </p>
              <router-link
                to="/contact"
                class="mt-4 inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-lg text-white bg-gradient-to-r from-purple-800 to-pink-600 hover:opacity-90 transition-opacity"
              >
                Contact Support
              </router-link>
            </div>
          </div>

          <!-- Right side FAQ accordion -->
          <div class="lg:col-span-3">
            <div class="space-y-6">
              <div v-for="(section, sectionIndex) in filteredQuestions" :key="sectionIndex">
                <h2 class="text-2xl font-bold text-gray-900 mb-6">{{ section.category }}</h2>
                <div class="space-y-4">
                  <div 
                    v-for="(item, itemIndex) in section.questions" 
                    :key="itemIndex"
                    class="border border-gray-200 rounded-lg overflow-hidden"
                  >
                    <button
                      @click="toggleQuestion(sectionIndex, itemIndex)"
                      class="w-full px-6 py-4 text-left flex justify-between items-center hover:bg-gray-50"
                      :aria-expanded="item.isOpen"
                    >
                      <span class="text-base font-medium text-gray-900">{{ item.question }}</span>
                      <span 
                        class="ml-6 flex-shrink-0 text-purple-600"
                        :class="{ 'rotate-180': item.isOpen }"
                      >
                        <svg class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
                        </svg>
                      </span>
                    </button>
                    <div 
                      v-show="item.isOpen"
                      class="px-6 py-4 bg-gray-50"
                    >
                      <p class="text-base text-gray-500">{{ item.answer }}</p>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- CTA Section -->
    <div class="bg-gray-50">
      <div class="max-w-[1280px] mx-auto px-4 sm:px-6 lg:px-8 py-16 sm:py-24">
        <div class="relative rounded-2xl overflow-hidden bg-gradient-to-b from-[#1F2937] to-[#374151] py-16 sm:py-24 px-6 lg:px-8">
          <div class="relative">
            <div class="sm:text-center">
              <h2 class="text-3xl font-extrabold text-white tracking-tight sm:text-4xl">
                Ready to Get Started?
              </h2>
              <p class="mt-4 text-lg text-gray-300 max-w-2xl mx-auto">
                Join our community of Apostolic creatives and churches. Create your profile or post your first opportunity today.
              </p>
              <div class="mt-8 flex justify-center gap-4">
                <router-link
                  to="/register"
                  class="inline-flex items-center px-8 py-3 border border-transparent text-base font-medium rounded-lg text-white bg-gradient-to-r from-purple-800 to-pink-600 hover:opacity-90 transition-opacity md:text-lg"
                >
                  Create Account
                </router-link>
                <router-link
                  to="/contact"
                  class="inline-flex items-center px-8 py-3 border-2 border-white text-base font-medium rounded-lg text-white hover:bg-white hover:text-gray-900 transition-colors md:text-lg"
                >
                  Contact Us
                </router-link>
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

const activeCategory = ref('all')

const categories = [
  { id: 'all', name: 'All Questions' },
  { id: 'creatives', name: 'For Creatives' },
  { id: 'churches', name: 'For Churches' },
  { id: 'platform', name: 'Platform & Security' }
]

const faqData = ref([
  {
    category: 'For Creatives',
    id: 'creatives',
    questions: [
      {
        question: 'How do I create a profile?',
        answer: 'Sign up for an account, complete your profile with your skills, experience, and portfolio. Your profile will be reviewed and verified before being made public.',
        isOpen: false
      },
      {
        question: 'How much does it cost?',
        answer: 'Creating a profile is free. You can enhance your visibility with our premium features available through subscription plans.',
        isOpen: false
      },
      {
        question: 'How do I apply for jobs?',
        answer: 'Browse available opportunities and submit your application directly through our platform. You can track all your applications in your dashboard.',
        isOpen: false
      }
    ]
  },
  {
    category: 'For Churches',
    id: 'churches',
    questions: [
      {
        question: 'How do I post a job?',
        answer: 'Create an account, verify your church, and post your creative position. You can specify requirements, compensation, and other details.',
        isOpen: false
      },
      {
        question: 'What are the costs involved?',
        answer: 'We offer various subscription plans for churches. View our pricing page for detailed information about features and costs.',
        isOpen: false
      },
      {
        question: 'How are creatives verified?',
        answer: 'All creatives go through a verification process that includes portfolio review and pastoral reference checks to ensure they align with Apostolic values.',
        isOpen: false
      }
    ]
  },
  {
    category: 'Platform & Security',
    id: 'platform',
    questions: [
      {
        question: 'How secure is my information?',
        answer: 'We use industry-standard security measures to protect your data. All sensitive information is encrypted and securely stored.',
        isOpen: false
      },
      {
        question: 'What support do you offer?',
        answer: 'We provide email support, help documentation, and resources to help you make the most of our platform.',
        isOpen: false
      }
    ]
  }
])

const filteredQuestions = computed(() => {
  if (activeCategory.value === 'all') {
    return faqData.value
  }
  return faqData.value.filter(section => section.id === activeCategory.value)
})

const toggleQuestion = (sectionIndex, itemIndex) => {
  faqData.value[sectionIndex].questions[itemIndex].isOpen = 
    !faqData.value[sectionIndex].questions[itemIndex].isOpen
}
</script>
