export default () => {
  return "Hello Util";
};

export function jsonResponse(data: Object) {
  return JSON.stringify(
    data,
    (key, value) => (typeof value === "bigint" ? value.toString() : value) // return everything else unchanged
  );
}
