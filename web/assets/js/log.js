function updateActivities() {
           
            const userId = document.getElementById('userId').value;
            
           
            fetch(`updateDiary?userId=${userId}`)
                .then(response => {
                    if (!response.ok) {
                        throw new Error(`HTTP error! status: ${response.status}`);
                    }
                    return response.text();
                })
                .then(html => {
                    const tableBody = document.querySelector('#users-page table tbody');
                    tableBody.innerHTML = html;
                })
                .catch(error => console.error('Error:', error));
        }

     
        setInterval(updateActivities, 300);

        updateActivities();

