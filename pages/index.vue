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
    <NuxtLink
      to="/auth/login"
      class="text-muted-400 hover:text-primary-500 flex items-center gap-2 font-sans font-medium transition-colors duration-300"
    >
      <Icon name="gg:log-in" class="size-5" />
      <span>Log in</span>
    </NuxtLink>
  </div>
</template>
