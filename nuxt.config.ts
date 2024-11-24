// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  alias: {
    "@Types": "./types",
  },
  compatibilityDate: "2024-07-21",
  devtools: { enabled: true },
  experimental: {
    payloadExtraction: true,
  },
  extends: [
    "gh:cssninjaStudio/tairo/layers/tairo#v1.5.1",
    "gh:cssninjaStudio/tairo/layers/tairo-layout-sidebar#v1.5.1",
  ],
  modules: ["@vite-pwa/nuxt", "@prisma/nuxt", "@pinia/nuxt"],
  nitro: {
    prerender: {
      routes: ["/"],
    },
  },
  pinia: {
    storesDirs: ["./stores/**"],
  },
  prisma: {
    autoSetupPrisma: true,
  },
  pwa: {
    registerType: "prompt",
    injectRegister: false,

    pwaAssets: {
      disabled: false,
      config: true,
    },

    manifest: {
      display: "minimal-ui",
      name: "pwa-test",
      short_name: "pta-test",
      description: "pwa-test",
      theme_color: "#ffffff",
      screenshots: [
        {
          src: "apple-splash-portrait-light-1536x2048.png",
          sizes: "1536x2048",
          type: "image/png",
          form_factor: "wide",
          label: "nome simplificado do APP",
        },
        {
          src: "screenshot-630×750.png",
          sizes: "630x750",
          form_factor: "narrow",
          type: "image/png",
          label: "nome simplificado do APP",
        },
      ],
      icons: [
        {
          src: "pwa-64x64.png",
          sizes: "64x64",
          type: "image/png",
        },
        {
          src: "pwa-192x192.png",
          sizes: "192x192",
          type: "image/png",
        },
        {
          src: "pwa-512x512.png",
          sizes: "512x512",
          type: "image/png",
        },
      ],
    },

    workbox: {
      globPatterns: ["**/*.{js,css,html,svg,png,ico}"],
      cleanupOutdatedCaches: true,
      clientsClaim: true,
    },

    devOptions: {
      enabled: false,
      suppressWarnings: true,
      navigateFallback: "/",
      navigateFallbackAllowlist: [/^\/$/],
      type: "module",
    },

    registerWebManifestInRouteRules: true,

    client: {
      periodicSyncForUpdates: 3600,
      installPrompt: true,
    },
  },
  runtimeConfig: {
    jwtPrivateKey: "",
    jwtPublicKey: "",
  },
  typescript: {
    tsConfig: {
      exclude: ["../service-worker"],
    },
    typeCheck: false,
    strict: true,
  },
});
