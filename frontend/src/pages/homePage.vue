<template>
  <CarComponent></CarComponent>
</template>

<script>
import CarComponent from '../components/CarComponent.vue'
export default {
  name: 'homePage',
  components: {CarComponent},
  data :()=>{
      return { name : "world"}
  }		
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>

</style>