// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  compatibilityDate: '2025-07-15',
  components: true,
  devtools: { enabled: true },
  nitro: {
    compressPublicAssets: true
  },
  runtimeConfig: {
    apiSecretPath: "API_SECRET_PATH",
    apiSecretKey: "API_SECRET_KEY",
    apiBaseUrl: "API_BASE_URL"



  },
  app: {
    baseURL: '/',
  },
  css: [
    '~/styles/default.css',
    '~/styles/tailwind.css',
    '~/styles/main.scss',
  ],
  postcss: {
    plugins: {
      tailwindcss: {},
      autoprefixer: {},
    },
  },
  modules: [['@nuxtjs/google-fonts', {
    // families: {
    //   'Montserrat': [100, 200, 300, 400, 500, 600, 700, 800, 900],
    //   'Urbanist': [100, 200, 300, 400, 500, 600, 700, 800, 900],
    //   },
      families: {
        'SF Pro': [100, 200, 300, 400, 500, 600, 700, 800, 900],
        'Joane': [100, 200, 300, 400, 500, 600, 700, 800, 900],
        'Roboto': [100, 300, 400, 500, 600, 700, 800, 900],
        'DM Serif Display': [400, 500, 600, 700, 800, 900],
      },
      display: 'swap',
    }], 
    '@pinia/nuxt',
    
    ['@nuxtjs/tailwindcss', {
        exposeConfig: true,
        viewer: true,
      }
    ]
  ],
  alias: {
    '@': './',
    '~': './'
  },
  typescript: {
    strict: false,
  },
  experimental: {
    componentIslands: true,
  },

})
