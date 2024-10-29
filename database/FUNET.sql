
CREATE DATABASE FUNET;

GO
USE FUNET;

GO
DROP TABLE IF EXISTS friendship;
DROP TABLE IF EXISTS comment;
DROP TABLE IF EXISTS post_like;
DROP TABLE IF EXISTS post_share;
DROP TABLE IF EXISTS post;
DROP TABLE IF EXISTS message;
DROP TABLE IF EXISTS conversation_users;
DROP TABLE IF EXISTS conversation;
DROP TABLE IF EXISTS game;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS learningmaterial;
DROP TABLE IF EXISTS conversation;
DROP TABLE IF EXISTS product;
DROP TABLE IF EXISTS UserActivityLog;
DROP TABLE IF EXISTS GameCategory;
DROP TABLE IF EXISTS userAccount;
drop procedure if exists getAllFriends;

GO
CREATE TABLE userAccount (
  user_id INT IDENTITY(1,1) PRIMARY KEY,
  first_name NVARCHAR(50) NOT NULL,
  last_name NVARCHAR(50) NOT NULL,
  password VARCHAR(30) NULL,
  email VARCHAR(70) NOT NULL UNIQUE,
  profile_pic VARCHAR(max) NOT NULL,
  role VARCHAR(20) NOT NULL, 
  user_introduce NVARCHAR(50),
  is_banned BIT NOT NULL,
  created_at DATE DEFAULT CAST(GETDATE() AS DATE) NOT NULL
);


