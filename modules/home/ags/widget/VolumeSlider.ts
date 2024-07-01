const audio = await Service.import("audio");

export const VolumeSlider = (type: "speaker" | "microphone" = "speaker") =>
  Widget.Box({
		className: "volume-slider",
    children: [
			Widget.Label({
				label: audio[type].bind("volume").transform(v => Math.round(v * 100).toString()),
			}),
      Widget.Slider({
        className: "slider",
        hexpand: true,
        drawValue: false,

        onChange: ({ value }) => (audio[type].volume = value),
        value: audio[type].bind("volume"),
      }),
    ],
  });

export default VolumeSlider;
