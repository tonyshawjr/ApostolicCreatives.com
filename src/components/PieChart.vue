<template>
  <div class="chart-container">
    <canvas ref="canvas"></canvas>
  </div>
</template>

<script setup>
import { ref, onMounted, watch } from 'vue'
import { Chart, registerables } from 'chart.js'

Chart.register(...registerables)

const props = defineProps({
  data: Object
})

const canvas = ref(null)
let chart = null

onMounted(() => {
  chart = new Chart(canvas.value, {
    type: 'pie',
    data: props.data,
    options: {
      responsive: true,
      maintainAspectRatio: false,
      plugins: {
        legend: {
          position: 'bottom',
          labels: {
            usePointStyle: true,
            padding: 20,
            font: {
              size: 12,
              family: "'Inter', sans-serif"
            }
          }
        }
      },
      elements: {
        arc: {
          borderWidth: 0
        }
      }
    }
  })
})

// Update chart when data changes
watch(() => props.data, (newData) => {
  if (chart) {
    chart.data = newData
    chart.update()
  }
}, { deep: true })
</script>

<style scoped>
.chart-container {
  position: relative;
  width: 100%;
  height: 300px;
}
canvas {
  width: 100% !important;
  height: 100% !important;
}
</style>
