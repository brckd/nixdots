const hyprland = await Service.import("hyprland");
const apps = await Service.import("applications");
import GLib from "gi://GLib?version=2.0";

export function getIcon(client: (typeof hyprland.clients)[number]) {
  const fallback = "application-x-executable";

  const app = apps.list.find((app) => app.match(client.class));
  if (!app?.icon_name) return fallback;

  console.log(app.icon_name);
  const icon = `${app.icon_name}-symbolic`;
  if (Utils.lookUpIcon(icon)) return icon;
  if (GLib.file_test(icon, GLib.FileTest.EXISTS)) return icon;
  return fallback;
}

export const TaskBarItem = (client: (typeof hyprland.clients)[number]) =>
  Widget.Button({
    className: "tasks button",
    child: Widget.Icon(getIcon(client)),
    onClicked: () =>
      hyprland.messageAsync(`dispatch focuswindow address:${client.address}`),
  });

export const TaskBar = () =>
  Widget.Box({
    className: "tasks menu-bar",
    spacing: 5,
    children: hyprland.bind("clients").as((c) => c.map(TaskBarItem)),
  });

export default TaskBar;
