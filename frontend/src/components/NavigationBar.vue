<template>
  <nav>
    <img @click="goHome" src="../assets/logo.png"/>

    <router-link id="homeText" to="/">Home</router-link>
    <div class="right">
      <div>
        <img @click="triggerMenu" v-if="isLogedIn" v-bind:src="'https://ui-avatars.com/api/?name=' + encodedName"
             id="customerProfile" alt="ProfilePicture"/>
        <router-link class="right" v-if="!isLogedIn" to="/login">Login</router-link>
      </div>
    </div>
    <menu class="customerMenu" v-if="openMenu&&isLogedIn">
      <li><a>Meine Reservierungen</a></li>
      <li><a>Meine Rechnungen</a></li>
      <li>
        <router-link @click="logout" to="">Logout</router-link>
      </li>
    </menu>
  </nav>
</template>

<script>
import { LOCALSTORAGE_INSTANCE } from "@/services/localstorage.service.js";
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
    },
    goHome() {
      this.$router.push({name: 'home'});
    }
  },
  data() {
    let backendToken = localStorage.getItem("token");
    if (backendToken != null) {
      let kundenToken = JSON.parse(atob(backendToken.split('.')[1]))
      let encodedName = encodeURIComponent(kundenToken.Vorname + " " + kundenToken.ZweiterVorname + " " + kundenToken.Nachname);
      console.log(kundenToken);
      return {openMenu: false, encodedName: encodedName}
    }
    return {openMenu: false, encodedName: 'Error Man'}
  },
  updated() {
    let backendToken = localStorage.getItem("token");
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
  top: 0;
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

#homeText {
  position: sticky;
  top: 50%;
  left: 50%;
  transform: translateX(-50%);
}

.right {
  padding: 10px;
  margin-top: auto;
  margin-bottom: auto;
  margin-right: 10px;
  justify-content: right;
}

#customerProfile {
  height: 100%;
  width: 100%;
  border-radius: 50%;
}

.customerMenu {
  position: sticky;
  padding: 10px;
  margin-top: auto;
  margin-bottom: auto;
  margin-right: 10px;
  justify-content: right;
}
</style>