export const PowerButton = (command: string, icon: string) =>
  Widget.Button({
    className: "power button",
    child: Widget.Icon(icon),
    onClicked: () => Utils.execAsync(command),
  });

export const PowerMenu = () =>
  Widget.Box({
    className: "power menu-bar",
    children: [PowerButton("shutdown now", "system-shutdown-symbolic")],
  });

export default PowerMenu;
