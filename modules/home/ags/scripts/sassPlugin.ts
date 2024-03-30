import { type BunPlugin } from "bun";

export const sassPlugin: BunPlugin = {
  name: "Sass",
  async setup(build) {
    const { compile } = await import("sass");

    build.onLoad({ filter: /\.(scss|sass)$/ }, (args) => {
      const result = compile(args.path);
      return {
        contents: result.css,
        loader: "text",
      };
    });
  },
};

export default sassPlugin;
