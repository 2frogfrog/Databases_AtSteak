document.addEventListener('DOMContentLoaded', () => {

    const thead = document.getElementById('RecipeTableHeader');
    const tbody = document.getElementById('RecipeTableBody');
    const input = document.getElementById('searchInput'); // Make sure this exists in your HTML

    // Initial load
    fetchAndRender('/api/recipes');

    // Keyup listener for live search
    let debounceTimer;
    input.addEventListener('keyup', () => {
        clearTimeout(debounceTimer);
        debounceTimer = setTimeout(() => {
            const query = input.value.trim();
            if (query === '') {
                fetchAndRender('/api/recipes'); // fallback to default
            } else {
                fetchAndRender('/api/recipes/search', { query });
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
            .then(data => renderTable(data, tbody, thead))
            .catch(err => {
                console.error('Error loading data:', err);
                tbody.innerHTML = `<tr><td colspan="100%">Error loading data</td></tr>`;
            });
    }

    // Modular table renderer
    function renderTable(data, tbody, thead) {
        if (!Array.isArray(data) || data.length === 0) {
            thead.innerHTML = '';
            tbody.innerHTML = `<tr><td colspan="100%">No data found</td></tr>`;
            return;
        }


        // Extract and render column headers from the first row's keys
        const columnNames = Object.keys(data[0]);
        //thead.innerHTML = '';
        thead.innerHTML = '<tr>' + columnNames.map(col => `<th>${col}</th>`).join('') + '</tr>';

        tbody.innerHTML = ''; // Clear existing rows in the body
        data.forEach(row => {
            const tr = document.createElement('tr');
            tr.innerHTML = columnNames.map(
                col => `<td>${row[col]}</td>`).join('');
            tbody.appendChild(tr);
        });
    }
});