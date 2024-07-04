const hyprland = await Service.import("hyprland");
const apps = await Service.import("applications");
import GLib from "gi://GLib?version=2.0";

export function normalizeAppName(name: string) {
  return name.toLowerCase().replace(/[^a-z]/, "");
}

export function matchApp(
  app: (typeof apps.list)[number],
  client: (typeof hyprland.clients)[number],
) {
  const appName = normalizeAppName(app.name);
  const appDesktop = app.desktop && normalizeAppName(app.desktop);
  const clientTitle = normalizeAppName(client.initialTitle);
  const clientClass = normalizeAppName(client.initialClass);

  if (app.match(client.class)) return 4;
  if (clientTitle.includes(appName)) return 3;
  if (appDesktop?.includes(clientTitle)) return 2;
  if (appDesktop?.includes(clientClass)) return 1;
  return 0;
}

export function matchApps(client: (typeof hyprland.clients)[number]) {
  return apps.list
    .filter((a) => matchApp(a, client))
    .sort((a, b) => matchApp(b, client) - matchApp(a, client));
}

export function iconExists(name: string) {
  if (Utils.lookUpIcon(name)) return true;
  if (GLib.file_test(name, GLib.FileTest.EXISTS)) return true;
  return false;
}

export function getIcon(client: (typeof hyprland.clients)[number]) {
  const fallback = "application-x-executable";
  const matchingApps = matchApps(client);

  for (const app of matchingApps) {
    const icon = `${app.icon_name}`;
    if (iconExists(icon)) return icon;
  }
  return fallback;
}

export const TaskBarItem = (client: (typeof hyprland.clients)[number]) =>
  Widget.Button({
    className: "tasks button",
    child: Widget.Icon(getIcon(client)),
    onClicked: () =>
      hyprland.messageAsync(`dispatch focuswindow address:${client.address}`),
  });

export function sortedClients(clients: typeof hyprland.clients) {
  return clients
    .toReversed()
    .toSorted((a, b) => a.workspace.id - b.workspace.id);
}

export const TaskBar = () =>
  Widget.Box({
    className: "tasks menu-bar",
    spacing: 5,
    children: hyprland
      .bind("clients")
      .as((c) => sortedClients(c).map(TaskBarItem)),
  });

export default TaskBar;
