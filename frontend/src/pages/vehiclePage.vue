<template>
    <h1> {{vehicle_name}}</h1>
</template>
  
  <script>  
  
  export default {
    name: 'vehiclePage',
    data(){
        return {vehicle_name:''}
    },
    created(){
        this.vehicle_name = this.$route.params.vehicle_name
    }
  }
  </script>
  
  <!-- Add "scoped" attribute to limit CSS to this component only -->
  <style scoped>
    
  
  </style>
  