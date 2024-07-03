const hyprland = await Service.import("hyprland");

export const Workspaces = (count = 10) =>
  Widget.Box({
    className: "workspaces",
    spacing: 3,
    children: Array.from({ length: count }, (_, id) =>
      Widget.Button({
        classNames: hyprland.active.workspace
          .bind("id")
          .as((i) => ["workspace", ...(i === id + 1 ? ["active"] : [])]),
        vpack: "center",
        onClicked: () => hyprland.messageAsync(`dispatch workspace ${id + 1}`),
      }),
    ),
  });

export default Workspaces;
