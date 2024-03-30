import Bar from "./widget/Bar";
// @ts-ignore
import style from "./style.scss";

App.addIcons(`${App.configDir}/assets`);
App.applyCss(style);
App.config({ windows: [Bar(0)] });
