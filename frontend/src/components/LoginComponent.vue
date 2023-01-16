<template>
  <div class="container">
    <img class="loginImage" src="../assets/logo.png" />
    <h1>Wilkommen</h1>
    <div class="inputWrapper">
      <input
        v-if="!enteredEmail"
        v-model="email"
        type="email"
        placeholder="E-Mail eingeben"
        @keydown="keyDown"
      />
      <!-- Two way binding-->
      <input
        v-if="enteredEmail"
        v-model="email"
        type="email"
        placeholder="E-Mail eingeben"
        readonly="readonly"
      />
      <button v-if="enteredEmail" class="editButton" @click="editMail">
        Edit
      </button>
    </div>
    <div v-if="enteredEmail" class="inputWrapper">
      <input
        v-model="password"
        :type="passwordVisible ? 'text' : 'password'"
        placeholder="Password eingeben"
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
    <p v-if="errorEmail" class="errorMessage">Die E-Mail ist falsch</p>
    <p v-if="errorPassoword" class="errorMessage">Das Passowrd ist falsch</p>
    <button class="loginButton" @click="login">Login</button>
  </div>
</template>

<script>
import axios from 'axios'
import { LOCALSTORAGE_INSTANCE } from '@/services/localstorage.service.js'
export default {
  name: 'LoginComponent',
  data: () => {
    return {
      email: '',
      password: '',
      enteredEmail: false,
      passwordVisible: false,
      errorEmail: false,
      errorPassoword: false
    }
  },
  methods: {
    login () {
      if (!this.enteredEmail) {
        if (this.isVailidMail(this.email)) {
          this.enteredEmail = true
          this.errorEmail = false
        } else {
          this.errorEmail = true
        }
      } else {
        if (this.password) {
          axios
            .post(this.$hostname + '/login', {
              email: this.email,
              password: this.password
            })
            .then((response) => {
              LOCALSTORAGE_INSTANCE.writeAuth(response.data.token)
              this.$store.commit('login') // mutates the isLogin state inside store
              this.$router.push({ name: 'home' })
            })
            .catch((error) => {
              if (error.response.status === 401) this.errorPassoword = true
              else window.alert('Someting went wrong!')
            })
        } else {
          this.errorPassoword = true
        }
      }
    },
    editMail () {
      this.enteredEmail = false
      this.password = ''
    },
    visibleToggle () {
      this.passwordVisible = !this.passwordVisible
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
        this.login()
      }
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
  width: 60%;
  height: 60%;
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
  margin-bottom: 10px;
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
  width: 20%;
  height: 10%;
}
.errorMessage {
  color: red;
}
img {
  width: 400px;
  height: 400px;
}
</style>
