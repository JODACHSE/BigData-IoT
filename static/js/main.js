(() => {
    'use strict';

    const STORAGE_KEY = 'theme';

    const getStored = () => localStorage.getItem(STORAGE_KEY);
    const setStored = (t) => localStorage.setItem(STORAGE_KEY, t);

    const systemPrefersDark = () =>
        window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches;

    const getPreferred = () => getStored() || (systemPrefersDark() ? 'dark' : 'light');

    const updateThemedImages = (theme) => {
        document.querySelectorAll('img[data-dark-src][data-light-src]').forEach(img => {
            const next = theme === 'dark' ? img.getAttribute('data-dark-src') : img.getAttribute('data-light-src');
            if (next && img.getAttribute('src') !== next) img.setAttribute('src', next);
        });
    };

    const reflectToggleUI = (theme) => {
        const btn = document.getElementById('theme-toggle');
        if (!btn) return;
        const isDark = theme === 'dark';
        btn.classList.toggle('theme-toggle--toggled', isDark); // API del componente
        btn.setAttribute('aria-pressed', String(isDark));
        btn.setAttribute('title', isDark ? 'Tema oscuro' : 'Tema claro');
        btn.setAttribute('aria-label', isDark ? 'Cambiar a tema claro' : 'Cambiar a tema oscuro');
    };

    const applyTheme = (theme) => {
        document.documentElement.setAttribute('data-bs-theme', theme);
        reflectToggleUI(theme);
        updateThemedImages(theme);
    };

    // Inicializa
    document.addEventListener('DOMContentLoaded', () => {
        applyTheme(getPreferred());

        // Click del botón
        const btn = document.getElementById('theme-toggle');
        if (btn) {
            btn.addEventListener('click', () => {
                const current = document.documentElement.getAttribute('data-bs-theme') === 'dark' ? 'dark' : 'light';
                const next = current === 'dark' ? 'light' : 'dark';
                setStored(next);
                applyTheme(next);
            });
        }

        // Cambios del sistema solo si el usuario no ha elegido explícitamente
        const media = window.matchMedia('(prefers-color-scheme: dark)');
        if (media?.addEventListener) {
            media.addEventListener('change', () => {
                if (!getStored()) applyTheme(systemPrefersDark() ? 'dark' : 'light');
            });
        }

        // Sincroniza entre pestañas
        window.addEventListener('storage', (e) => {
            if (e.key === STORAGE_KEY) applyTheme(getPreferred());
        });
    });
})();
