import { $ } from "bun";
import { log } from "./log";

export async function start(configPath = "./config.js") {
  return await $`ags --config ${configPath}`;
}

export async function stop() {
  return await $`ags --quit`;
}

export async function restart(configPath = "./config.js") {
  await stop();
  return await start(configPath);
}

if (import.meta.main) {
  log("start", "config.js");
  await start();
}
