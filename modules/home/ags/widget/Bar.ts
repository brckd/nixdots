import Workspaces from "./Workspaces";
import Clock from "./Clock";
import VolumeSlider from "./VolumeSlider";
import PowerMenu from "./PowerMenu";

export const Start = () =>
  Widget.Box({
    hexpand: true,
    hpack: "start",
    spacing: 10,
    children: [Widget.Icon("nixos-symbolic"), Workspaces()],
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
    spacing: 10,
    children: [VolumeSlider(), PowerMenu()],
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
