const audio = await Service.import("audio");

export enum Type {
  Speaker = "speaker",
  Microphone = "microphone",
}

export const VolumeSlider = (type = Type.Speaker, scale = 5) =>
  Widget.Slider({
    className: "progress",
    hexpand: true,
    drawValue: false,
    max: 1 / scale,

    onChange: ({ value }) => (audio[type].volume = value * scale),
    value: audio[type].bind("volume").as((v) => v / scale),
  });

export function getIcon(volume: number, isMuted?: boolean | null) {
  const icons = ["muted", "low", "medium", "high", "overamplified"];
  const i = isMuted ? 0 : Math.ceil(volume * (icons.length - 1));
  return `audio-volume-${icons[i]}-symbolic`;
}

export const VolumeIcon = (type = Type.Speaker) =>
  Widget.Button({
    className: "button",
    child: Widget.Icon({
      icon: Utils.merge(
        [audio[type].bind("volume"), audio[type].bind("is_muted")],
        getIcon,
      ),
    }),
    onClicked: () => (audio[type].is_muted = !audio[type].is_muted),
  });

export const Volume = (type = Type.Speaker) =>
  Widget.Box({
    className: "volume-slider",
    children: [VolumeIcon(type), VolumeSlider(type)],
    spacing: 5,
  });

export default Volume;
