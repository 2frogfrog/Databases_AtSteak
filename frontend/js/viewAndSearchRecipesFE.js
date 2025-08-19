document.addEventListener('DOMContentLoaded', () => {
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

            // Add all the row's data cells
            tr.innerHTML = Object.values(row)
                .map(value => `<td>${value}</td>`)
                .join('');

            // Create an extra cell for actions
            const actionTd = document.createElement('td');
            const deleteBtn = document.createElement('button');
            deleteBtn.textContent = 'Delete';
            deleteBtn.dataset.id = row.R_ID; // use your recipe ID

            deleteBtn.addEventListener('click', () => {
                if (confirm("Are you sure you want to delete this recipe?")) {
                    fetch(`/api/recipes/${row.R_ID}`, { method: 'DELETE' })
                        .then(res => {
                            if (!res.ok) throw new Error("Failed to delete");
                            // Remove row visually
                            tr.remove();
                        })
                        .catch(err => {
                            console.error("Error deleting recipe:", err);
                            alert("Error deleting recipe");
                        });
                }
            });

            actionTd.appendChild(deleteBtn);
            tr.appendChild(actionTd); // add action cell at the end
            tbody.appendChild(tr);
        });
    }
});