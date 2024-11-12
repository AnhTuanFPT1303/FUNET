/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


            document.addEventListener('DOMContentLoaded', function () {
                const searchInput = document.getElementById('search-input');
                const searchForm = document.getElementById('searchForm');

                searchInput.addEventListener('keypress', function (event) {
                    if (event.key === 'Enter') {
                        event.preventDefault();
                        searchForm.submit();
                    }
                });
            });

            document.getElementById('messenger-btn').addEventListener('click', function () {
                toggleMenu('messenger-menu', 'messenger-btn');
            });

            document.getElementById('notification-btn').addEventListener('click', function () {
                toggleMenu('notification-menu', 'notification-btn');
            });

            document.getElementById('user-btn').addEventListener('click', function () {
                toggleMenu('user-menu', 'user-btn');
            });

            document.addEventListener('click', function (event) {
                const messengerMenu = document.getElementById('messenger-menu');
                const notificationMenu = document.getElementById('notification-menu');
                const userMenu = document.getElementById('user-menu');
                const messengerBtn = document.getElementById('messenger-btn');
                const notificationBtn = document.getElementById('notification-btn');
                const userBtn = document.getElementById('user-btn');

                if (!messengerMenu.contains(event.target) && !messengerBtn.contains(event.target)) {
                    messengerMenu.style.display = 'none';
                    messengerBtn.classList.remove('active-button');
                }
                if (!notificationMenu.contains(event.target) && !notificationBtn.contains(event.target)) {
                    notificationMenu.style.display = 'none';
                    notificationBtn.classList.remove('active-button');
                }
                if (!userMenu.contains(event.target) && !userBtn.contains(event.target)) {
                    userMenu.style.display = 'none';
                    userBtn.classList.remove('active-button');
                }
            });

            function toggleMenu(menuId, btnId) {
                const menu = document.getElementById(menuId);
                const button = document.getElementById(btnId);
                const otherMenuIds = ['messenger-menu', 'notification-menu', 'user-menu'].filter(id => id !== menuId);
                const otherButtons = ['messenger-btn', 'notification-btn', 'user-btn'].filter(id => id !== btnId);

                if (menu.style.display === 'none' || menu.style.display === '') {
                    menu.style.display = 'block';
                    button.classList.add('active-button');
                    otherMenuIds.forEach(id => document.getElementById(id).style.display = 'none');
                    otherButtons.forEach(id => document.getElementById(id).classList.remove('active-button'));
                } else {
                    menu.style.display = 'none';
                    button.classList.remove('active-button');
                }
            }