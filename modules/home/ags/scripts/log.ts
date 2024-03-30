export function format(name: string, ...reason: string[]) {
  return [`\x1b[32m${name}\x1b[0m`, ...reason].join(" ");
}

export function log(name: string, ...reason: string[]) {
  console.log(format(name, ...reason));
}

export async function benchmark(
  process: Promise<any>,
  name: string,
  ...reason: string[]
) {
  const message = format(name, ...reason);
  console.time(message);
  const result = await process;
  console.timeEnd(message);

  return result;
}
