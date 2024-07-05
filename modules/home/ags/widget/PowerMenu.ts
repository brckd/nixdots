const hyprland = await Service.import("hyprland");

export const LogOutButton = () =>
  Widget.Button({
    className: "power button",
    child: Widget.Icon("system-log-out-symbolic"),
    onClicked: () => hyprland.messageAsync("dispatch exit"),
  });

export const ShutdownButton = () =>
  Widget.Button({
    className: "power button",
    child: Widget.Icon("system-shutdown-symbolic"),
    onClicked: () => Utils.execAsync("shutdown now"),
  });

export const PowerMenu = () =>
  Widget.Box({
    className: "power menu-bar",
    spacing: 5,
    children: [LogOutButton(), ShutdownButton()],
  });

export default PowerMenu;
