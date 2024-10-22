// Navigation
document.querySelectorAll('.nav-button').forEach(button => {
    button.addEventListener('click', function () {
        const page = this.getAttribute('data-page');
        console.log('Button clicked:', page); // Debug log
        showPage(page);
    });
});

function showPage(pageId) {
    console.log('Showing page:', pageId); // Debug log
    document.querySelectorAll('.page').forEach(page => {
        page.classList.remove('active');
    });
    const activePage = document.getElementById(`${pageId}-page`);
    activePage.classList.add('active');
    console.log('Active page:', activePage); // Debug log

    document.querySelectorAll('.nav-button').forEach(button => {
        button.classList.remove('active');
    });
    const activeButton = document.querySelector(`[data-page="${pageId}"]`);
    activeButton.classList.add('active');
    console.log('Active button:', activeButton); // Debug log
}

// Initialize charts
function initCharts() {
    const userGrowthCtx = document.getElementById('userGrowthChart').getContext('2d');
    chart = new Chart(userGrowthCtx, {
        type: 'line',
        data: {
            labels: [label0,label1, label2, label3, label4, label5, label6],
            datasets: [{
                    label: 'User Growth',
                    data: [data0,data1, data2,data3,data4, data5, data6],
                    borderColor: 'rgb(75, 192, 192)',
                    tension: 0.1
                }]
        },
        options: {
            responsive: true,
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
}
// kiểm tra xem hôm nay có phải ngày đầu của tháng
function isFirstDayOfMonth() {
    const today = new Date();
    return today.getDate() === 1;
}
function setupMonthlyCheck() {
    // Hàm kiểm tra ngày đầu tháng và cập nhật biểu đồ nếu cần
    function checkAndUpdate() {
        const now = new Date();
        if (now.getDate() === 1) {
            updateChart();
            
        }
    }

    // Kiểm tra ngay lập tức và cập nhật nếu là ngày đầu tháng
    checkAndUpdate();
    
    // Thiết lập kiểm tra hàng ngày vào 00:01
    const now = new Date();
    const tomorrow = new Date(now.getFullYear(), now.getMonth(), now.getDate() + 1, 0, 1, 0);
    const timeUntilNextCheck = tomorrow - now;
    
    setTimeout(() => {
        checkAndUpdate();
        // Thiết lập interval hàng ngày để kiểm tra vào 00:01
        setInterval(checkAndUpdate, 24 * 60 * 60 * 1000);
    }, timeUntilNextCheck);
}
// Gọi hàm thiết lập,nhớ bỏ setInterval của updateChart trước khi gọi
setupMonthlyCheck();

function updateChart() {
    fetch('userChartData')
        .then(response => response.json())
        .then(data => {
            // Thêm dữ liệu mới vào biểu đồ
            chart.data.labels.push(data.month);
            chart.data.datasets[0].data.push(data.userCount);
            
            // Giới hạn số điểm dữ liệu hiển thị ( chỉ hiển thị 7 tháng gần nhất)
            if (chart.data.labels.length > 7) {
                chart.data.labels.shift();
                chart.data.datasets[0].data.shift();
            }
            
            // Cập nhật biểu đồ
            chart.update();
        })
        .catch(error => console.error('Error:', error));
}
// đặt thời gian 5s 1 lần cập nhật
//setInterval(updateChart, 5000);

const postEngagementCtx = document.getElementById('postEngagementChart').getContext('2d');
new Chart(postEngagementCtx, {
    type: 'bar',
    data: {
        labels: ['Likes', 'Comments', 'Shares'],
        datasets: [{
                label: 'Post Engagement',
                data: [12000, 5000, 3000],
                backgroundColor: [
                    'rgba(255, 99, 132, 0.2)',
                    'rgba(54, 162, 235, 0.2)',
                    'rgba(255, 206, 86, 0.2)'
                ],
                borderColor: [
                    'rgba(255, 99, 132, 1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(255, 206, 86, 1)'
                ],
                borderWidth: 1
            }]
    },
    options: {
        responsive: true,
        scales: {
            y: {
                beginAtZero: true
            }
        }
    }
});


// Initialize charts when the Analytics page is shown
document.querySelector('[data-page="analytics"]').addEventListener('click', initCharts);


// cập nhật user log theo giây
/*function updateActivities() {
    fetch('updateDiary')
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
} */

// cập nhật mỗi 0.3 giây
//setInterval(updateActivities, 300);

// cập nhật
//updateActivities();