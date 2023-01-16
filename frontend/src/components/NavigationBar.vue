<template>
  <nav>
    <div class="left">
      <img id="sidebar" src="../assets/sidebar.png" @click="toggleSidebar" />
      <img id="logo" src="../assets/logo.png" @click="goHome" />
    </div>
    <router-link id="homeText" to="/">Home</router-link>
    <div class="right">
      <div class="container">
        <img
          v-if="isLogedIn"
          id="customerProfile"
          :src="'https://ui-avatars.com/api/?name=' + encodedName"
          alt="ProfilePicture"
          @click="triggerMenu"
        />
      </div>
      <router-link v-if="!isLogedIn" to="/login">Login</router-link>
      <router-link v-if="!isLogedIn" to="/signup">Registrieren</router-link>
      <menu v-if="openMenu && isLogedIn" class="customerMenu">
        <li>
          <router-link to="/reservations" @click="openMenu = !openMenu"
            >Meine Reservierungen</router-link
          >
        </li>
        <li>
          <router-link to="/bills" @click="openMenu = !openMenu"
            >Meine Rechnungen</router-link
          >
        </li>
        <li>
          <router-link to="" @click="logout">Logout</router-link>
        </li>
      </menu>
    </div>
  </nav>
</template>

<script>
import { LOCALSTORAGE_INSTANCE } from '@/services/localstorage.service.js'

export default {
  name: 'NavigitonBar',
  emits: ['sidebar-toggle'],
  data() {
    const backendToken = LOCALSTORAGE_INSTANCE.getToken()
    if (backendToken != null) {
      const kundenToken = JSON.parse(atob(backendToken.split('.')[1]))
      const encodedName = encodeURIComponent(
        kundenToken.Vorname +
          ' ' +
          kundenToken.ZweiterVorname +
          ' ' +
          kundenToken.Nachname
      )
      console.log(kundenToken)
      return { openMenu: false, encodedName }
    }
    return { openMenu: false, encodedName: 'Error Man' }
  },
  computed: {
    // computed property always executes, when our values change, the values gets chaced until it is changed
    isLogedIn() {
      return this.$store.getters.isLogedIn
    }
  },
  updated() {
    const backendToken = LOCALSTORAGE_INSTANCE.getToken()
    if (backendToken != null) {
      const kundenToken = JSON.parse(atob(backendToken.split('.')[1]))
      const encodedName = encodeURIComponent(
        kundenToken.Vorname +
          ' ' +
          kundenToken.ZweiterVorname +
          ' ' +
          kundenToken.Nachname
      )
      console.log(kundenToken)
      this.encodedName = encodedName
    }
  },
  methods: {
    triggerMenu() {
      this.openMenu = !this.openMenu
    },
    logout() {
      LOCALSTORAGE_INSTANCE.deleteAuth()
      this.$store.commit('logout')
      this.triggerMenu()
    },
    goHome() {
      this.$router.push({ name: 'home' })
    },
    toggleSidebar() {
      this.$emit('sidebar-toggle')
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
  z-index: 50;
}

#sidebar {
  width: 5%;
  height: 5%;
  margin-left: 10px;
}

#logo {
  width: 15%;
  height: 15%;
}

a {
  /*sytles router-lin*/
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
.left {
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
