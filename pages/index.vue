<script setup lang="ts">
useHead({
  title: "Welcome page",
  meta: [{ name: "description", content: "Eau vive gestion de piscine." }],
});

// here you can define your page logic
const message = ref("Bienvenue");
</script>

<template>
  <div>
    <BaseInput v-model="message" />
  </div>
</template>
