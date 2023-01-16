<template>
  <div class="pageContainer">
    <h1>Meine Rechnungen</h1>
    <BillComponent
      v-for="bill in bills"
      :key="bill.RechNr"
      class="resWrapper"
      :bill="bill"
    ></BillComponent>
  </div>
</template>

<script>
import BillComponent from '../components/BillComponent.vue'
import axios from 'axios'
import { LOCALSTORAGE_INSTANCE } from '@/services/localstorage.service'

export default {
  name: 'BillsPage',
  components: { BillComponent },
  data () {
    return { bills: [] }
  },
  mounted () {
    const accessToken = LOCALSTORAGE_INSTANCE.getToken()
    axios
      .get(this.$hostname + '/bills', {
        headers: {
          Authorization: `${accessToken}`
        }
      })
      .then((response) => {
        this.bills = response.data
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
