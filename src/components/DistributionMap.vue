<template>
  <div class="w-full h-full p-4">
    <div class="flex flex-wrap gap-4">
      <!-- West Coast - Largest region -->
      <div class="bg-gray-50 rounded-lg p-4 flex-grow basis-2/5">
        <h3 class="font-medium text-gray-700 mb-2">West Coast</h3>
        <div class="flex justify-between">
          <span class="flex items-center gap-2">
            <span class="w-2 h-2 bg-purple-500 rounded-full"></span>
            <span class="text-sm">45 Churches</span>
          </span>
          <span class="flex items-center gap-2">
            <span class="w-2 h-2 bg-blue-500 rounded-full"></span>
            <span class="text-sm">120 Creatives</span>
          </span>
        </div>
      </div>

      <!-- East Coast - Second largest -->
      <div class="bg-gray-50 rounded-lg p-4 flex-grow basis-1/3">
        <h3 class="font-medium text-gray-700 mb-2">East Coast</h3>
        <div class="flex justify-between">
          <span class="flex items-center gap-2">
            <span class="w-2 h-2 bg-purple-500 rounded-full"></span>
            <span class="text-sm">35 Churches</span>
          </span>
          <span class="flex items-center gap-2">
            <span class="w-2 h-2 bg-blue-500 rounded-full"></span>
            <span class="text-sm">90 Creatives</span>
          </span>
        </div>
      </div>

      <!-- Midwest -->
      <div class="bg-gray-50 rounded-lg p-4 flex-grow basis-1/4">
        <h3 class="font-medium text-gray-700 mb-2">Midwest</h3>
        <div class="flex justify-between">
          <span class="flex items-center gap-2">
            <span class="w-2 h-2 bg-purple-500 rounded-full"></span>
            <span class="text-sm">30 Churches</span>
          </span>
          <span class="flex items-center gap-2">
            <span class="w-2 h-2 bg-blue-500 rounded-full"></span>
            <span class="text-sm">80 Creatives</span>
          </span>
        </div>
      </div>

      <!-- South - Smallest region -->
      <div class="bg-gray-50 rounded-lg p-4 flex-grow basis-1/5">
        <h3 class="font-medium text-gray-700 mb-2">South</h3>
        <div class="flex justify-between">
          <span class="flex items-center gap-2">
            <span class="w-2 h-2 bg-purple-500 rounded-full"></span>
            <span class="text-sm">15 Churches</span>
          </span>
          <span class="flex items-center gap-2">
            <span class="w-2 h-2 bg-blue-500 rounded-full"></span>
            <span class="text-sm">30 Creatives</span>
          </span>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
defineProps({
  data: {
    type: Object,
    default: () => ({
      churches: 0,
      creatives: 0
    })
  }
})
</script>
