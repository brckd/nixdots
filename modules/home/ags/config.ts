import Bar from "./widget/Bar";
import ScreenCorners from "./widget/ScreenCorners";
// @ts-ignore
import style from "./style/main.scss";

App.addIcons(`${App.configDir}/assets`);
App.applyCss(style);
App.config({ windows: [Bar(0), ScreenCorners(0)] });
