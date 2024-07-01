import GLib from "gi://GLib";

export const clock = Variable(GLib.DateTime.new_now_local(), {
    poll: [1000, () => GLib.DateTime.new_now_local()],
})

export const time = Utils.derive([clock], (c) => c.format("%B %d - %H:%M") ?? "")

export const Start = () =>
  Widget.Box({
    hexpand: true,
    hpack: "start",
    child: Widget.Icon("nixos-symbolic"),
  });

export const Center = () =>
  Widget.Box({
    hpack: "center",
    child: Widget.Label({
			label: time.bind(),
		})
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
