import { defineStore } from "pinia";

export const useMyProfileStore = defineStore({
  id: "myProfileStore",
  state: () => ({
    firstName: "",
    lastName: "",
    accessToken: "",
    roles: [],
  }),
  actions: {
    async authenticate(credentials: { email: string; password: string }) {
      const token = await $fetch("/api/admin/login", {
        method: "POST",
        body: credentials,
        async onResponseError({ response }) {
          if (response.status === 403) {
            console.log(response);
            return;
          }
        },
      });
    },
  },
});
