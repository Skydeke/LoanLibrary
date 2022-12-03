<template>
  <DetailedCarComponent :carmod="carmod"></DetailedCarComponent>
  <div id="resCont">
    <h2>Reservierung</h2>
    <p>
      Bei unserem Autoverleih ist es nicht möglich ein konkretes Auto zu reservieren, aber man kann ein
      Automodell für ein bestimmten Zeitraum reservieren. Eine Reservierung ist kostenlos und muss nicht zwangsläufig
      zu einem Leihvertrag führen.
      <br>
      Um ein Auto dieses Autoexemplars für einen Zeitraum freizuhalten gib das Startdatum:
      <input type="date" placeholder="Startdatum" v-model="startdate"/>
      <input type="time" placeholder="Startzeit" v-model="starttime"/>
      und das Enddatum:
      <input type="date" placeholder="Enddatum" v-model="enddate"/>
      <input type="time" placeholder="Endzeit" v-model="endtime"/>
      ein.
    </p>
    <button id="reserveBtn" @click="reserve">Reservieren</button>
  </div>
</template>

<script>

import axios from "axios";
import DetailedCarComponent from "@/components/DetailedCarComponent.vue";

export default {
  name: 'vehiclePage',
  components: {DetailedCarComponent},
  methods: {
    reserve() {
      if (!this.isLogedIn()){
        this.$router.push({name:'login'});
      }else {
        if (this.endtime !== undefined && this.enddate !== undefined && this.starttime !== undefined && this.startdate !== undefined){
          console.log("Creating Reservierung on " + this.startdate + " " +this.starttime + " until " + this.enddate + " " + this.endtime)
        }else{
          console.log("Not all Info Present to create Reservierung.")
        }
      }
    },
    isLogedIn(){
      return this.$store.getters.isLogedIn;
    }
  },
  data() {
    return {id: '', carmod: {}, starttime: undefined, endtime: undefined, startdate: undefined, enddate: undefined}
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
#resCont {
  margin: 20px;
}
#reserveBtn {
  width: 100%;
}
</style>
  