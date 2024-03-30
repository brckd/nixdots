import Bar from "./widget/Bar";

App.addIcons(`${App.configDir}/assets`);
App.config({
  windows: [Bar(0)],
  style: `${App.configDir}/style.css`,
});
