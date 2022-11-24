<template>
  <nav>
    <img src="../assets/logo.png"/>
    <div>   
     <router-link to="/">Home</router-link>
     <router-link v-if="!isLogedIn" to="/login">Login</router-link>
     <router-link v-if="isLogedIn" @click="logout" to="">Logout</router-link>

    </div>

  </nav>
</template>

<script>
export default {
  name: 'NaviagitonBar',
  computed:{ //computed property always executes, when our values change, the values gets chaced until it is changed
      isLogedIn(){
        return this.$store.getters.isLogedIn;
      }
  },methods:{
    logout(){
      this.$store.commit('logout');
      localStorage.removeItem('token');
    }
  }
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