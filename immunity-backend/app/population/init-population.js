import * as R from "ramda";
import { saveConfig, savePopulation } from "../db.js";

const _initializePop = (initialPercentHealthy) =>
  R.pipe(
    R.repeat({ isIll: false, recoveryTime: 0 }),
    R.map(
      R.over(R.lensProp("isIll"), () => Math.random() > initialPercentHealthy),
    ),
  );

const initPopulation = async ({
  popSize = 50,
  initialPercentHealthy = 0.9,
  recoveryTime = 3,
  transmissionFactor = 0.05,
} = {}) => {
  const pop = _initializePop(initialPercentHealthy)(popSize);
  await saveConfig({
    popSize,
    initialPercentHealthy,
    recoveryTime,
    transmissionFactor,
  });

  return savePopulation(pop);
};

export { initPopulation };
