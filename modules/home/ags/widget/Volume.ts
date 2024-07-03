const audio = await Service.import("audio");

export enum Type {
  Speaker = "speaker",
  Microphone = "microphone",
}

export const VolumeSlider = (type = Type.Speaker) =>
  Widget.Slider({
    className: "slider",
    hexpand: true,
    drawValue: false,

    onChange: ({ value }) => (audio[type].volume = value),
    value: audio[type].bind("volume"),
  });

function getIcon(volume: number) {
  const icons = ["muted", "low", "medium", "high", "overamplified"];
  const i = Math.ceil(volume * (icons.length - 1));
  return `audio-volume-${icons[i]}-symbolic`;
}

export const VolumeIcon = (type = Type.Speaker) =>
  Widget.Icon({
    icon: audio[type].bind("volume").as((v) => getIcon(v)),
  });

export const Volume = (type = Type.Speaker) =>
  Widget.Box({
    className: "volume-slider",
    children: [VolumeIcon(type), VolumeSlider(type)],
  });

export default Volume;
