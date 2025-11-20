import { defineConfig } from "astro/config";
import starlight from "@astrojs/starlight";
import catppuccin from "starlight-theme-catppuccin";

export default defineConfig({
  integrations: [
    starlight({
      title: "Nix Config",
      social: {
        codeberg: "https://codeberg.org/bricke/nix-config",
      },
      sidebar: [
        {
          label: "Getting Started",
          items: [
            { slug: "getting-started/set-up-nix" },
            { slug: "getting-started/install-nix-config" },
            { slug: "getting-started/file-tree" },
          ],
        },
        {
          label: "Features",
          items: [
            { slug: "features/disk-partitioning" },
            { slug: "features/secure-boot" },
            { slug: "features/tpm-disk-unlock" },
          ],
        },
      ],
      expressiveCode: {
        themes: ["catppuccin-mocha", "catppuccin-latte"],
      },
      plugins: [catppuccin()],
    }),
  ],
});
