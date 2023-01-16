<template>
  <div class="pageContainer">
    <h1>Meine Reservierungen</h1>
    <ReservationComponent
      v-for="reservation in reservations"
      :key="reservation.ResNr"
      class="resWrapper"
      :reservation="reservation"
    ></ReservationComponent>
  </div>
</template>

<script>
import ReservationComponent from '@/components/ReservationComponent.vue'
import axios from 'axios'
import { LOCALSTORAGE_INSTANCE } from '@/services/localstorage.service'

export default {
  name: 'ReservationsPage',
  components: { ReservationComponent },
  data () {
    return { reservations: [] }
  },
  mounted () {
    const accessToken = LOCALSTORAGE_INSTANCE.getToken()
    axios
      .get(this.$hostname + '/reservations', {
        headers: {
          Authorization: `${accessToken}`
        }
      })
      .then((response) => {
        this.reservations = response.data
        console.log(response.data)
        if (response.status === 403) {
          LOCALSTORAGE_INSTANCE.deleteAuth()
          this.$store.commit('logout')
          this.$router.push({ name: 'login' })
        }
      })
      .catch((error) => {
        console.log(error)
        LOCALSTORAGE_INSTANCE.deleteAuth()
        this.$store.commit('logout')
        this.$router.push({ name: 'login' })
      })
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h1 {
  text-align: center;
}
.pageContainer {
  margin-left: 20%;
  width: 60%;
}

.resWrapper {
  margin-bottom: 10px;
}

hr {
  border-top: 2px solid black;
}
</style>
