import { fileURLToPath, URL } from 'node:url'

import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import vueDevTools from 'vite-plugin-vue-devtools'
const BACKEND_HOST = 'http://127.0.0.1:8000'
const BACKEND_HOST2 = '127.0.0.1'
// https://vite.dev/config/
export default defineConfig({
  plugins: [vue(), vueDevTools()],
  preview: {
    port: 8080,
  },
  server: {
    port: 8080,
    host: '127.0.0.1',
    proxy: {
      '^/api': {
        target: BACKEND_HOST,
        ws: true,
        changeOrigin: true,
        bypass: (req) => {
          if (req.headers && req.headers.referer)
            req.headers.referer = req.headers.referer.replace('http://127.0.0.1:8080', BACKEND_HOST)
          req.headers.host = req.headers.host.replace('127.0.0.1:8080', BACKEND_HOST2)
        },
      },
      '^/admin': {
        target: BACKEND_HOST,
        ws: true,
        changeOrigin: true,
        bypass: (req) => {
          if (req.headers && req.headers.referer)
            req.headers.referer = req.headers.referer.replace('http://127.0.0.1:8080', BACKEND_HOST)
          req.headers.host = req.headers.host.replace('127.0.0.1:8080', BACKEND_HOST2)
        },
      },

      '^/media': {
        target: BACKEND_HOST,
        ws: true,
        changeOrigin: true,
        bypass: (req) => {
          if (req.headers && req.headers.referer)
            req.headers.referer = req.headers.referer.replace('http://127.0.0.1:8080', BACKEND_HOST)
          req.headers.host = req.headers.host.replace('127.0.0.1:8080', BACKEND_HOST2)
        },
      },
      '^/static': {
        target: BACKEND_HOST,
        ws: true,
        changeOrigin: true,
        bypass: (req) => {
          if (req.headers && req.headers.referer)
            req.headers.referer = req.headers.referer.replace('http://127.0.0.1:8080', BACKEND_HOST)
          req.headers.host = req.headers.host.replace('127.0.0.1:8080', BACKEND_HOST2)
        },
      },
      '^/accounts/login': {
        target: BACKEND_HOST,
        ws: true,
        changeOrigin: true,
        bypass: (req) => {
          if (req.headers && req.headers.referer)
            req.headers.referer = req.headers.referer.replace('http://127.0.0.1:8080', BACKEND_HOST)
          req.headers.host = req.headers.host.replace('127.0.0.1:8080', BACKEND_HOST2)
        },
      },
    },
  },
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url)),
    },
  },
})
