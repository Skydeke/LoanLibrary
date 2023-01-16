<template>
  <div>
    <img :src="$hostname + '/image/' + carmod.imagefile" />
    <h1>{{ carmod.Hersteller }} {{ carmod.Modellbezeichnung }}</h1>
    <div class="container">
      <h3>Grundinformationen</h3>
      <p>
        Dieser {{ carmod.Typ }} mit {{ carmod.Sitzplaetze }} Sitzplätzen kann zu
        einem Preis von {{ carmod.PreisProTag }} Euro pro Tag und einer Gebühr
        von {{ carmod.PreisProKm }} Euro pro Kilometer ausgeliehen werden.
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
    <div id="cont">
      <h2>Grundausstattung</h2>
      <p>In diesem Automodell sind beim Ausleihen mindestens verbaut:</p>
      <ul>
        <li v-for="ausst in carmod.ausstattung" :key="ausst.AusleihNr">
          {{ ausst.Bezeichnung }}
        </li>
      </ul>
    </div>
  </div>
</template>

<script>
export default {
  name: 'DetailedCarComponent',
  props: {
    carmod: {
      type: Object,
      default: null
    }
  },
  methods: {}
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

#cont {
  margin-top: 50px;
}
</style>
