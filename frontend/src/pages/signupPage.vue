<template>
  <div>
    <SignupComponent></SignupComponent>
  </div>
</template>

<script>
import SignupComponent from "@/components/SignupComponent.vue";
export default {
  name: "SignupPage",
  components: { SignupComponent },
  emits: ["sidebarDisable"],
  mounted() {
    this.$emit("sidebarDisable");
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
a {
  position: sticky;
}
</style>
