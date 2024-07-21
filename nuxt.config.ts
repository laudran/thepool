// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  extends: [
    "gh:cssninjaStudio/tairo/layers/tairo#v1.5.1",
    "gh:cssninjaStudio/tairo/layers/tairo-layout-sidebar#v1.5.1",
  ],
  typescript: {
    tsConfig: {
      exclude: ["../service-worker"],
    },
  },

  devtools: { enabled: true },

  nitro: {
    prerender: {
      routes: ["/"],
    },
  },

  modules: ["@vite-pwa/nuxt"],

  pwa: {
    strategies: "injectManifest",
    srcDir: "service-worker",
    filename: "sw.ts",
    registerType: "prompt",
    injectRegister: false,

    pwaAssets: {
      disabled: false,
      config: true,
    },

    manifest: {
      name: "eauvive",
      short_name: "eauvive",
      description: "Eauvive gestion",
      theme_color: "#ffffff",
    },

    injectManifest: {
      globPatterns: ["**/*.{js,css,html,svg,png,ico}"],
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
    databaseName: "poolside",
    databaseUser: "m9metxf5xc8c",
    databasePassword: "jwMoyX1ANpYK1fF3oiej6w",
  },
});
