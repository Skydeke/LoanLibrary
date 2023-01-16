<template>
  <div>
    <LoginComponent></LoginComponent>
  </div>
</template>

<script>
import LoginComponent from "../components/LoginComponent.vue";
export default {
  name: "LoginPage",
  components: { LoginComponent },
  emits: ["sidebarDisable"],
  mounted() {
    this.$emit("sidebarDisable");
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped></style>
