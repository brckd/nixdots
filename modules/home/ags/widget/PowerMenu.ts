export const PowerButton = (command: string, icon: string) =>
  Widget.Button({
    onClicked: () => Utils.exec(command),
    child: Widget.Icon(icon),
  });

export const PowerMenu = () =>
  Widget.Box({
    className: "powermenu",
    children: [PowerButton("shutdown now", "nixos-symbolic")],
  });

export default PowerMenu;