GO
CREATE TABLE friendship (
	friendship_id INT IDENTITY(1,1) PRIMARY KEY,
	sender INT,
	receiver INT,
	status nvarchar(10) NOT NULL,
	CONSTRAINT fk_sender FOREIGN KEY (sender) REFERENCES userAccount (user_id) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT fk_receiver FOREIGN KEY (receiver) REFERENCES userAccount (user_id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

GO
CREATE TABLE post (
  post_id INT IDENTITY(1,1) PRIMARY KEY,
  user_id INT NOT NULL,
  body NVARCHAR(200),
  image_path NVARCHAR(max),
  post_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  like_count INT not null default 0,
  is_shared BIT NOT NULL DEFAULT 0,
  original_post_id INT NULL,
  share_count INT NOT NULL DEFAULT 0,
  privacy_mode NVARCHAR(10) NOT NULL DEFAULT 'friend',
  FOREIGN KEY (user_id) REFERENCES userAccount (user_id),
  type NVARCHAR(max)
);

GO
CREATE TABLE post_like (
	like_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY, 
    user_id INT NOT NULL,
    post_id INT NOT NULL,
    like_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT fk_like_user FOREIGN KEY (user_id) REFERENCES userAccount (user_id),
    CONSTRAINT fk_like_post FOREIGN KEY (post_id) REFERENCES post(post_id)
);

GO
CREATE TABLE comment (
    comment_id INT IDENTITY(1,1) PRIMARY KEY,
    post_id INT NOT NULL,
    user_id INT NOT NULL,
    comment_text NVARCHAR(MAX) NOT NULL,
	comment_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES post (post_id),
	comment_image NVARCHAR(MAX),
    FOREIGN KEY (user_id) REFERENCES userAccount (user_id)
);

GO
CREATE TABLE conversation (
	conversation_id INT IDENTITY(1,1) PRIMARY KEY, 
	conversation_name NVARCHAR(50),
	conversation_avatar nvarchar(200) NOT NULL
);

GO 
CREATE TABLE conversation_users (
	is_admin BIT NOT NULL,
	user_id INT,
	conversation_id INT,
	FOREIGN KEY (user_id) REFERENCES userAccount(user_id),
	FOREIGN KEY (conversation_id) REFERENCES conversation (conversation_id),
	PRIMARY KEY (user_id, conversation_id)
);

GO
CREATE TABLE message (
	message_id INT IDENTITY(1,1) PRIMARY KEY,
	sender INT NOT NULL,
	receiver INT,
	conversation_id INT NOT NULL,
	message_text NVARCHAR(400) NOT NULL,
	message_type VARCHAR(40) NOT NULL,
	sent_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (sender) REFERENCES userAccount (user_id) ON DELETE NO ACTION ON UPDATE NO ACTION,
	FOREIGN KEY (receiver) REFERENCES userAccount (user_id) ON DELETE NO ACTION ON UPDATE NO ACTION,
	FOREIGN KEY (conversation_id) REFERENCES conversation (conversation_id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

GO
CREATE TABLE post_share (
    share_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    post_id INT NOT NULL,
    share_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    like_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (user_id) REFERENCES userAccount (user_id),
    FOREIGN KEY (post_id) REFERENCES post(post_id)
);

GO
CREATE TABLE categories (
    tag_id INT PRIMARY KEY IDENTITY(1,1),
    tag_name NVARCHAR(50) NOT NULL
);
go
CREATE TABLE GameCategory (
    CategoryID INT PRIMARY KEY IDENTITY(1,1),
    CategoryName NVARCHAR(50) NOT NULL
);
GO
INSERT INTO GameCategory (CategoryName) VALUES 
(N'Action'),
(N'Adventure'),
(N'Board game'),
(N'Card game'),
(N'Building'),
(N'Combat');
GO

GO
CREATE TABLE Game (
    GameID INT PRIMARY KEY,
    GameName NVARCHAR(50) NOT NULL,
    GameLink NVARCHAR(200),
    CategoryID INT,
    FOREIGN KEY (CategoryID) REFERENCES GameCategory(CategoryID)
);

GO
INSERT INTO Game (GameID, GameName, GameLink, CategoryID) VALUES 
(1, N'Triple Cars', 'https://cdn.htmlgames.com/TripleCars/', 1),
(2, N'Pyramid Solitaire - Great Pyramid', 'https://cdn.htmlgames.com/PyramidSolitaire-GreatPyramid/', 4),
(3, N'Sushi Master', 'https://cdn.htmlgames.com/SushiMasterMatch3/', 3),
(4, N'Goblin Run', 'https://cdn.htmlgames.com/GoblinRun/', 1),
(5, N'Solitaire Collection 2', 'https://cdn.htmlgames.com/SolitaireCollection2/', 4),
(6, N'Escape Room - Home Escape', 'https://cdn.htmlgames.com/EscapeRoom-HomeEscape/', 2),
(7, N'Reach 7', 'https://cdn.htmlgames.com/Reach7/', 3),
(8, N'Solitaire Collection', 'https://cdn.htmlgames.com/SolitaireCollection/', 4),
(9, N'2048 Billiards', 'https://cdn.htmlgames.com/2048Billiards/', 3),
(10, N'Jungle Link', 'https://cdn.htmlgames.com/JungleLink/', 2),
(11, N'The Watermelon Game', 'https://cdn.htmlgames.com/TheWatermelonGame/', 5),
(12, N'Double Klondike', 'https://cdn.htmlgames.com/DoubleKlondike/', 4),
(13, N'Water Sort', 'https://cdn.htmlgames.com/WaterSort/', 1),
(14, N'Jungle Sniper', 'https://cdn.htmlgames.com/JungleSniper/', 6),
(15, N'Kitty Mahjong', 'https://cdn.htmlgames.com/KittyMahjong/', 6),
(16, N'Balloon Maze', 'https://cdn.htmlgames.com/BalloonMaze/', 2),
(17, N'Mysterious Pirate Jewels 3', 'https://cdn.htmlgames.com/MysteriousPirateJewels3/', 2),
(18, N'Aladdin Solitaire', 'https://cdn.htmlgames.com/AladdinSolitaire/', 3),
(19, N'Tap It Away 3D', 'https://cdn.htmlgames.com/TapItAway3D/', 5),
(20, N'Pyramid Solitaire - Ancient China', 'https://cdn.htmlgames.com/PyramidSolitaire-AncientChina/', 2),
(21, N'Ninja Breakout', 'https://cdn.htmlgames.com/NinjaBreakout/', 6),
(22, N'Bubble Throw', 'https://cdn.htmlgames.com/BubbleThrow/', 6),
(23, N'Freecell Extreme', 'https://cdn.htmlgames.com/FreecellExtreme/', 4),
(24, N'Connect the Dots', 'https://cdn.htmlgames.com/ConnectTheDots/', 5),
(25, N'Harbour Escape', 'https://cdn.htmlgames.com/HarbourEscape/', 1),
(26, N'Flower World 2', 'https://cdn.htmlgames.com/FlowerWorld2/', 1),
(27, N'Black and White Mahjong 3', 'https://cdn.htmlgames.com/BlackAndWhiteMahjong3/', 3),
(28, N'Archery Training', 'https://cdn.htmlgames.com/ArcheryTraining/', 6),
(29, N'Spooky Dimensions', 'https://cdn.htmlgames.com/SpookyDimensions/', 5),
(30, N'Circus Match 3', 'https://cdn.htmlgames.com/CircusMatch3/', 5);


go
CREATE TABLE UserActivityLog (
    log_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    activity_type VARCHAR(50) NOT NULL,
    activity_details NVARCHAR(MAX),
    timestamp DATETIME DEFAULT GETDATE(), 
    FOREIGN KEY (user_id) REFERENCES userAccount(user_id)
);

GO
CREATE TABLE product (
    product_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    product_name NVARCHAR(255) NOT NULL,
    product_description NVARCHAR(500), -- Điều chỉnh độ dài nếu cần
	product_img text NOT NULL,
    product_tag NVARCHAR(255) NOT NULL,
    publish_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    price DECIMAL(10, 2) NOT NULL, -- Điều chỉnh kiểu dữ liệu để biểu diễn giá
    CONSTRAINT fk_product_user_id FOREIGN KEY (user_id) REFERENCES userAccount(user_id)
);
GO

CREATE TABLE shoppingCart (
	cart_id INT IDENTITY(1,1) PRIMARY KEY,
	user_id INT NOT NULL,
	add_date DATETIME DEFAULT GETDATE(),
);
Go

CREATE TABLE shoppingCartItem (
	item_id INT PRIMARY KEY IDENTITY(1,1),
	cart_id INT NOT NULL,
	product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    added_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (cart_id) REFERENCES ShoppingCart(cart_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
)

CREATE TABLE Orders (
    order_id INT primary key,
    user_id INT NOT NULL,
	cart_id INT NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    order_status NVARCHAR(50) DEFAULT 'Pending', -- E.g., Pending, Shipped, Delivered
    order_date DATETIME DEFAULT GETDATE(),
	order_note NVARCHAR(MAX) NOT NULL,
    shipping_address NVARCHAR(255) NOT NULL
);
GO


INSERT INTO ShoppingCart (user_id)
VALUES 
(1),  
(188); 
GO

INSERT INTO ShoppingCartItem (cart_id, product_id, quantity)
VALUES 
(3, 6, 1),  
(3, 7, 2),  
(4, 8, 1);  
GO

INSERT INTO Orders (user_id, total_amount, order_status, shipping_address)
VALUES 
(3, 1500.00, 'Pending', '123 Main St, City');
GO

INSERT INTO OrderDetails (order_id, product_id, quantity, price_per_unit)
VALUES 
(1, 6, 1, 1200.00),  -- 1 Laptop in Order ID 1
(1, 7, 2, 150.00);    -- 2 Headphones in Order ID 1
GO


GO
CREATE TABLE learningmaterial (
    learningmaterial_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    learningmaterial_name NVARCHAR(255) NOT NULL,
    learningmaterial_description NVARCHAR(500), -- Tăng độ dài mô tả nếu cần
    learningmaterial_img NVARCHAR(MAX) NOT NULL, -- Change to NVARCHAR(MAX)
    learningmaterial_context NVARCHAR(MAX) NOT NULL, -- Change to NVARCHAR(MAX)
    subject_code NVARCHAR(7) NOT NULL,
    publish_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Thêm giá trị mặc định
    review NVARCHAR(MAX), -- Thay đổi kiểu dữ liệu cho phù hợp
    CONSTRAINT fk_learningmaterial_user_id FOREIGN KEY (user_id) REFERENCES userAccount(user_id)
);

CREATE TABLE saved_post (
    user_id INT NOT NULL,
    post_id INT NOT NULL,
    PRIMARY KEY (user_id, post_id),
    CONSTRAINT fk_saved_user FOREIGN KEY (user_id) REFERENCES userAccount(user_id),
    CONSTRAINT fk_saved_post FOREIGN KEY (post_id) REFERENCES post(post_id)
);


GO
CREATE PROCEDURE getAllFriends
    @userId INT
AS
BEGIN
    SELECT u.user_id, u.first_name, u.last_name, u.profile_pic, u.role, u.is_banned, f.status
    FROM userAccount u
    INNER JOIN friendship f ON 
        (f.sender = u.user_id AND f.receiver = @userId)
        OR (f.receiver = u.user_id AND f.sender = @userId)
    WHERE f.status = 'accepted';
END;


go
 -- January
INSERT INTO userAccount (first_name, last_name, password, email, profile_pic, role, is_banned, created_at)
VALUES ('UserJan', 'LastnameJan', 'password', 'userjan@example.com', 'default_avt.jpg', 'student', 0, '2024-01-15');

-- February
INSERT INTO userAccount (first_name, last_name, password, email, profile_pic, role, is_banned, created_at)
VALUES ('UserFeb', 'LastnameFeb', 'password', 'userfeb@example.com', 'default_avt.jpg', 'student', 0, '2024-02-15');

-- March
INSERT INTO userAccount (first_name, last_name, password, email, profile_pic, role, is_banned, created_at)
VALUES ('UserMar', 'LastnameMar', 'password', 'usermar@example.com', 'default_avt.jpg', 'student', 0, '2024-03-15');

-- April
INSERT INTO userAccount (first_name, last_name, password, email, profile_pic, role, is_banned, created_at)
VALUES ('UserApr', 'LastnameApr', 'password', 'userapr@example.com', 'default_avt.jpg', 'student', 0, '2024-04-15');

-- May
INSERT INTO userAccount (first_name, last_name, password, email, profile_pic, role, is_banned, created_at)
VALUES ('UserMay', 'LastnameMay', 'password', 'usermay@example.com', 'default_avt.jpg', 'staff', 0, '2024-05-15');

-- June
INSERT INTO userAccount (first_name, last_name, password, email, profile_pic, role, is_banned, created_at)
VALUES ('UserJun', 'LastnameJun', 'password', 'userjun@example.com', 'default_avt.jpg', 'staff', 0, '2024-06-15');

-- July
INSERT INTO userAccount (first_name, last_name, password, email, profile_pic, role, is_banned, created_at)
VALUES ('UserJul', 'LastnameJul', 'password', 'userjul@example.com', 'default_avt.jpg', 'student', 0, '2024-07-15');

-- August
INSERT INTO userAccount (first_name, last_name, password, email, profile_pic, role, is_banned, created_at)
VALUES ('UserAug', 'LastnameAug', 'password', 'useraug@example.com', 'default_avt.jpg', 'staff', 0, '2024-08-15');

-- September
INSERT INTO userAccount (first_name, last_name, password, email, profile_pic, role, is_banned, created_at)
VALUES ('UserSep', 'LastnameSep', 'password', 'usersep@example.com', 'default_avt.jpg', 'student', 0, '2024-09-15');

INSERT INTO userAccount (first_name, last_name, password, email, profile_pic, role, is_banned, created_at)
VALUES ('UserOctgaaah', 'LastnameOct', 'password', 'useroct@exampddalems.com', 'default_avt.jpg', 'staff', 0, '2024-09-15');


-- October
INSERT INTO userAccount (first_name, last_name, password, email, profile_pic, role, is_banned, created_at)
VALUES ('UserOct', 'LastnameOct', 'password', 'useroct@example.com', 'default_avt.jpg', 'staff', 0, '2024-10-15');

INSERT INTO userAccount (first_name, last_name, password, email, profile_pic, role, is_banned, created_at)
VALUES ('UserOctgh', 'LastnameOct', 'password', 'useroct@examplems.com', 'default_avt.jpg', 'staff', 0, '2024-10-15');