import { createStore } from "vuex";
import { LOCALSTORAGE_INSTANCE } from "@/services/localstorage.service.js";

const store = createStore({
  state() {
    return {
      isLogedIn: LOCALSTORAGE_INSTANCE.readAuth() //check if the user already has the isLoginValue in LocalStorge, is so the user gets its last value, otherwise we will be logout by default
    };
  },
  mutations: {
    login(state) {
      state.isLogedIn = true;
    },
    logout(state) {
      state.isLogedIn = false;
    }
  },
  getters: {
    isLogedIn(state) {
      //vuex uses the state parameter
      return state.isLogedIn;
    }
  }
});

export default store;
