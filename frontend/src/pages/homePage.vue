<template>
  <div class="classWrapper">
    <h1> SUVs</h1>
    <div class="carWrapper" v-for="car in suvs" :key="car">
        <CarComponent :vehicle_name="car" :image_src="this.$hostname + '/image/car.jpg'"></CarComponent>
    </div>
  </div>
  <hr>
  <div class="classWrapper">
    <h1> Kleinwagen</h1>
    <div class="carWrapper" v-for="car in compact_car" :key="car">
        <CarComponent :vehicle_name="car" :image_src="this.$hostname + '/image/car2.jpg'"></CarComponent>
    </div>
  </div>
</template>

<script>
import CarComponent from '../components/CarComponent.vue'
export default {
  name: 'homePage',
  components: {CarComponent},
  data (){
      return { suvs:['Mercedes G Klasse','Subaru Crosstrek','Hyundai Kona','Ford Bronco Sport','Mazda CX-5','Hyundai Tucson','Kia Seltos','Ford Escape'],
      compact_car:['Dacia Spring','Opel Mokka-e','Opel Corsa-e','Renault ZOE','Fiat 500 Elektro','Renault Twingo Electric','Dacia Sandero','Peugeot e-208']}
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