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

                // Add all the row's columns
                tr.innerHTML = Object.values(row)
                    .map(value => `<td>${value}</td>`)
                    .join('');

                // Add a delete button at the end
                const actionTd = document.createElement('td');
                const deleteBtn = document.createElement('button');
                deleteBtn.textContent = 'Delete';
                deleteBtn.className = 'btn btn-sm btn-primary view-btn';
                deleteBtn.dataset.id = row.R_ID; // assumes backend returns R_ID


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
                tr.appendChild(actionTd);

                tbody.appendChild(tr);
            });
        })
        .catch(err => {
            console.error('Error loading data:', err);
            tbody.innerHTML = `<tr><td colspan="100%">Error loading data</td></tr>`;
        });

});