import type { BuildOutput, BuildConfig as BunBuildConfig } from "bun";
import sassPlugin from "./sassPlugin";
import { benchmark } from "./log";

export interface BuildConfig extends Partial<BunBuildConfig> {}

export function build(config?: BuildConfig) {
  return Bun.build({
    entrypoints: ["./config.ts"],
    outdir: ".",
    external: ["resource://*", "gi://*"],
    plugins: [sassPlugin],
    ...config,
  });
}

export async function logOutput(output: BuildOutput) {
  if (output.logs.length) {
    console.log(output.logs.join("\n"));
  }
}

if (import.meta.main) {
  const output = await benchmark(build(), "build");
  logOutput(output);
}
