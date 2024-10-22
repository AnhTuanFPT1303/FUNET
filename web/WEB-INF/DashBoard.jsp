<%-- 
    Document   : DashBoard
    Created on : 5 thg 10, 2024, 23:15:47
    Author     : Quocb
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.Post, dao.postDAO, model.User" %>
<%@ page import="model.UserActivityLog" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Dashboard</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
        <style>
            .sidebar {
                height: 100vh;
                background-color: #f8f9fa;
            }
            .main-content {
                padding: 20px;
            }
            .nav-button {
                width: 100%;
                text-align: left;
                padding: 10px 15px;
                margin-bottom: 5px;
                background-color: transparent;
                border: none;
                cursor: pointer;
                transition: background-color 0.3s;
            }
            .nav-button:hover, .nav-button.active {
                background-color: #007bff;
                color: white;
            }
            .nav-button svg {
                margin-right: 10px;
            }
            .page {
                display: none;
                opacity: 0;
                transition: opacity 0.5s ease-in-out;
            }
            .page.active {
                display: block;
                opacity: 1;
            }
        </style>
    </head>
    <body>
        <div class="container-fluid">
            <div class="row">
                <!-- Sidebar -->
                <nav class="col-md-3 col-lg-2 d-md-block sidebar collapse">
                    <div class="position-sticky pt-3">
                        <div class="nav flex-column">
                            <button class="nav-button active" data-page="dashboard">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-home"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path><polyline points="9 22 9 12 15 12 15 22"></polyline></svg>
                                Dashboard
                            </button>
                            <button class="nav-button" data-page="users">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-users"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path><circle cx="9" cy="7" r="4"></circle><path d="M23 21v-2a4 4 0 0 0-3-3.87"></path><path d="M16 3.13a4 4 0 0 1 0 7.75"></path></svg>
                                Users
                            </button>
                            <button class="nav-button" data-page="analytics">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-bar-chart-2"><line x1="18" y1="20" x2="18" y2="10"></line><line x1="12" y1="20" x2="12" y2="4"></line><line x1="6" y1="20" x2="6" y2="14"></line></svg>
                                Analytics
                            </button>
                        </div>
                    </div>
                </nav>

                <!-- Main content -->
                <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 main-content">
                    <!-- Dashboard Page -->
                    <div id="dashboard-page" class="page active">
                        <h1 class="mt-4">Dashboard</h1>
                        <div class="row mt-4">
                            <div class="col-md-4">
                                <div class="card">
                                    <div class="card-body">
                                        <h5 class="card-title">Total Users</h5>
                                        <p class="card-text display-4">10,234</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="card">
                                    <div class="card-body">
                                        <h5 class="card-title">New Posts Today</h5>
                                        <p class="card-text display-4">156</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="card">
                                    <div class="card-body">
                                        <h5 class="card-title">Active Users</h5>
                                        <p class="card-text display-4">8,742</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Users Page -->
                    <div id="users-page" class="page">
                        <h1 class="mt-4">Users Management</h1>
                        <table class="table mt-4">
                            <thead>
                                <tr>
                                    <th>User Id</th>
                                    <th>Role</th>
                                    <th>Name</th>

                                </tr>
                            </thead>

                            <tbody>
                            <tbody>
                                <c:forEach var="user" items="${users}">
                                    <tr>
                                        <td>${user.user_id}</td>
                                        <td>${user.role}</td>
                                        <td><a href="log?id=${user.user_id}"> ${user.first_name} ${user.last_name} </a></td>
                                    </tr>
                                </c:forEach>
                            </tbody>

                            </tbody>
                        </table>
                    </div>

                    <!-- Analytics Page -->
                    <div id="analytics-page" class="page">
                        <h1 class="mt-4">Analytics</h1>
                        <div class="row mt-4">
                            <div class="col-md-6">
                                <canvas id="userGrowthChart"></canvas>
                            </div>
                            <div class="col-md-6">
                                <canvas id="postEngagementChart"></canvas>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.7.0/chart.min.js"></script>
        <script src="assets/js/DashBoard.js">

        </script>
        <script type="text/javascript">
            // Khai báo biến cho các label (tên tháng)
            let label0 = "${label0}";
            let label1 = "${label1}";
            let label2 = "${label2}";
            let label3 = "${label3}";
            let label4 = "${label4}";
            let label5 = "${label5}";
            let label6 = "${label6}";

            // Khai báo biến cho các data (số liệu tương ứng với từng tháng)
            let data0 = ${data0};
            let data1 = ${data1};
            let data2 = ${data2};
            let data3 = ${data3};
            let data4 = ${data4};
            let data5 = ${data5};
            let data6 = ${data6};




        </script>
    </body>
</html>
