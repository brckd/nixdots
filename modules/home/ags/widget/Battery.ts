const battery = await Service.import("battery");

const BatteryProgress = () =>
  Widget.LevelBar({
    className: "progress",
    widthRequest: 150,

    value: battery.bind("percent").as((p) => (p > 0 ? p / 100 : 0)),
    vpack: "center",
  });

export const BatteryIcon = () =>
  Widget.Icon({
    icon: battery.bind("icon_name"),
  });

export const Battery = () =>
  Widget.Box({
    classNames: battery
      .bind("charging")
      .as((ch) => ["battery", ch ? "charging" : ""]),
    children: [BatteryIcon(), BatteryProgress()],
    spacing: 5,
    visible: battery.bind("available"),
  });

export default Battery;
