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

const recentClients = Variable([...hyprland.clients.map((c) => c.address)]);
const recentWorkspaces = Variable([...hyprland.workspaces.map((w) => w.id)]);
const sortedClients = Utils.derive([recentClients, recentWorkspaces], () => sortClients(hyprland.clients))

hyprland.active.connect("changed", (active) => {
  recentClients.setValue([active.client.address, ...recentClients.getValue()]);
  recentWorkspaces.setValue([
    active.workspace.id,
    ...recentWorkspaces.getValue(),
  ]);
});

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
    className: `tasks button ${client.address === hyprland.active.client.address ? "active" : ""}`,
		attribute: {address: client.address},
    child: Widget.Icon(getIcon(client)),
    onClicked: () =>
      hyprland.messageAsync(`dispatch focuswindow address:${client.address}`),
  });

export function sortClients(clients: typeof hyprland.clients) {
  const c = recentClients.getValue();
  const w = recentWorkspaces.getValue();
  return clients
    .toReversed()
    .toSorted((a, b) => a.workspace.id - b.workspace.id)
    .toSorted((a, b) => c.indexOf(a.address) - c.indexOf(b.address))
    .toSorted((a, b) => w.indexOf(a.workspace.id) - w.indexOf(b.workspace.id));
}


export const TaskBar = () =>
  Widget.Box({
    className: "tasks menu-bar",
    spacing: 5,
    children: sortedClients.bind().as(c => c.map(TaskBarItem)),
  });

export default TaskBar;
