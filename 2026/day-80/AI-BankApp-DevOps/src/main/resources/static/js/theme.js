(function () {
    const STORAGE_KEY = 'bankapp-theme';

    function getPreferred() {
        const stored = localStorage.getItem(STORAGE_KEY);
        if (stored) return stored;
        return window.matchMedia('(prefers-color-scheme: light)').matches ? 'light' : 'dark';
    }

    function apply(theme) {
        document.documentElement.setAttribute('data-theme', theme);
        localStorage.setItem(STORAGE_KEY, theme);
        const icon = document.getElementById('themeIcon');
        if (icon) {
            icon.className = theme === 'dark' ? 'bi bi-sun-fill' : 'bi bi-moon-fill';
        }
    }

    // Apply immediately to prevent flash
    apply(getPreferred());

    document.addEventListener('DOMContentLoaded', function () {
        const btn = document.getElementById('themeToggle');
        if (btn) {
            btn.addEventListener('click', function () {
                const current = document.documentElement.getAttribute('data-theme') || 'dark';
                apply(current === 'dark' ? 'light' : 'dark');
            });
        }
        // Re-apply to update icon after DOM is ready
        apply(getPreferred());
    });
})();
