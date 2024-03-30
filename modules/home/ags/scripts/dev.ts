import { build, logOutput } from "./build";
import { watch } from "./watch";
import { start, restart } from "./start";
import { benchmark } from "./log";

if (import.meta.main) {
  const output = await benchmark(build(), "build");
  logOutput(output);
  start();
  for await (const { filename } of watch(`${import.meta.dir}/..`)) {
    const output = await benchmark(build(), "build", filename!);
    logOutput(output);
    restart();
  }
}
