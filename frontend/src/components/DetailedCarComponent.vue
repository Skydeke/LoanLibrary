<template>
  <div>
    <img :src="this.$hostname + '/image/' + carmod.imagefile"/>
    <h1> {{ carmod.Hersteller }} {{ carmod.Modellbezeichnung }}</h1>
    <div class="container">
      <h3>Grundinformationen</h3>
      <p>
        Dieser {{ carmod.Typ }} mit {{ carmod.Sitzplaetze }} Sitzplätzen kann zu einem Preis von
        {{ carmod.PreisProTag }} Euro pro Tag und einer Gebühr von {{ carmod.PreisProKm }} Euro
        pro Kilometer ausgeliehen werden.
      </p>
      <h3>Details</h3>
      <table border="1" width="30%">
        <tr>
          <th>Hersteller</th>
          <th>{{ carmod.Hersteller }}</th>
        </tr>
        <tr>
          <th>Modellbezeichnung</th>
          <th>{{ carmod.Modellbezeichnung }}</th>
        </tr>
        <tr>
          <th>Typ der Automodells</th>
          <th>{{ carmod.Typ }}</th>
        </tr>
        <tr>
          <th>Anzahl Sitzplätze</th>
          <th>{{ carmod.Sitzplaetze }}</th>
        </tr>
        <tr>
          <th>Achsenzahl</th>
          <th>{{ carmod.Achsenzahl }}</th>
        </tr>
        <tr>
          <th>Ladegewicht in Kg</th>
          <th>{{ carmod.LadegewichtKg }}</th>
        </tr>
        <tr>
          <th>Ladevolumen in m³</th>
          <th>{{ carmod.LadevolumenKubikMeter }}</th>
        </tr>
      </table>
    </div>
    <div id="resCont">
      <h2>Grundausstattung</h2>
      <p>
        In diesem Automodell sind beim Ausleihen mindestens verbaut:
      </p>
      <ul>
        <li v-for="ausst in carmod.ausstattung" :key="ausst.AusleihNr"> {{ ausst.Bezeichnung }}</li>
      </ul>
    </div>
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
  </div>
</template>

<script>
export default {
  name: 'DetailedCarComponent',
  props: ['carmod'],
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
  data: function () {
    return {starttime: undefined, endtime: undefined, startdate: undefined, enddate: undefined}
  }
}

</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
div {
  margin: 20px;
}

img {
  height: 400px;
  width: 450px;
  float: left;
  margin-right: 40px;
  margin-top: 30px;
}

h1 {
  display: inline-block;
}

#resCont {
  margin-top: 50px;
}

#reserveBtn {
  width: 100%;
}
</style>
