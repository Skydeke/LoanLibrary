<template>
  <div class="pageContainer">
    <DetailedCarComponent :carmod="carmod"></DetailedCarComponent>
    <div id="resCont">
      <h2>Reservierung</h2>
      <p>
        Bei unserem Autoverleih ist es nicht möglich ein konkretes Auto zu
        reservieren, aber man kann ein Automodell für ein bestimmten Zeitraum
        reservieren. Eine Reservierung ist kostenlos und muss nicht zwangsläufig
        zu einem Leihvertrag führen.
        <br />
        Um ein Auto dieses Autoexemplars für einen Zeitraum freizuhalten gib das
        Startdatum & Zeit:
        <Datepicker v-model="startdate" locale="de"></Datepicker>
        und das Enddatum & Zeit:
        <Datepicker v-model="enddate" locale="de"></Datepicker>
        ein.
      </p>
      <button id="reserveBtn" @click="reserve">Reservieren</button>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
import DetailedCarComponent from '@/components/DetailedCarComponent.vue'
import Datepicker from '@vuepic/vue-datepicker'
import '@vuepic/vue-datepicker/dist/main.css'
import { LOCALSTORAGE_INSTANCE } from '@/services/localstorage.service'

export default {
  name: 'VehiclePage',
  components: { DetailedCarComponent, Datepicker },
  data() {
    return { id: '', carmod: {}, startdate: null, enddate: null }
  },
  created() {
    this.id = this.$route.params.id
    const carProm = axios
      .get(this.$hostname + '/automodell/' + this.id)
      .then((response) => {
        this.carmod = response.data
      })
      .catch((error) => console.log(error))
    axios
      .get(this.$hostname + '/automodell/ausstattungen/' + this.id)
      .then((response) => {
        this.carmod.ausstattung = response.data
      })
      .catch((error) => console.log(error))
    this.carmod = carProm
  },
  methods: {
    reserve() {
      if (!this.isLogedIn()) {
        this.$router.push({ name: 'login' })
      } else {
        if (this.enddate !== null && this.startdate !== null) {
          console.log(
            'Creating Reservierung on ' +
              this.startdate +
              ' ' +
              ' until ' +
              this.enddate
          )
          const backendToken = LOCALSTORAGE_INSTANCE.getToken()
          const kundenNr = JSON.parse(atob(backendToken.split('.')[1])).KundenNr
          this.bill = {
            geplanterStart: this.startdate,
            geplantesEnde: this.enddate,
            AutomodellNr: this.id,
            KundenNr: kundenNr,
            AusleihvorgangNr: null
          }
          axios
            .post(this.$hostname + '/reservation', this.bill)
            .then((response) => {
              console.log('Creating Reservierung: ' + response.toString())
              this.$router.push({ name: 'reservations' })
            })
            .catch((error) => console.log(error))
        } else {
          console.log('Not all Info Present to create Reservierung.')
        }
      }
    },
    isLogedIn() {
      return this.$store.getters.isLogedIn
    }
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
.pageContainer {
  margin-left: 20%;
  width: 60%;
}
</style>
