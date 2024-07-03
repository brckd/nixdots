import GLib from "gi://GLib";

export const clock = Variable(GLib.DateTime.new_now_local(), {
  poll: [1000, () => GLib.DateTime.new_now_local()],
});

export const time = Utils.derive(
  [clock],
  (c) => c.format("%B %d - %H:%M") ?? "",
);

export const Clock = () => Widget.Label({ label: time.bind() });

export default Clock;
