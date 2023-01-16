<template>
  <div>
    <NaviagitonBar @sidebarToggle="toggleSidebar"></NaviagitonBar>
    <!-- Custom Event-->
    <SidebarComponent v-if="showSidebar"></SidebarComponent>
    <RouterView @sidebarDisable="sidebarDisable"> </RouterView>
  </div>
</template>

<script>
import NaviagitonBar from "./components/NavigationBar.vue";
import SidebarComponent from "@/components/SidebarComponent.vue";

export default {
  name: "App",
  components: { NaviagitonBar, SidebarComponent },
  data() {
    return { showSidebar: false };
  },
  methods: {
    toggleSidebar() {
      this.showSidebar = !this.showSidebar;
    },
    sidebarDisable() {
      this.showSidebar = false;
    }
  }
};
</script>

<style>
body {
  margin: 0;
}
</style>
