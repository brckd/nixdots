export default (monitor = 0) =>
  Widget.Window({
    monitor,
    name: `bar-${monitor}`,
    anchor: ["top", "left", "right"],
    exclusivity: "exclusive",
    child: Widget.CenterBox({
      startWidget: Widget.Box({
        hexpand: true,
        hpack: "start",
        child: Widget.Icon("nixos-symbolic"),
      }),
      centerWidget: Widget.Box({
        hpack: "center",
        child: Widget.Label().poll(
          1000,
          (self) => (self.label = Utils.exec("date")),
        ),
      }),
      endWidget: Widget.Box({
        hexpand: true,
        hpack: "end",
        child: Widget.Icon("nixos-symbolic"),
      }),
    }),
  });
