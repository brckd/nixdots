export const Launcher = () =>
  Widget.Button({
    className: "launcher button",
    child: Widget.Icon("nixos-symbolic"),
    onClicked: () => Utils.execAsync("rofi -show drun"),
  });

export default Launcher;
