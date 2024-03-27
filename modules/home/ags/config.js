const entry = `${App.configDir}/src/main.ts`;
const main = `/tmp/ags/main.js`;

await Utils.execAsync([
	"bun", "build", entry,
	"--outfile", main,
	"--external", "ressource://*",
	"--external", "gi://*",
	"--external", "file://*",
]).catch(console.error);

await import(`file://${main}`)
