<template>
    <h1> {{id}}</h1>
</template>
  
  <script>  
  
  export default {
    name: 'vehiclePage',
    data(){
        return {id:''}
    },
    created(){
        this.id= this.$route.params.id
    }
  }
  </script>
  
  <!-- Add "scoped" attribute to limit CSS to this component only -->
  <style scoped>
    
  
  </style>
  