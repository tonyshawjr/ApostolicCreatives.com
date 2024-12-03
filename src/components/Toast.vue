<template>
  <div class="fixed bottom-0 right-0 p-4 z-50">
    <TransitionGroup name="toast">
      <div
        v-for="toast in toasts"
        :key="toast.id"
        class="mb-2 p-4 rounded-lg shadow-lg max-w-sm"
        :class="toastClasses(toast.type)"
      >
        <div class="flex items-center">
          <component
            :is="toastIcon(toast.type)"
            class="h-5 w-5 mr-3"
            :class="iconClasses(toast.type)"
          />
          <p class="text-sm font-medium">{{ toast.message }}</p>
        </div>
      </div>
    </TransitionGroup>
  </div>
</template>

<script setup>
import { useToast } from '@/composables/useToast'
import {
  CheckCircleIcon,
  ExclamationCircleIcon,
  InformationCircleIcon,
  ExclamationTriangleIcon
} from '@heroicons/vue/24/solid'

const { toasts } = useToast()

function toastClasses(type) {
  switch (type) {
    case 'success':
      return 'bg-green-50 text-green-800'
    case 'error':
      return 'bg-red-50 text-red-800'
    case 'warning':
      return 'bg-yellow-50 text-yellow-800'
    case 'info':
      return 'bg-blue-50 text-blue-800'
    default:
      return 'bg-gray-50 text-gray-800'
  }
}

function iconClasses(type) {
  switch (type) {
    case 'success':
      return 'text-green-400'
    case 'error':
      return 'text-red-400'
    case 'warning':
      return 'text-yellow-400'
    case 'info':
      return 'text-blue-400'
    default:
      return 'text-gray-400'
  }
}

function toastIcon(type) {
  switch (type) {
    case 'success':
      return CheckCircleIcon
    case 'error':
      return ExclamationCircleIcon
    case 'warning':
      return ExclamationTriangleIcon
    case 'info':
      return InformationCircleIcon
    default:
      return InformationCircleIcon
  }
}
</script>

<style scoped>
.toast-enter-active,
.toast-leave-active {
  transition: all 0.3s ease;
}

.toast-enter-from {
  opacity: 0;
  transform: translateX(30px);
}

.toast-leave-to {
  opacity: 0;
  transform: translateX(30px);
}
</style>
