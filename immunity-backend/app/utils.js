const promiseProps = async (x) => {
  const values = await Promise.all(Object.values(x));
  return Object.fromEntries(Object.keys(x).map((prop, i) => [prop, values[i]]));
};

export { promiseProps };
