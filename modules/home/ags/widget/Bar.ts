import Launcher from "./Launcher";
import Workspaces from "./Workspaces";
import TaskBar from "./TaskBar";
import Clock from "./Clock";
import SysTray from "./SysTray";
import Volume from "./Volume";
import Battery from "./Battery";
import PowerMenu from "./PowerMenu";

export const Start = () =>
  Widget.Box({
    hexpand: true,
    hpack: "start",
    spacing: 20,
    children: [Launcher(), Workspaces(), TaskBar()],
  });

export const Center = () =>
  Widget.Box({
    hpack: "center",
    child: Clock(),
  });

export const End = () =>
  Widget.Box({
    hexpand: true,
    hpack: "end",
    spacing: 20,
    children: [SysTray(), Volume(), Battery(), PowerMenu()],
  });

export const Bar = (monitor = 0) =>
  Widget.Window({
    monitor,
    name: `bar-${monitor}`,
    anchor: ["top", "left", "right"],
    exclusivity: "exclusive",
    child: Widget.CenterBox({
      className: "bar",
      startWidget: Start(),
      centerWidget: Center(),
      endWidget: End(),
    }),
  });

export default Bar;
