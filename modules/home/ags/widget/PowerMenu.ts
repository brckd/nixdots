export const PowerButton = (command: string, icon: string) =>
  Widget.Button({
    onClicked: () => Utils.exec(command),
    child: Widget.Icon(icon),
  });

export const PowerMenu = () =>
  Widget.Box({
    className: "powermenu",
    children: [PowerButton("shutdown now", "system-shutdown-symbolic")],
  });

export default PowerMenu;
