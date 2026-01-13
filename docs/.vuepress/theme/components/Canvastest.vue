<template>
  <h1>窗口展示</h1>
  <canvas
  ref="canvasRef"
  width="500"
  height="400"
  style="border: 1px solid #ccc; background: #f9f9f9; cursor: pointer;"
  @click="handleClick">
  </canvas>
</template>

<script setup>
import { ref, onMounted } from 'vue'

const canvasRef = ref(null)
let ctx = null

onMounted(() => {
  const canvas = canvasRef.value
  if(canvas) {
    ctx = canvas.getContext("2d")
  }
})

const handleClick = (event) => {
const rect = canvasRef.value.getBoundingClientRect()
const x = event.clientX - rect.left
const y = event.clientY - rect.top
const color = 'hsl(${Math.random() * 360}, 70%, 60%)'

ctx.beginPath()
ctx.arc(x,y,20,0,Math.PI*2)
ctx.fillStyle = color
ctx.fill()
}

</script>