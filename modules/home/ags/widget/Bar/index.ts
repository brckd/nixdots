export const Start = () =>
  Widget.Box({
    hexpand: true,
    hpack: "start",
    child: Widget.Icon("nixos-symbolic"),
  });

export const Center = () =>
  Widget.Box({
    hpack: "center",
    child: Widget.Label().poll(
      1000,
      (self) => (self.label = Utils.exec("date")),
    ),
  });

export const End = () =>
  Widget.Box({
    hexpand: true,
    hpack: "end",
    child: Widget.Icon("nixos-symbolic"),
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
