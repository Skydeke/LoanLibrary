<template>
  <aside>
    <div v-for="type in cars" :key="type.type">
      <div class="linkWrapper">
        <router-link :to="'/#' + type.type"> {{ type.type }} </router-link>
      </div>
    </div>
  </aside>
</template>

<script>
import axios from 'axios'

export default {
  name: 'SidebarComponent',
  data() {
    return { cars: [] }
  },
  mounted() {
    axios
      .get(this.$hostname + '/automodells')
      .then((response) => {
        this.cars = response.data
      })
      .catch((error) => console.log(error))
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
aside {
  top: 14%;
  left: 1%;
  width: 8%;
  height: 85%;
  text-align: center;
  position: fixed;
  border: solid 2px black;
  border-radius: 15px;
}
.linkWrapper {
  height: 20px;
  margin: 5px;
  display: block;
}
a {
  color: black;
  text-decoration: none;
  font-style: normal;
}
</style>
