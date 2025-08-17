document.addEventListener('DOMContentLoaded', () => {
    const tbody = document.getElementById('RecipeTableBody');

    fetch('/api/recipes')
        .then(res => res.json())
        .then(data => {
            if (!Array.isArray(data) || data.length === 0) {
                tbody.innerHTML = `<tr><td colspan="100%">No data found</td></tr>`;
                return;
            }

            tbody.innerHTML = ''; // Clear existing rows
            data.forEach(row => {
                const tr = document.createElement('tr');

                // Dynamically map all columns in this row
                tr.innerHTML = Object.values(row)
                    .map(value => `<td>${value}</td>`)
                    .join('');

                tbody.appendChild(tr);
            });
        })
        .catch(err => {
            console.error('Error loading data:', err);
            tbody.innerHTML = `<tr><td colspan="100%">Error loading data</td></tr>`;
        });
});