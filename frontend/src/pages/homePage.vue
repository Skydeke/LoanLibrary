<template>
  <div
    v-for="type in cars"
    :id="type.type"
    :key="type.type"
    class="classWrapper"
  >
    <h1>{{ type.type }}</h1>
    <div v-for="car in type.values" :key="car.Hersteller" class="carWrapper">
      <CarComponent :car="car"></CarComponent>
    </div>
    <hr />
  </div>
</template>

<script>
import CarComponent from '../components/CarComponent.vue'
import axios from 'axios'

export default {
  name: 'HomePage',
  components: { CarComponent },
  data () {
    return { cars: [] }
  },
  mounted () {
    axios
      .get(this.$hostname + '/automodells')
      .then((response) => {
        this.cars = response.data
      })
      .catch((error) => console.log(error))
  },
  updated () {
    if (this.$route.hash) {
      this.$scrollTo(this.$route.hash, 500, {
        easing: 'ease-in-out',
        offset: -150
      })
    } // offset becuase of the navbar
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h1 {
  text-align: center;
}

.carWrapper {
  display: inline-block;
  margin-left: 1%;
  margin-right: 1%;
}

.classWrapper {
  margin-left: 10%;
  margin-right: 10%;
  width: 80%;
}

hr {
  border-top: 2px solid black;
}
</style>
