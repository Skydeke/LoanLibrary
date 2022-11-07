<template>
  <LoginComponent></LoginComponent>
</template>

<script>
import LoginComponent from '../components/LoginComponent.vue'
export default {
  name: 'loginPage',
  components:{LoginComponent},
  data :()=>{
      return { name : "world"}
  }		
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>

</style>