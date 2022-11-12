<template>
  <div @click="redirect">
    <img :src="image_src" />
    <h2> {{vehicle_name}}</h2>
    <div class="container">
      <ul>
        <li>Klimaanlage</li>
        <li>Sitzheizung</li>
        <li>5 Türer</li>
      </ul>
  </div>
</div>
</template>

<script>


export default {
  name: 'CarComponent',
  props:['vehicle_name','image_src'],
  methods:{
      redirect(){
        this.$router.push({name:'vehicle',params:{vehicle_name: this.vehicle_name}}); //redirect to vehicle with specific name. The attribute name refers to the name specified in router/index.js
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
