<%-- 
    Document   : index
    Created on : 1 thg 10, 2024, 12:46:41
    Author     : Quocb
--%>

<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Game Catalog</title>
        <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
           <link href="assets/css/logonavbar.css" rel="stylesheet">   


        <style>
            .button {
                transition: background-color 0.3s, transform 0.3s;
            }
            body {
                overflow: hidden; /* Prevents scrolling on the body */
            }

            .sidebargame {
                position: fixed;
                top: 70px;
                left: 0;
                bottom: 0;
                width: 340px;
                overflow-y: auto;
                height: calc(100vh - 70px);
                scrollbar-width: thin; /*  Firefox */
                scrollbar-color: #888 #f1f1f1; /*  Firefox */
            }

            /* Webkit Chrome, Safari */
            .sidebargame::-webkit-scrollbar {
                width: 6px;
            }

            .sidebargame::-webkit-scrollbar-track {
                background: #f1f1f1;
            }

            .sidebargame::-webkit-scrollbar-thumb {
                background: #888;
                border-radius: 3px;
            }

            .sidebargame::-webkit-scrollbar-thumb:hover {
                background: #555;
            }

            .main-content {

                height: calc(100vh - 80px); /* Subtract header height from viewport height */
                overflow-y: auto;
            }
            .main-content {
                margin-left: 340px;
                padding-top: 0px; 
            }
            aside {
                width: 360px;
                height: 919px;
            }

            .game-card {
                aspect-ratio: 3/4;
            }
            #result{
                overflow-y: auto;
                weight:290px;
                height: 324px;
            }


            .navbar {
                display: flex;
                align-items: center;
                justify-content: space-around;
                position: relative;
                background-color: #ffffff;
                padding: 10px 20px;
                height: 60px;
                width: 100%;
                top: 0;
                z-index: 1000;
                box-sizing: border-box;
                position: sticky;
                index: 1000;
            }

            .center-buttons {
                display: flex;
                gap: 10px;
                justify-content: center;
                align-items: center;
                flex-grow: 1;
                margin-left: 10%;
            }

            .center-button {
                flex: 1;
                max-width: 80px;
                height: 48px;
                background: none;
                border: none;
                color: black;
                cursor: pointer;
                border-radius: 15px;
                display: flex;
                align-items: center;
                justify-content: center;
                transition: background-color 0.3s ease;
                margin: 0;
            }

            .center-button:hover {
                background-color: #CFC6C6;
            }

            .logo {
                font-size: 24px;
                font-weight: bold;
            }

            .search-bar {
                margin-bottom: 5px;
                margin-bottom: 10px;
            }

            .search-bar input {
                padding: 8px;
                border: none;
                border-radius: 15px;
                height: 35px;
                width: 250px;
                transition: width 0.3s ease;
                outline: 1px solid rgb(133, 130, 130);
                font-size: 15px;
            }

            .right-icons {
                display: flex;
                gap: 10px;
                align-items: center;
                width: 500px;
                padding-left: 330px;
                justify-content: flex-end;
            }

            .icon {
                font-size: 20px;
                cursor: pointer;
                color: black;
            }

            .icon-circle {
                display: flex;
                align-items: center;
                justify-content: center;
                width: 40px;
                height: 40px;
                background-color: rgb(211, 211, 211);
                border-radius: 50%;
                transition: background-color 0.3s ease;
            }

            .icon-circle:hover {
                background-color: darkgrey;
            }

            @media screen and (max-width: 1250px) {
                .center-buttons {
                    display: none;
                }
                .home-logo {
                    display: none;
                }
            }

            @media screen and (max-width: 1050px) {
                .search-bar input {
                    width: 200px;
                }
            }

            @media screen and (max-width: 850px) {
                .search-bar {
                    display: none;
                }
                .logo {
                    display: none;
                }
                .RightItem {
                    margin: 0;
                    justify-content: center;
                }
            }


        </style>

    </head>
    <body class="bg-gray-100">

        <!-- Top Navigation -->
       <div class="flex-container navbar">
            <a href="home" style ="text-decoration:none">   <div class="logo" style="margin-bottom: 10%">FUNET</div>
            </a>
            <form class="" method="get" action="/searchServlet" id="searchForm">
                <div class="search-bar" style="margin-top:1%; margin-left:1%">
                    <input class="form-control" name="search-name" type="search" placeholder="Searching in FUNET" aria-label="Search" id="search-input" style="padding-left:5%;">

                </div>
            </form>
            <div class="center-buttons">
                <a href="home">
                    <button class="center-button" id="home-btn">
                        <box-icon type='solid' name='home'></box-icon>
                    </button>
                </a>
                <a href="lmaterialLink"> 
                    <button class="center-button" id="video-btn">
                        <box-icon type='solid' name='book'></box-icon>
                    </button>
                </a>
                <a href="market">
                    <button class="center-button" id="market-btn">
                        <box-icon name='store-alt' type='solid'></box-icon>
                    </button>
                </a>
                <a href="/friendRequestServlet" class="friend-icon me-3">
                    <button class="center-button" id="friend-btn">
                        <box-icon name='group' type='solid'></box-icon>
                    </button>
                </a>
            </div>
            <div class="right-icons">
                <a href="/chat" class="mess-icon" style='margin-left:5px'>
                    <span class="icon icon-circle" id="messenger-btn"><box-icon name='messenger' type='logo'></box-icon></span>
                </a>
                <span class="icon icon-circle" id="notification-btn" style="display:none"><box-icon name='bell' type='solid' ></box-icon></span>
                <span class="icon icon-circle" id="user-btn">&#128100;</span>
            </div>

        </div>

        <div class="dropdown-menu" id="notification-menu">
            <p>Notification content goes here...</p>
        </div>
    
    <div class="dropdown-menu" id="notification-menu">
        <p>Notification content goes here...</p>
    </div>
    <div class="user-menu" id="user-menu" >
        <div class="user-info">
            <a href="profile?userId=${sessionScope.user['user_id']}" class="d-flex align-items-center text-decoration-none text-dark">
                <button class="user-info-button">
                    <img src="assets/profile_avt/${sessionScope.user['profile_pic']}" class="img-fluid rounded-circle avatar" style="object-fit: cover;">
                    <p class="mb-0 ms-2 ava-name">${sessionScope.user['first_name']} ${sessionScope.user['last_name']}</p>
                </button>
            </a>
        </div>
        <div class="menu-item">
            <box-icon name='cog' type='solid' style="margin-right:3%; margin-left:1%;">Settings</box-icon>Settings
        </div>
        <div class="menu-item" >
            <box-icon name='error-circle'style="margin-right:3%; margin-left:1%;"></box-icon>Report
        </div>
        

        <form method="post" action="/logout" style="display: inline; width: 100%;">
            <div class="menu-item" style="display: flex; align-items: center; cursor: pointer; width: 100%;">
                <box-icon type='solid' name='log-out'style=" margin-left:1%;"></box-icon>
                <button type="submit" style="border: none; background: none; color: black; font-size: 16px; margin-left: 5px; cursor: pointer; flex: 1; text-align: left;">
                    Log Out
                </button>
            </div>
        </form>
    </div>

        <!-- Main Container -->
        <div class="flex h-screen">
            <!-- Sidebar -->
            <aside class="bg-white p-5 shadow-md sidebargame">
                <h2 class="text-xl font-bold mb-4">Chơi game</h2>
                <i class="fa fa-setting"></i>
                <!-- Tìm kiếm -->

                <script type="text/javascript">
                    $(document).ready(function () {
                        // Sự kiện keyup sẽ gọi AJAX mỗi khi có thay đổi trong ô input
                        $("#keyword").on("keyup", function () {
                            var keyword = $(this).val();

                            if (keyword.length > 0) {
                                $.ajax({
                                    url: "searchGame", // Servlet mà AJAX gửi yêu cầu tới
                                    type: "GET",
                                    data: {keyword: keyword},
                                    success: function (result) {
                                        // Hiển thị kết quả trả về 
                                        $("#result").html(result);
                                        $("#result").removeClass("hidden");
                                    },
                                    error: function () {
                                        alert("Có lỗi xảy ra, vui lòng thử lại.");
                                    }
                                });
                            } else {
                                // Nếu không có từ khóa, xóa kết quả hiển thị
                                $("#result").html("");
                                $("#result").addClass("hidden");
                            }
                        });
                    });
                </script>
                <div class="relative mb-6">
                    <input type="text" id="keyword" placeholder="Tìm kiếm trong phần chơi game" class="border p-2 rounded-lg w-full pr-10 focus:outline-none focus:ring-2 focus:ring-blue-500">
                    <div class="absolute inset-y-0 right-0 flex items-center pr-3">
                        <svg class="h-5 w-5 text-gray-400" viewBox="0 0 20 20" fill="currentColor">
                        <path fill-rule="evenodd" d="M8 4a4 4 0 100 8 4 4 0 000-8zM2 8a6 6 0 1110.89 3.476l4.817 4.817a1 1 0 01-1.414 1.414l-4.816-4.816A6 6 0 012 8z" clip-rule="evenodd" />
                        </svg>
                    </div>
                    <div id="result" class="absolute z-10 bg-white border border-gray-300 rounded-lg mt-1 shadow-lg hidden  ">
                        <!-- kết quả trả về -->
                        <!--   <div id="search-result-template" class="hidden flex items-center space-x-4 p-2 border-b border-gray-200 hover:bg-gray-100 cursor-pointer">
                               <img src="" alt="Game Image" class="w-16 h-16 object-cover rounded-lg">
                               <div class="flex flex-col">
                                   <h4 class="text-lg font-medium text-gray-800">Tên Game</h4>
                                   <p class="text-sm text-gray-500">Thể loại Game</p>
                               </div>
                           </div>  -->
                    </div>

                </div>
                <!-- Game Options -->
                <div class="flex flex-col space-y-2">
                    <button onclick="filterGames('All')" class="sidebar-btn flex items-center space-x-2 transition-transform transform hover:scale-105 hover:bg-blue-100 rounded-lg p-2">
                        <i class="fas fa-gamepad w-6 h-6 flex-shrink-0"></i> 
                        <span>Chơi game</span>
                    </button>
                    <button class="sidebar-btn flex items-center space-x-2 transition-transform transform hover:scale-105 hover:bg-blue-100 rounded-lg p-2">
                        <i class="fas fa-bell w-6 h-6 flex-shrink-0"></i> 
                        <span>Thông Báo</span>
                    </button>

                 <hr class="my-5">

                    <p class="text-sm text-gray-500 mb-2">Game của bạn</p>
                     <button class="sidebar-btn flex items-center space-x-2 transition-transform transform hover:scale-105 hover:bg-blue-100 rounded-lg p-2">
                        <i class="far fa-bookmark w-6 h-6 flex-shrink-0"></i>    
                        <span>Lưu game</span>
                    </button> 
                 

                    <hr class="my-4">

                    <!-- Categories -->
                    <h3 class="text-lg font-semibold mb-4">Hạng mục</h3>
                    <button onclick="filterGames('All')" class="sidebar-btn flex items-center space-x-2 transition-transform transform hover:scale-105 hover:bg-blue-100 rounded-lg p-2">
                        <i class="fas fa-th-large w-6 h-6 flex-shrink-0"></i> 
                        <span>Tất cả game</span>
                    </button>
                    <button onclick="filterGames('Action')" class="sidebar-btn flex items-center space-x-2 transition-transform transform hover:scale-105 hover:bg-blue-100 rounded-lg p-2">
                        <i class="fas fa-running w-6 h-6 flex-shrink-0"></i> 
                        <span>Hành động</span>
                    </button>
                    <button onclick="filterGames('Adventure')" class="sidebar-btn flex items-center space-x-2 transition-transform transform hover:scale-105 hover:bg-blue-100 rounded-lg p-2">
                        <i class="fas fa-map w-6 h-6 flex-shrink-0"></i> 
                        <span>Phiêu lưu</span>
                    </button>
                    <Button onclick="filterGames('Board game')" class="sidebar-btn flex items-center space-x-2 transition-transform transform hover:scale-105 hover:bg-blue-100 rounded-lg p-2">
                        <i class="fas fa-chess-board w-6 h-6 flex-shrink-0"></i> 
                        <span>Board game</span>
                    </Button>
                    <button onclick="filterGames('Card game')" class="sidebar-btn flex items-center space-x-2 transition-transform transform hover:scale-105 hover:bg-blue-100 rounded-lg p-2">
                        <i class="fas fa-cards w-6 h-6 flex-shrink-0"></i> 
                        <span>Đánh bài</span>
                    </button>
                    <button onclick="filterGames('Building')" class="sidebar-btn flex items-center space-x-2 transition-transform transform hover:scale-105 hover:bg-blue-100 rounded-lg p-2">
                        <i class="fas fa-building w-6 h-6 flex-shrink-0"></i> 
                        <span>Xây dựng</span>
                    </button>
                    <button onclick="filterGames('Combat')" class="sidebar-btn flex items-center space-x-2 transition-transform transform hover:scale-105 hover:bg-blue-100 rounded-lg p-2">
                        <i class="fas fa-fist-raised w-6 h-6 flex-shrink-0"></i> 
                        <span>Chiến đấu</span>
                    </button>
                </div>
            </aside>
            <script>
                function filterGames(theloai) {

                    const games = document.querySelectorAll('.game-item');
                    if (theloai !== 'All')
                        document.querySelector('.title').textContent = theloai;
                    else
                        document.querySelector('.title').textContent = 'Tất cả game';


                    games.forEach(game => {
                        // Kiểm tra nếu game có thể loại phù hợp với điều kiện
                        if (game.getAttribute('data-theloai') === theloai || theloai === 'All') {
                            game.style.display = 'block'; // Hiển thị game
                        } else {
                            game.style.display = 'none'; // Ẩn game
                        }
                    });
                }
            </script>


            <!-- Main Content -->
            <main class="flex-grow p-6 main-content">
                <h1 id="title" class=" title text-4xl font-bold text-center" style="margin: 20px ">Tất cả game</h1>
                <div class="grid grid-cols-4 gap-6">
                    <!-- Game Cards -->
                    <c:forEach var="game" items="${list}">
                        <button data-theloai="${game.theloai}" onclick="showGame('${game.link}')" class="game-item relative overflow-hidden rounded-lg shadow-lg group transition-transform duration-300 ease-in-out transform hover:scale-105 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                            <img src="${game.linkimg}" alt="Game image" class="w-full h-full object-cover transition-transform duration-300 ease-in-out group-hover:scale-110" />
                            <div class="absolute bottom-0 left-0 right-0 bg-gradient-to-t from-black to-transparent p-4">
                                <h4 class="text-lg font-semibold text-white mb-1 transition-colors duration-300 ease-in-out group-hover:text-blue-300">${game.tengame}</h4>
                                <p class="text-sm text-gray-300 transition-colors duration-300 ease-in-out group-hover:text-blue-200">${game.theloai}</p>
                            </div>
                        </button>
                    </c:forEach>



                </div>
            </main>
        </div>
        <!-- Div ẩn chứa iframe để tải trò chơi -->
        <div id="gameModal" aria-hidden="true" class="fixed inset-0 bg-gray-800 bg-opacity-75 flex justify-center items-center hidden">
            <div class="bg-white" style="width: 800px; height: 600px; padding: 16px; border-radius: 8px; box-shadow: 0px 0px 24px 0px rgba(0, 0, 0, 0.2); position: relative;">
                <button id="closeModal" style="position: absolute; top: 16px; right: 16px; color: #4a5568;">&times;</button>
                <div id="gameContent" class="w-full h-full">
                    <!-- Iframe chứa trò chơi -->
                    <iframe id="gameIframe" src="" width="100%" height="100%" frameborder="0" allowfullscreen></iframe>
                </div>
            </div>
        </div>
                        <script src="assets/js/logonavbar.js" defer></script>

        <script>
            function showGame(gameUrl) {
                // Hiển thị modal chứa game
                document.getElementById('gameModal').classList.remove('hidden');
                document.getElementById('gameModal').setAttribute('aria-hidden', 'false');

                // Đặt URL cho iframe để tải trò chơi
                document.getElementById('gameIframe').src = gameUrl;
            }
            // Khi người dùng nhấp vào nút đóng
            document.getElementById('closeModal').addEventListener('click', function () {
                document.getElementById('gameModal').classList.add('hidden');
                document.getElementById('gameModal').setAttribute('aria-hidden', 'true');
                document.getElementById('gameIframe').src = ''; // Xóa nội dung trò chơi
            });
        </script>
        <!-- <script src="game.js"></script> -->


    </body>
</html>
