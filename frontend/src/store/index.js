import { createStore } from 'vuex'

const store = createStore({
    state () {
      return {
        isLogedIn:localStorage.getItem('isLogedIn') !== undefined ? localStorage.getItem('isLogedIn'): false //check if the user already has the isLoginValue in LocalStorge, is so the user gets its last value, otherwise we will be logout by default
      }
    },
    mutations: {
      login(state){
        state.isLogedIn = true
      },
      logout(state){
        state.isLogedIn = false;
      }
    },
    getters:{
        isLogedIn(state){ //vuex uses the state parameter
            return state.isLogedIn;
        }
    }
  })

  store.subscribe((mutation, state)=>{ //when ever your store is changed whe store the isLoginValue in LocalStorage
    localStorage.setItem('isLogedIn', state.isLogedIn);
  });

  export default store;
