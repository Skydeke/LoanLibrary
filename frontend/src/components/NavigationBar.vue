<template>
  <nav>
    <img src="../assets/logo.png"/>
    <div>   
     <router-link to="/">Home</router-link>
     <router-link to="/login">Login</router-link>
    </div>

  </nav>
</template>

<script>
export default {
  name: 'NaviagitonBar',
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
    nav{
        display: flex;
        justify-content: space-between;
        background-color: aliceblue;
    }
    img{
        height: 3%;
        width: 3%;
    }
    a{ /*sytles router-lin*/
        margin: 5px;
    }
</style>