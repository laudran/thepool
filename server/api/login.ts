export default defineEventHandler((event) => {
  const from = getQuery(event)?.from || "tairo";

  return `Hello moto`;
});
