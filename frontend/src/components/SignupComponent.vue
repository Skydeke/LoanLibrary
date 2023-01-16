<template>
  <div class="container">
    <h1>Account erstellen</h1>
    <img class="loginImage" src="../assets/logo.png" />
    <div class="inputWrapper">
      <input
        v-model="user.firstName"
        type="text"
        placeholder="Vorname"
        @keydown="keyDown"
      />
      <!-- Two way binding-->
    </div>
    <div class="inputWrapper">
      <input
        v-model="user.secondName"
        type="text"
        placeholder="Zweitername(optional)"
        @keydown="keyDown"
      />
    </div>
    <div class="inputWrapper">
      <input
        v-model="user.lastName"
        type="text"
        placeholder="Nachname"
        @keydown="keyDown"
      />
    </div>
    <div class="inputWrapper">
      <input
        v-model="user.location"
        type="text"
        placeholder="Ort"
        @keydown="keyDown"
      />
    </div>
    <div class="inputWrapper">
      <input
        v-model="user.plz"
        type="number"
        placeholder="PLZ"
        @keydown="keyDown"
      />
    </div>
    <div class="inputWrapper">
      <input
        v-model="user.street"
        type="text"
        placeholder="Strasse"
        @keydown="keyDown"
      />
    </div>
    <div class="inputWrapper">
      <input
        v-model="user.houseNumber"
        type="text"
        placeholder="Hausnummer"
        @keydown="keyDown"
      />
    </div>
    <div class="inputWrapper">
      <input
        v-model="user.email"
        type="text"
        placeholder="E-Mail"
        @keydown="keyDown"
      />
    </div>
    <div class="inputWrapper">
      <input
        v-model="user.password"
        :type="passwordVisible ? 'text' : 'password'"
        placeholder="Passwort"
        @keydown="keyDown"
      />
      <img
        v-if="passwordVisible"
        src="../assets/nonVisible.png"
        class="visibleToggle"
        @click="visibleToggle"
      />
      <img
        v-if="!passwordVisible"
        src="../assets/visible.png"
        class="visibleToggle"
        @click="visibleToggle"
      />
    </div>
    <!-- Reference https://serversideup.net/password-security-validation-with-vuejs-and-zxcvbn/ (changed)-->
    <div class="progressbarContainer">
      <span
        :class="[
          'progressbar-item',
          {
            'progressbar-25p': passwordStrength <= 1,
            'progressbar-50p': passwordStrength == 2,
            'progressbar-75p': passwordStrength == 3,
            'progressbar-100p': passwordStrength == 4
          }
        ]"
      ></span>
      <!-- Object-binding-->
      <span
        :class="[
          'progressbar-item',
          {
            'progressbar-item': true,
            'progressbar-0p': passwordStrength <= 1,
            'progressbar-50p': passwordStrength == 2,
            'progressbar-75p': passwordStrength == 3,
            'progressbar-100p': passwordStrength == 4
          }
        ]"
      ></span>
      <span
        :class="[
          'progressbar-item',
          {
            'progressbar-item': true,
            'progressbar-0p': passwordStrength <= 2,
            'progressbar-75p': passwordStrength == 3,
            'progressbar-100p': passwordStrength == 4
          }
        ]"
      ></span>
      <span
        :class="[
          'progressbar-item',
          {
            'progressbar-item': true,
            'progressbar-0p': passwordStrength <= 3,
            'progressbar-100p': passwordStrength == 4
          }
        ]"
      ></span>
    </div>
    <div class="inputWrapper">
      <input
        v-model="passwordRepeat"
        :type="passwordRepeatVisible ? 'text' : 'password'"
        placeholder="Passwort wiederholen"
        @keydown="keyDown"
      />
      <img
        v-if="passwordRepeatVisible"
        src="../assets/nonVisible.png"
        class="visibleToggle"
        @click="visibleToggleRepeated"
      />
      <img
        v-if="!passwordRepeatVisible"
        src="../assets/visible.png"
        class="visibleToggle"
        @click="visibleToggleRepeated"
      />
    </div>
    <p v-if="showError" class="errorMessage">{{ errorMsg }}</p>
    <button class="loginButton" @click="register">Login</button>
  </div>
</template>

<script>
import axios from 'axios'
import { LOCALSTORAGE_INSTANCE } from '@/services/localstorage.service.js'
import zxcvbn from 'zxcvbn' // libary to validate password strength

