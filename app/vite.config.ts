import path from "node:path";
import { defineConfig, loadEnv } from "vite";
import react from "@vitejs/plugin-react-swc";

// https://vitejs.dev/config/
export default ({ mode }) => {
  process.env = { ...process.env, ...loadEnv(mode, process.cwd()) };

  return defineConfig({
    base: process.env.VITE_APP_BASE_PATH || "",
    build: {
      outDir: "build",
      sourcemap: true,
      rollupOptions: {
        output: {
          entryFileNames: "assets/js/[name]-[hash].js",
          chunkFileNames: "assets/js/[name]-[hash].js",
          assetFileNames: ({ name }) => {
            const css = /\.(css)$/.test(name ?? "");
            const font = /\.(woff|woff2|eot|ttf|otf)$/.test(name ?? "");
            const media = /\.(png|jpe?g|gif|svg|webp|webm|mp3)$/.test(name ?? ""); // prettier-ignore
            const type = css ? "css/" : font ? "fonts/" : media ? "media/" : "";
            return `assets/${type}[name]-[hash][extname]`;
          },
        },
      },
    },
    define: {
      "process.env": {},
    },
    plugins: [react()],
    resolve: {
      alias: {
        "@": path.resolve(__dirname, "./src"),
      },
    },
    server: {
      open: true,
      port: 3000,
    },
  });
};
