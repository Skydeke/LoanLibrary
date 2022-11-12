<template>
  <div>
    <NaviagitonBar></NaviagitonBar>
   <router-view />
  </div>
</template>

<script>
import NaviagitonBar from './components/NavigationBar.vue'


export default {
  name: 'App',
  components:{NaviagitonBar}
}
</script>

<style>
  body { margin: 0};

</style>
