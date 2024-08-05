/** @type {import('tailwindcss').Config} */

const colors = require('tailwindcss/colors');

const generateTextShadowPresets = (colors, xOffset = '0px', yOffset = '0px', blurRadius = '12px', opacity = '0.6') => {
  const textShadowPresets = {};
  Object.keys(colors).forEach(colorKey => {
    if (typeof colors[colorKey] === 'object') {
      Object.keys(colors[colorKey]).forEach(shadeKey => {
        const shadeValue = colors[colorKey][shadeKey];
        if (typeof shadeValue === 'string') {
          textShadowPresets[`${colorKey}-${shadeKey}`] = `${xOffset} ${yOffset} ${blurRadius} rgba(${shadeValue.replace('#', '').match(/.{1,2}/g).map(x => parseInt(x, 16)).join(', ')}, ${opacity})`;
        }
      });
    }
  });
  return textShadowPresets;
};

module.exports = {
  content: [
    "./routes/**/*.html",
  ],
  theme: {
    extend: {
      maskImage: {
        'linear-gradient': 'linear-gradient(to bottom, #000 90%, transparent 100%)',
      },
      textShadow: generateTextShadowPresets(colors),
    },
  },
  plugins: [
    require('tailwindcss-textshadow'),
  ],
}
