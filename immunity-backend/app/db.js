import process from "node:process";
import fs from "fs-extra";
import Datastore from "nedb-promises";
import * as R from "ramda";

const database = {
  population: Datastore.create("./db/population.db"),
  config: Datastore.create("./db/config.db"),
};
await fs.ensureDir("./db/");
R.map((d) => d.setAutocompactionInterval(10000), database);

// POPULATION
const retrievePopulation = () => database.population.find({});

const savePopulation = async (pop) => {
  await database.population.deleteMany({});
  return database.population.insert(pop);
};
const updatePopulation = async (pop) => {
  await Promise.all(
    R.map(
      (person) => database.population.update({ _id: person._id }, person),
      pop,
    ),
  );

  return retrievePopulation();
};

// CONFIG
const _configToEnv = (cfg) => {
  process.env.transmissionFactor = cfg.transmissionFactor;
  process.env.popSize = cfg.popSize;
  process.env.initialPercentHealthy = cfg.initialPercentHealthy;
  process.env.recoveryTime = cfg.recoveryTime;
};

const loadConfig = async () => {
  const cfg = await database.config.findOne({});
  _configToEnv(cfg);
};

const saveConfig = async (cfg) => {
  _configToEnv(cfg);
  await database.config.deleteMany({});
  return database.config.insert(cfg);
};

export {
  savePopulation,
  retrievePopulation,
  updatePopulation,
  saveConfig,
  loadConfig,
};
