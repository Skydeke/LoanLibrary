<template>
  <h1 @click="click"> This is a Car</h1>
</template>

<script>
export default {
  name: 'CarComponent',
  data :()=>{
      return { name : "world"}
  },methods:{
    click(){
      console.log('click');

      const requestOptions = {
      method: "POST",
      headers: { "Content-Type": "application/json" },    
      body: JSON.stringify({ title: "Vue POST Request Example" })
      };

      fetch("http://localhost:8081/car", requestOptions)
      .then(response => response.json())
      .then(data => console.log(data));
    }
  }			
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>

</style>
