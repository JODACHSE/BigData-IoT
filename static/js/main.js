// ========================================
// SISTEMA DE TEMA DARK/LIGHT
// ========================================

document.addEventListener('DOMContentLoaded', function() {
  
  // Inicializar tema
  initTheme();
  
  // Agregar botón de cambio de tema al navbar
  addThemeToggleButton();
  
  // Actualizar logo según tema
  updateLogo();
  
  // Animaciones al scroll
  initScrollAnimations();
  
});

/**
 * Inicializa el tema guardado en localStorage
 */
function initTheme() {
  const savedTheme = localStorage.getItem('theme') || 'dark';
  document.documentElement.setAttribute('data-bs-theme', savedTheme);
}

/**
 * Agrega el botón de cambio de tema al navbar
 */
function addThemeToggleButton() {
  const navbar = document.querySelector('.navbar-collapse');
  
  if (navbar) {
    const themeToggle = document.createElement('button');
    themeToggle.className = 'theme-toggle';
    themeToggle.setAttribute('aria-label', 'Cambiar tema');
    themeToggle.innerHTML = '<i class="bi bi-moon-stars-fill"></i>';
    
    // Insertar el botón después del navbar-text
    const navbarText = document.querySelector('.navbar-text');
    if (navbarText) {
      navbarText.parentElement.appendChild(themeToggle);
    }
    
    // Actualizar icono según tema actual
    updateThemeIcon(themeToggle);
    
    // Listener para cambiar tema
    themeToggle.addEventListener('click', function() {
      toggleTheme();
      updateThemeIcon(themeToggle);
      updateLogo();
    });
  }
}

/**
 * Cambia entre tema dark y light
 */
function toggleTheme() {
  const currentTheme = document.documentElement.getAttribute('data-bs-theme');
  const newTheme = currentTheme === 'dark' ? 'light' : 'dark';
  
  document.documentElement.setAttribute('data-bs-theme', newTheme);
  localStorage.setItem('theme', newTheme);
  
  // Animación suave
  document.body.style.transition = 'background-color 0.3s ease, color 0.3s ease';
}

/**
 * Actualiza el icono del botón de tema
 */
function updateThemeIcon(button) {
  const currentTheme = document.documentElement.getAttribute('data-bs-theme');
  const icon = button.querySelector('i');
  
  if (currentTheme === 'dark') {
    icon.className = 'bi bi-moon-stars-fill';
  } else {
    icon.className = 'bi bi-sun-fill';
  }
}

/**
 * Actualiza el logo del footer según el tema
 */
function updateLogo() {
  const logo = document.getElementById('logo');
  if (!logo) return;
  
  const currentTheme = document.documentElement.getAttribute('data-bs-theme');
  const darkSrc = logo.getAttribute('data-dark-src');
  const lightSrc = logo.getAttribute('data-light-src');
  
  if (currentTheme === 'dark' && darkSrc) {
    logo.src = darkSrc;
  } else if (currentTheme === 'light' && lightSrc) {
    logo.src = lightSrc;
  }
}

/**
 * Inicializa animaciones al hacer scroll
 */
function initScrollAnimations() {
  const observerOptions = {
    threshold: 0.1,
    rootMargin: '0px 0px -50px 0px'
  };
  
  const observer = new IntersectionObserver(function(entries) {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        entry.target.classList.add('fade-in-up');
        observer.unobserve(entry.target);
      }
    });
  }, observerOptions);
  
  // Observar elementos con la clase 'animate-on-scroll'
  const animatedElements = document.querySelectorAll('.animate-on-scroll');
  animatedElements.forEach(el => observer.observe(el));
}

/**
 * Función auxiliar para crear efectos de partículas (opcional)
 */
function createParticleEffect(container) {
  const particle = document.createElement('div');
  particle.className = 'particle';
  particle.style.cssText = `
    position: absolute;
    width: 4px;
    height: 4px;
    background: var(--color-accent-primary);
    border-radius: 50%;
    pointer-events: none;
    animation: float 3s ease-in-out infinite;
  `;
  
  particle.style.left = Math.random() * 100 + '%';
  particle.style.animationDelay = Math.random() * 3 + 's';
  
  container.appendChild(particle);
  
  setTimeout(() => particle.remove(), 3000);
}

/**
 * Efecto hover para cards
 */
document.addEventListener('mouseover', function(e) {
  if (e.target.closest('.futuristic-card')) {
    const card = e.target.closest('.futuristic-card');
    card.style.transition = 'all 0.3s ease';
  }
});

/**
 * Efecto de clic en botones futuristas
 */
document.addEventListener('click', function(e) {
  if (e.target.closest('.btn-futuristic')) {
    const button = e.target.closest('.btn-futuristic');
    button.style.transform = 'scale(0.95)';
    setTimeout(() => {
      button.style.transform = '';
    }, 150);
  }
});

/**
 * Marcar el link activo en el navbar
 */
function setActiveNavLink() {
  const currentPath = window.location.pathname;
  const navLinks = document.querySelectorAll('.nav-link');
  
  navLinks.forEach(link => {
    const href = link.getAttribute('href');
    if (href === currentPath || (href !== '#' && currentPath.includes(href))) {
      link.classList.add('active');
    } else {
      link.classList.remove('active');
    }
  });
}

// Ejecutar al cargar la página
setActiveNavLink();

// ========================================
// ANIMACIÓN CSS ADICIONAL PARA PARTÍCULAS
// ========================================

const style = document.createElement('style');
style.textContent = `
  @keyframes float {
    0%, 100% {
      transform: translateY(0) scale(1);
      opacity: 0;
    }
    50% {
      transform: translateY(-100px) scale(1.5);
      opacity: 1;
    }
  }
`;
document.head.appendChild(style);
