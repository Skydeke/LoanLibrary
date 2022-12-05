<template>
  <div class="classWrapper" v-for="type in cars" :key="type.type">
    <h1> {{type.type}}</h1>
    <div class="carWrapper" v-for="car in type.values" :key="car.Hersteller">
        <CarComponent :car="car"></CarComponent>
    </div>
    <hr>
  </div>
</template>

<script>
import CarComponent from '../components/CarComponent.vue'
import axios from 'axios'

export default {
  name: 'homePage',
  components: {CarComponent},
  data (){
      return {cars:[]}
  },mounted(){
      axios.get(this.$hostname + '/automodells')
      .then(response =>{
         this.cars = response.data;
         console.log(response.data);
      })
      .catch(error => console.log(error))
  }		
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
   h1{
    text-align: center;
   }
   .carWrapper{
    display: inline-block;
   }
   .classWrapper{
    margin-left: 10%;
    margin-right: 10%;
    width: 80%;
   }
   hr{
    border-top: 2px solid black;
   }
</style>