<script setup lang="ts">
const app = useAppConfig();
useHead({
  titleTemplate: (titleChunk) => {
    return titleChunk
      ? `${titleChunk} - ${app.tairo?.title}`
      : `${app.tairo?.title}`;
  },
  htmlAttrs: {
    lang: "en",
    dir: "ltr",
  },
  link: [
    {
      rel: "icon",
      type: "image/png",
      href: "/img/favicon.png",
    },
  ],
});
</script>

<template>
  <div>
    <NuxtPwaAssets />
    <NuxtLoadingIndicator />
    <NuxtLayout>
      <NuxtPage />
    </NuxtLayout>
  </div>
</template>
