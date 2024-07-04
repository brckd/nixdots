const systemtray = await Service.import("systemtray");

const SysTrayItem = (item: (typeof systemtray.items)[number]) =>
  Widget.Button({
    className: "systray button",
    tooltipMarkup: item.bind("tooltip_markup"),
    child: Widget.Icon({
      icon: item.bind("icon"),
    }),
    onPrimaryClick: (_, event) => item.activate(event),
    onSecondaryClick: (_, event) => item.openMenu(event),
  });

export const SysTray = () =>
  Widget.Box({
    className: "systray menu-bar",
    children: systemtray.bind("items").as((i) => i.map(SysTrayItem)),
  });

export default SysTray;
