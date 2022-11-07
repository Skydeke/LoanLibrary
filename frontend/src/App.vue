<template>
  <CarComponent></CarComponent>
</template>

<script>
import CarComponent from './components/CarComponent.vue'

export default {
  name: 'App',
  components: {
    CarComponent
  }
}
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
