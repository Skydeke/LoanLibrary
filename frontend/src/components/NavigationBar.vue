<template>
  <nav>
    <div class="left">
    <img id="sidebar" src="../assets/sidebar.png"/>
    <img id="logo" @click="goHome" src="../assets/logo.png"/>
   </div>
    <router-link id="homeText" to="/">Home</router-link>
    <div class="right">
      <div class="container">
        <img @click="triggerMenu" v-if="isLogedIn" v-bind:src="'https://ui-avatars.com/api/?name=' + encodedName"
             id="customerProfile" alt="ProfilePicture"/>
      </div>
      <router-link  v-if="!isLogedIn" to="/login">Login</router-link>
      <router-link  v-if="!isLogedIn" to="/signup">Registrieren</router-link>
      <menu class="customerMenu" v-if="openMenu&&isLogedIn">
        <li>
          <router-link @click="openMenu = !openMenu" to="/reservations">Meine Reservierungen</router-link>
        </li>
        <li><a @click="openMenu = !openMenu">Meine Rechnungen</a></li>
        <li>
          <router-link @click="logout" to="">Logout</router-link>
        </li>
      </menu>
    </div>
  </nav>
</template>

<script>
import {LOCALSTORAGE_INSTANCE} from "@/services/localstorage.service.js";


export default {
  name: 'NavigitonBar',
  computed: { //computed property always executes, when our values change, the values gets chaced until it is changed
    isLogedIn() {
      return this.$store.getters.isLogedIn;
    },
  }, methods: {
    triggerMenu() {
      this.openMenu = !this.openMenu;
    },
    logout() {
      LOCALSTORAGE_INSTANCE.deleteAuth();
      this.$store.commit('logout');
      this.triggerMenu();
    },
    goHome() {
      this.$router.push({name: 'home'});
    }
  },
  data() {
    let backendToken = LOCALSTORAGE_INSTANCE.getToken();
    if (backendToken != null) {
      let kundenToken = JSON.parse(atob(backendToken.split('.')[1]))
      let encodedName = encodeURIComponent(kundenToken.Vorname + " " + kundenToken.ZweiterVorname + " " + kundenToken.Nachname);
      console.log(kundenToken);
      return {openMenu: false, encodedName: encodedName}
    }
    return {openMenu: false, encodedName: 'Error Man'}
  },
  updated() {
    let backendToken = LOCALSTORAGE_INSTANCE.getToken();
    if (backendToken != null) {
      let kundenToken = JSON.parse(atob(backendToken.split('.')[1]))
      let encodedName = encodeURIComponent(kundenToken.Vorname + " " + kundenToken.ZweiterVorname + " " + kundenToken.Nachname);
      console.log(kundenToken);
      this.encodedName = encodedName;
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
nav {
  display: flex;
  justify-content: space-between;
  background-color: aliceblue;
  position: sticky;
  width: 100%;
  height: 10%;
  top: 0;
}

#sidebar{
  width: 5%;
  height: 5%;
  margin-left: 10px;
}

#logo{
  width: 15%;
  height: 15%;
}

a { /*sytles router-lin*/
  padding: 10px;
  margin-top: auto;
  margin-bottom: auto;
}

.container {
  height: 100%;
}

.right {
  padding: 10px;
  margin-top: auto;
  margin-bottom: auto;
  margin-right: 10px;
  justify-content: right;
  display: flex;
  width: 33%;
}
.left{
  display: flex;
  align-items: center;
  justify-content: left;
  height: 100%;
  width: 33%;
}




#customerProfile {
  height: 100%;
  width: 100%;
  border-radius: 50%;
}

.customerMenu {
  margin-top: auto;
  margin-bottom: auto;
  justify-content: right;
}
</style>