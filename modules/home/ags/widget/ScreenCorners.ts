export const ScreenCorners = (monitor = 0) =>
  Widget.Window({
    monitor: monitor,
    name: `screen-corners-${monitor}`,
    className: "screen-corners",
    anchor: ["top", "bottom", "right", "left"],
    clickThrough: true,
    child: Widget.Box({
      class_name: "corners",
      expand: true,
    }),
  });

export default ScreenCorners;
