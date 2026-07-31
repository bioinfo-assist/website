import { defineConfig } from 'vite'
import { resolve } from 'path'

export default defineConfig({
  // The Vite outDir (static/assets) is served at /assets/ by Hugo,
  // so asset URLs must be generated relative to that mount point.
  base: '/assets/',
  publicDir: false,
  build: {
    outDir: 'static/assets',
    rollupOptions: {
      input: {
        main: resolve(import.meta.dirname, 'src/main.js'),
        styles: resolve(import.meta.dirname, 'src/styles.scss')
      },
      output: {
        entryFileNames: 'js/[name].js',
        chunkFileNames: 'js/[name].js',
        assetFileNames: (assetInfo) => {
          if (assetInfo.name.endsWith('.css')) {
            return 'css/[name][extname]'
          }
          return 'assets/[name][extname]'
        }
      }
    },
    emptyOutDir: true
  },
  css: {
    preprocessorOptions: {
      scss: {
        quietDeps: true
      }
    }
  }
})
