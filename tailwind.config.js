const colors = require('tailwindcss/colors')

module.exports = {
  purge: [
    './templates/**/*.html.ep',
    './public/css/app.css',
  ],
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {
      colors:{
        'light-blue': colors.sky,
        cyan: colors.cyan,
      }
    },
  },
  variants: {
    extend: {},
  },
  plugins: [],
}
