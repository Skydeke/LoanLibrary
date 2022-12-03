<template>
  <DetailedCarComponent :carmod="carmod"></DetailedCarComponent>
</template>

<script>

import axios from "axios";
import DetailedCarComponent from "@/components/DetailedCarComponent.vue";

export default {
  name: 'vehiclePage',
  components: {DetailedCarComponent},
  data() {
    return {id: '', carmod: {}}
  },
  created() {
    this.id = this.$route.params.id
    axios.get(this.$hostname + '/automodell/' + this.id).then(response => {
      this.carmod = response.data;
      axios.get(this.$hostname + '/automodell/ausstattungen/' + this.id).then(response => {
        this.carmod.ausstattung = response.data;
      }).catch(error => console.log(error))
    }).catch(error => console.log(error))
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>


</style>
  