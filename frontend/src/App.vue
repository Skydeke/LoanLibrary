<template>
  <div>
    <NaviagitonBar v-on:sidebarToggle="toggleSidebar"></NaviagitonBar> <!-- Custom Event-->
    <SidebarComponent v-if="showSidebar"></SidebarComponent>
    <RouterView > </RouterView>
    
  </div>
</template>

<script>
import NaviagitonBar from './components/NavigationBar.vue'
import SidebarComponent from '@/components/SidebarComponent.vue';

export default {
  name: 'App',
 components:{NaviagitonBar,SidebarComponent},
  data(){
    return {showSidebar:false};
  },methods:{
      toggleSidebar(){
          this.showSidebar = !this.showSidebar;
      }
  }
}
</script>

<style>
  body { margin: 0};

  
  


</style>
