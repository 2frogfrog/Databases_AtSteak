document.addEventListener('DOMContentLoaded', () => {
    const tbody = document.getElementById('ingredientTableBody');
    const input = document.getElementById('searchInput'); // Make sure this exists in your HTML

    // Initial load
    fetchAndRender('/api/ingredients');

    // Keyup listener for live search
    let debounceTimer;
    input.addEventListener('keyup', () => {
        clearTimeout(debounceTimer);
        debounceTimer = setTimeout(() => {
            const query = input.value.trim();
            if (query === '') {
                fetchAndRender('/api/ingredients'); // fallback to default
            } else {
                fetchAndRender('/api/ingredients/search', { query });
            }
        }, 300); // debounce delay
    });

    // Modular fetch + render
    function fetchAndRender(endpoint, payload = null) {
        const options = payload
            ? {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(payload)
            }
            : {};

        fetch(endpoint, options)
            .then(res => res.json())
            .then(data => renderTable(data, tbody))
            .catch(err => {
                console.error('Error loading data:', err);
                tbody.innerHTML = `<tr><td colspan="100%">Error loading data</td></tr>`;
            });
    }

    // Modular table renderer
    function renderTable(data, tbody) {
        if (!Array.isArray(data) || data.length === 0) {
            tbody.innerHTML = `<tr><td colspan="100%">No data found</td></tr>`;
            return;
        }

        tbody.innerHTML = ''; // Clear existing rows
        data.forEach(row => {
            const tr = document.createElement('tr');
            tr.innerHTML = Object.values(row)
                .map(value => `<td>${value}</td>`)
                .join('');
            tbody.appendChild(tr);
        });
    }
});