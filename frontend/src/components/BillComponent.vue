<template>
  <div class="blackborder">
    <table>
      <tr>
        <td><h2>Auszuleihendes Automodell</h2></td>
        <td><h2>Rechnungsnformationen</h2></td>
      </tr>
      <tr>
        <td>
          <DetailedCarComponent :carmod="carm"></DetailedCarComponent>
        </td>
        <td style="vertical-align: top; text-align: left;">
          <div class="container">
            <p>
              Autoexemplar {{ bill.Kennzeichen }} wurde ihnen übergeben am
              <Datepicker class="datep" v-model="leihStart" :readonly="true"></Datepicker>
              mit einem Kilometerstand von
              {{ bill.beginnKm }} Km.
              <br>
              Das Auto wurde uns zurückgegeben {{ Number(anzTage).toFixed(5) }} Tag(e) später, am
              <Datepicker class="datep" v-model="leihEnde" :readonly="true"></Datepicker>
              mit einem Kilometerstand von {{ bill.endeKm }} Km.
            </p>
            <hr>
            <p style="margin-top: 20px; margin-bottom: 20px">Rechnung:</p>
            <table class="rechnung">
              <tr>
                <td>
                  Tagesgebühren (Tage werden aufgerundet):
                </td>
                <td></td>
              </tr>
              <tr>
                <td>
                </td>
                <td>
                  {{ Math.ceil(anzTage) }} Tag(e) * {{ carm.PreisProTag }} Euro
                </td>
              </tr>
              <tr>
                <td>
                  Kilometergebühren:
                </td>
                <td></td>
              </tr>
              <tr>
                <td>

                </td>
                <td style="border-bottom: solid 3px black">
                  + {{ anzKm }} Km * {{ carm.PreisProKm }} Euro
                </td>
              </tr>
              <tr>
                <td></td>
                <td>
                  Summe: {{ bill.Summe }} Euro
                </td>
              </tr>
            </table>
            <p v-if="bill.beglichen"> Diese Rechnung wurde bezahlt.</p>
            <p v-if="!bill.beglichen"> Diese Rechnung wurde noch nicht bezahlt.</p>
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
  name: 'BillComponent',
  components: {DetailedCarComponent, Datepicker},
  props: ['bill'],
  methods: {},
  data() {
    this.id = this.bill.AutomodellNr;
    let carPr = axios.get(this.$hostname + '/automodell/' + this.id).then(response => {
      this.carm = response.data;
    }).catch(error => console.log(error))
    axios.get(this.$hostname + '/automodell/ausstattungen/' + this.id).then(response => {
      this.carm.ausstattung = response.data;
    }).catch(error => console.log(error));

    let dbStartD = new Date(Date.parse(this.bill.beginnZeit));
    let dbEndD = new Date(Date.parse(this.bill.endeZeit));

    let localStart = new Date(dbStartD.getTime());
    let localEnd = new Date(dbEndD.getTime());
    let tage = (localEnd.getTime() - localStart.getTime()) / (1000 * 3600 * 24);
    console.log("start: " + dbStartD.getTimezoneOffset())
    console.log("Bill-Info" + JSON.stringify(this.bill));
    let km = this.bill.endeKm - this.bill.beginnKm;
    return {carm: carPr, leihStart: localStart, leihEnde: localEnd, anzTage: tage, anzKm: km}
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

.rechnung {
  border-bottom: solid 2px black;
  border-right: solid 2px black;
  border-top: solid 2px black;
}

.datep {
  margin-top: 10px;
  margin-bottom: 10px;
}
</style>
