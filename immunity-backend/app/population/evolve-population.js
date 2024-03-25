import process from "node:process";
import * as R from "ramda";
import { retrievePopulation, savePopulation, updatePopulation } from "../db.js";

const _getIllPercentage = R.converge(R.divide, [
  R.pipe(R.filter(R.prop("isIll")), R.length),
  R.length,
]);

const _transmissionCompute = (pop) => () =>  _getIllPercentage(pop) * Math.random() <
  Number(process.env.transmissionFactor);



const _isIll = R.propEq(true, "isIll");

const _isGettingIll = (pop) =>
  R.unless(
    _isIll,
    R.converge(R.assoc("isIll"), [_transmissionCompute(pop), R.identity]),
  );

const _isRecovering = R.when(
  _isIll,
  R.pipe(
    R.ifElse(
      R.propEq(1, "recoveryTime"),
      R.assoc("isIll", false),
      R.when(
        R.propSatisfies((x) => x < 1, "recoveryTime"),
        R.converge(R.assoc("recoveryTime"), [
          () => Number(process.env.recoveryTime) + 1,
          R.identity,
        ]),
      ),
    ),
    R.over(R.lensProp("recoveryTime"), R.dec),
  ),
);

const evolvePopulation = async () => {
  const initialPopulation = await retrievePopulation();
  const pop = R.map(
    R.pipe(_isGettingIll(initialPopulation), _isRecovering),
    initialPopulation,
  );

  return updatePopulation(pop);
};

export { evolvePopulation };
