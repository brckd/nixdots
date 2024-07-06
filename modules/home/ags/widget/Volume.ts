const audio = await Service.import("audio");

export enum Type {
  Speaker = "speaker",
  Microphone = "microphone",
}

export const VolumeSlider = (type = Type.Speaker) =>
  Widget.Slider({
    className: "progress",
    hexpand: true,
    drawValue: false,

    onChange: ({ value }) => (audio[type].volume = value),
    value: audio[type].bind("volume"),
  });

export function getIcon(volume: number, isMuted?: boolean | null) {
  const icons = ["muted", "low", "medium", "high", "overamplified"];
  const i = isMuted ? 0 : Math.ceil(volume * (icons.length - 1));
  return `audio-volume-${icons[i]}-symbolic`;
}

export const VolumeIcon = (type = Type.Speaker) =>
  Widget.Icon({
    icon: Utils.merge(
      [audio[type].bind("volume"), audio[type].bind("is_muted")],
      getIcon,
    ),
  });

export const Volume = (type = Type.Speaker) =>
  Widget.Box({
    className: "volume-slider",
    children: [VolumeIcon(type), VolumeSlider(type)],
    spacing: 5,
  });

export default Volume;
