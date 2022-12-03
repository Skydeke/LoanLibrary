<template>
  <div @click="redirect">
    <img :src="this.$hostname + '/image/' + car.imagefile" />
    <h2> {{car.Hersteller}} {{car.Modellbezeichnung}}</h2>
    <div class="container">
      <ul>
        <li>{{car.Sitzplaetze}} Sitzplaetze</li>
        <li>Führescheinklasse: {{car.Klassenbezeichnung}}</li>
        <li>Preis pro Tag {{car.PreisProTag}} €</li>
      </ul>
  </div>
</div>
</template>

<script>


export default {
  name: 'CarComponent',
  props:['car'],
  methods:{
      redirect(){
        this.$router.push({name:'vehicle',params:{id: this.car.AutomodellNr}}); //redirect to vehicle with specific name. The attribute name refers to the name specified in router/index.js
        //$router is a global varible
    }	
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
  div{
    margin: 20px;
    cursor: pointer;
  }

  img{
    height: 400px;
    width: 450px;
  }
  h2{
    text-align: center;
    margin: 0;
  }
  .container{
      margin: 0;
     display: flex;
     justify-content: center;
  }

</style>
