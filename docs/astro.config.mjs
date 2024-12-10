import { defineConfig } from "astro/config";
import starlight from "@astrojs/starlight";

export default defineConfig({
  integrations: [
    starlight({
      title: "NixDots",
      social: {
        github: "https://github.com/brckd/nixdots",
      },
      sidebar: [
        {
          label: "Getting Started",
          items: [
            { slug: "getting-started/set-up-nix" },
            { slug: "getting-started/install-nixdots" },
          ],
        },
        {
          label: "Features",
          items: [
            { slug: "features/secure-boot" },
            { slug: "features/tpm-disk-unlock" },
          ],
        },
      ],
    }),
  ],
});
