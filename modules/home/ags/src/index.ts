import Bar from "./widget/Bar";

App.addIcons(`${App.configDir}/src/assets`);
App.config({
	windows: [Bar(0)],
	style: `${App.configDir}/src/style/global.css`,
});
