document.addEventListener('DOMContentLoaded', () => {
  const styleSheet = document.createElement('style');
  styleSheet.type = 'text/css';
  styleSheet.innerText = `
@keyframes c_logo_animation {
0%, 100% { transform: translateY(8px); }
50% { transform: translateY(-12px); }
}

@keyframes cpp_logo_animation {
0%, 100% { transform: translateY(-20px); }
50% { transform: translateY(5px); }
}

@keyframes lua_logo_animation {
0%, 100% { transform: translateY(20px); }
50% { transform: translateY(0px); }
}

#c_logo {
animation: c_logo_animation 13s ease-in-out infinite;
}

#cpp_logo {
animation: cpp_logo_animation 2s ease-in-out infinite;
}

#lua_logo {
animation: lua_logo_animation 1s ease-in-out infinite;
}
`;
  document.head.appendChild(styleSheet);

  document.getElementById('c_logo').style.animation = 'c_logo_animation 3s ease-in-out infinite';
  document.getElementById('cpp_logo').style.animation = 'cpp_logo_animation 3s ease-in-out infinite';
  document.getElementById('lua_logo').style.animation = 'lua_logo_animation 3s ease-in-out infinite';
});
