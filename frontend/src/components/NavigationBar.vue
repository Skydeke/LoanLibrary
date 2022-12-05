<template>
  <nav>
    <div class="container">
    <img @click="goHome" src="../assets/logo.png"/>

    <router-link id="homeText" to="/">Home</router-link>
    <div class="linkWrapper">
      <router-link  v-if="!isLogedIn" to="/login">Login</router-link>
      <router-link  v-if="!isLogedIn" to="/signup">SignUp</router-link>
      <router-link class="logText" v-if="isLogedIn" @click="logout" to="">Logout</router-link>
    </div>
  </div>
  </nav>
</template>

<script>
export default {
  name: 'NaviagitonBar',
  computed: { //computed property always executes, when our values change, the values gets chaced until it is changed
    isLogedIn() {
      return this.$store.getters.isLogedIn;
    }
  }, methods: {
    logout() {
      this.$store.commit('logout');
      localStorage.removeItem('token');
    },
    goHome() {
      this.$router.push({name: 'home'});
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
nav {
  display: sticky;
}

.container{
  display: flex;
  justify-content: space-between;
  background-color: aliceblue;
  position: fixed;
  width: 100%;
  top: 0;
}
.linkWrapper{
  margin-top: auto;
  margin-bottom: auto;
}
img {
  height: 3%;
  width: 3%;
  border: black;

}

a { /*sytles router-lin*/
  padding: 10px;
  margin-top: auto;
  margin-bottom: auto;
}



</style>