export default {
  name: 'SignupComponent',
  data: () => {
    return {
      passwordVisible: false,
      passwordRepeatVisible: false,
      passwordRepeat: '',
      showError: false,
      errorMsg: '',
      user: {
        email: '',
        password: '',
        firstName: '',
        secondName: '',
        lastName: '',
        location: '',
        plz: '',
        street: '',
        houseNumber: ''
      }
    }
  },
  computed: {
    passwordStrength () {
      return zxcvbn(this.user.password).score
    }
  },
  methods: {
    register () {
      if (!this.user.firstName) {
        this.showErrorMessage('Name eingeben!')
        return
      }
      if (!this.user.lastName) {
        this.showErrorMessage('Nachname eingeben!')
        return
      }

      if (!this.user.location) {
        this.showErrorMessage('Ort eingeben')
        return
      }
      if (!this.user.plz) {
        this.showErrorMessage('PLZ eingaben!')
        return
      }
      if (!this.isValidPLZ(this.user.plz)) {
        this.showErrorMessage('PLZ ungungültig!')
        return
      }
      if (!this.user.street) {
        this.showErrorMessage('Strasse eingeben!')
        return
      }
      if (!this.user.houseNumber) {
        this.showErrorMessage('Hausnummer eingeben!')
        return
      }

      if (!this.user.email) {
        this.showErrorMessage('E-Mail eingeben!')
        return
      }

      if (!this.user.password) {
        this.showErrorMessage('Passwort wiederholen!')
        return
      }
      if (!this.passwordRepeat) {
        this.showErrorMessage('Passwort wiederholen!')
        return
      }
      if (!this.isVailidMail(this.user.email)) {
        this.showErrorMessage('E-Mail ist ungültig')
        return
      }
      if (this.passwordStrength < 4) {
        this.showErrorMessage('Das Passwort ist zu schwach')
        return
      }
      if (this.user.password !== this.passwordRepeat) {
        this.showErrorMessage('Die Passwörter stimmen nicht überein')
        return
      }
      axios
        .post(this.$hostname + '/registration', this.user)
        .then((response) => {
          LOCALSTORAGE_INSTANCE.writeAuth(response.data.token)
          this.$store.commit('login') // mutates the isLogin state inside store
          this.$router.push({ name: 'home' })
        })
        .catch((error) => {
          console.log(error)
          window.alert('Someting went wrong!')
        })
    },
    isValidPLZ (plz) {
      return plz > 10000 && plz < 100000
    },
    editMail () {
      this.enteredEmail = false
      this.password = ''
    },
    visibleToggle () {
      this.passwordVisible = !this.passwordVisible
    },
    visibleToggleRepeated () {
      this.passwordRepeatVisible = !this.passwordRepeatVisible
    },
    isVailidMail (email) {
      return String(email) // https://stackoverflow.com/questions/46155/how-can-i-validate-an-email-address-in-javascript
        .toLowerCase()
        .match(
          /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
        )
    },
    keyDown (event) {
      if (event.keyCode === 13) {
        // handle enter press
        this.register()
      }
    },
    showErrorMessage (msg) {
      this.showError = true
      this.errorMsg = msg
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.container {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  width: 20%;
  background-color: rgb(250, 244, 244);
  border: 2px solid black;
  border-radius: 15px;
  text-align: center;
}
.loginImage {
  width: 20%;
  height: 20%;
}

input {
  all: unset; /* Disable all input styles */
  text-align: left;
  width: 90%;
  height: 30px;
  margin-left: 5px;
}
.inputWrapper {
  border: 2px solid black;
  background-color: white;
  width: 80%;
  height: 30px;
  margin-left: 10%;
  margin-right: 10%;
  margin-top: 10px;
  border-radius: 5px;
  display: flex;
  justify-content: space-between;
}
.visibleToggle {
  width: 25px;
  height: 25px;
  padding-right: 5px;
}
.editButton {
  background-color: white;
  border: none;
}
.loginButton {
  border: 2px solid black;
  background-color: white;
  border-radius: 5px;
  margin-bottom: 10px;
  margin-top: 5px;
  width: 20%;
  height: 10%;
}
.errorMessage {
  color: red;
}
.progressbarContainer {
  margin-top: 4px;
  height: 10px;
  width: 80%;
  margin-left: 10%;
  display: flex;
  justify-content: space-between;
}
.progressbar-item {
  height: 10px;
  width: 25%;
  border: 1px solid black;
  border-radius: 15px;
  margin: 0;
}
.progressbar-0p {
  background-color: rgb(250, 244, 244);
}
.progressbar-25p {
  background-color: lightcoral;
}
.progressbar-50p {
  background-color: lightyellow;
}
.progressbar-75p {
  background-color: lightgreen;
}
.progressbar-100p {
  background-color: rgb(159, 236, 83);
}
</style>
