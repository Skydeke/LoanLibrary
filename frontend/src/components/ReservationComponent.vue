<template>
  <div class="blackborder">
    <table>
      <tr>
        <td><h2>Auszuleihendes Automodell</h2></td>
        <td><h2>Reservierungsinformationen</h2></td>
      </tr>
      <tr>
        <td>
          <DetailedCarComponent :carmod="carm"></DetailedCarComponent>
        </td>
        <td style="vertical-align: top; text-align: left;">
          <div class="container">
            <p>Ein Autoexemplar wird ihnen von </p>
            <Datepicker v-model="startTime" :readonly="true"></Datepicker>
            <p>bis</p>
            <Datepicker v-model="endTime" :readonly="true"></Datepicker>
            <p>zur Verfügung gestellt.</p>
            <button @click="delReservation">Reservierung stornieren</button>
          </div>
        </td>
      </tr>
    </table>
  </div>
</template>

<script>
import DetailedCarComponent from "@/components/DetailedCarComponent.vue";
import axios from "axios";
import Datepicker from '@vuepic/vue-datepicker';
import '@vuepic/vue-datepicker/dist/main.css'

export default {
  name: 'ReservationComponent',
  components: {DetailedCarComponent, Datepicker},
  props: ['reservation'],
  methods: {
    delReservation(){
      axios.delete(this.$hostname + '/reservation/' + this.reservation.ResNr).then(response => {
        if (response.status !== 200){
          console.log("An Error happend deleting the reservation.")
        }else {
          console.log("Deleted Reservation with id: " + this.reservation.ResNr)
          this.$el.parentNode.removeChild(this.$el);
        }
      }).catch(error => console.log(error));
    }
  },
  data() {
    this.id = this.reservation.AutomodellNr;
    let carPr = axios.get(this.$hostname + '/automodell/' + this.id).then(response => {
      this.carm = response.data;
    }).catch(error => console.log(error))
    axios.get(this.$hostname + '/automodell/ausstattungen/' + this.id).then(response => {
      this.carm.ausstattung = response.data;
    }).catch(error => console.log(error));
    let dbStartD = new Date(Date.parse(this.reservation.geplanterStart));
    let dbEndD = new Date(Date.parse(this.reservation.geplantesEnde));
    //let timeOffsetInMS = dbStartD.getTimezoneOffset() * 60000;

    let localStart = new Date(dbStartD.getTime());
    //localStart.setTime(localStart.getTime() - timeOffsetInMS);
    let localEnd = new Date(dbEndD.getTime());
    //localEnd.setTime(localEnd.getTime() - timeOffsetInMS);
    console.log("start: " + dbStartD.getTimezoneOffset())
    return {carm: carPr, startTime: localStart, endTime: localEnd}
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.blackborder {
  border-top: solid 2px black;;
  border-bottom: solid 2px black;;
  border-right: solid 2px black;
  margin: 10px;
}

table {
  border-collapse: collapse;
  width: 100%;
}

tr {
  border: none;
}

td {
  border-left: solid 2px black;
}

h2 {
  padding-top: 10px;
  padding-left: 10px;
}

.container {
  position: sticky;
  margin: 50px 10px 10px;
  z-index: 0;
}
</style>
