import Koa from "koa";
import Router from "@koa/router";
import cors from "@koa/cors";
import logger from "koa-logger";
import { initPopulation } from "./app/population/init-population.js";
import { loadConfig } from "./app/db.js";
import { evolvePopulation } from "./app/population/evolve-population.js";

await loadConfig();

const app = new Koa();
const router = new Router();

app.use(logger());
app.use(cors());

router.get("/", (ctx) => {
  ctx.type = "html";
  ctx.body = [
    "Usable routes :",
    "",
    'GET <a href="http://localhost:3000/initialize-population">/initialize-population</a>',
    'GET <a href="http://localhost:3000/reset-population">/reset-population</a>',
    'GET <a href="http://localhost:3000/evolve-population">/evolve-population</a>',
  ].join("<br>");
});

router.get("/initialize-population", async (ctx) => {
  const pop = await initPopulation();
  ctx.body = {
    status: "success",
    json: pop,
  };
});

router.get("/evolve-population", async (ctx) => {
  const pop = await evolvePopulation();
  ctx.body = {
    status: "success",
    json: pop,
  };
});

app.use(router.routes()).use(router.allowedMethods());

app.listen(3000);
console.log("Server started on: http://localhost:3000");
