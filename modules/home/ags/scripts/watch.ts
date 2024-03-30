import { watch as fsWatch } from "fs/promises";
import { build, logOutput } from "./build";
import { benchmark } from "./log";

interface WatchConfig {
  filename?: string | RegExp;
}

export async function* watch(dirname: string, config?: WatchConfig) {
  config ??= {};
  config.filename ??=
    /^(config\.ts|style\.scss|(widget|service|style|assets)\/.*\.\w+)$/;

  const watcher = fsWatch(dirname, { recursive: true });
  for await (const event of watcher) {
    const { filename } = event;
    if (typeof filename !== "string") continue;
    if (/\/\d+$/.test(filename)) continue;
    if (!filename.match(config.filename)) continue;
    yield event;
  }
}

if (import.meta.main) {
  const output = await benchmark(build(), "build");
  logOutput(output);
  for await (const { filename } of watch(`${import.meta.dir}/..`)) {
    const output = await benchmark(build(), "build", filename!);
    logOutput(output);
  }
}
