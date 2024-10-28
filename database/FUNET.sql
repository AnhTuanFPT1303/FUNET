
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
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS game;
DROP TABLE IF EXISTS GameCategory;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS learningmaterial;
DROP TABLE IF EXISTS conversation;
DROP TABLE IF EXISTS product;
DROP TABLE IF EXISTS UserActivityLog;
DROP TABLE IF EXISTS userAccount;
drop procedure if exists getAllFriends;
DROP TRIGGER IF EXISTS TR_Post_Activity;
DROP TRIGGER IF EXISTS TR_Comment_Activity;
DROP TRIGGER IF EXISTS TR_PostLike_Activity;

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
	conversation_avatar nvarchar(50) NOT NULL
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
	Img NVARCHAR(200),
    CategoryID INT,
    FOREIGN KEY (CategoryID) REFERENCES GameCategory(CategoryID)
);


select * from Game
GO
INSERT INTO Game (GameID, GameName, GameLink,Img, CategoryID) VALUES 
(1, N'Triple Cars', 'https://cdn.htmlgames.com/TripleCars/','https://res.cloudinary.com/dxx8u5qnr/image/upload/v1730128426/1_m5ce3b.jpg', 1),
(2, N'Pyramid Solitaire - Great Pyramid', 'https://cdn.htmlgames.com/PyramidSolitaire-GreatPyramid/','https://res.cloudinary.com/dxx8u5qnr/image/upload/v1730128429/2_hbckn7.jpg', 4),
(3, N'Sushi Master', 'https://cdn.htmlgames.com/SushiMasterMatch3/','https://res.cloudinary.com/dxx8u5qnr/image/upload/v1730128432/3_fejrwt.jpg' ,3),
(4, N'Goblin Run', 'https://cdn.htmlgames.com/GoblinRun/','https://res.cloudinary.com/dxx8u5qnr/image/upload/v1730128433/4_mwn2gs.jpg' ,1),
(5, N'Solitaire Collection 2', 'https://cdn.htmlgames.com/SolitaireCollection2/','https://res.cloudinary.com/dxx8u5qnr/image/upload/v1730128434/5_kqtfci.jpg' ,4),
(6, N'Escape Room - Home Escape', 'https://cdn.htmlgames.com/EscapeRoom-HomeEscape/','https://res.cloudinary.com/dxx8u5qnr/image/upload/v1730128436/6_jnwrix.jpg' ,2),
(7, N'Reach 7', 'https://cdn.htmlgames.com/Reach7/', 'https://res.cloudinary.com/dxx8u5qnr/image/upload/v1730128437/7_mnp4xu.jpg',3),
(8, N'Solitaire Collection', 'https://cdn.htmlgames.com/SolitaireCollection/', 'https://res.cloudinary.com/dxx8u5qnr/image/upload/v1730128440/8_zsb97b.jpg',4),
(9, N'2048 Billiards', 'https://cdn.htmlgames.com/2048Billiards/', 'https://res.cloudinary.com/dxx8u5qnr/image/upload/v1730128443/9_n0pe4j.jpg',3),
(10, N'Jungle Link', 'https://cdn.htmlgames.com/JungleLink/', 'https://res.cloudinary.com/dxx8u5qnr/image/upload/v1730128442/10_haa16t.jpg',2),
(11, N'The Watermelon Game', 'https://cdn.htmlgames.com/TheWatermelonGame/','https://res.cloudinary.com/dxx8u5qnr/image/upload/v1730128447/11_mfk2fp.png' ,5),
(12, N'Double Klondike', 'https://cdn.htmlgames.com/DoubleKlondike/','https://res.cloudinary.com/dxx8u5qnr/image/upload/v1730128446/12_chkpc8.png' ,4),
(13, N'Water Sort', 'https://cdn.htmlgames.com/WaterSort/', 'https://res.cloudinary.com/dxx8u5qnr/image/upload/v1730128451/13_ln7tcj.png',1),
(14, N'Jungle Sniper', 'https://cdn.htmlgames.com/JungleSniper/', 'https://res.cloudinary.com/dxx8u5qnr/image/upload/v1730128449/14_s56l3x.png',6),
(15, N'Kitty Mahjong', 'https://cdn.htmlgames.com/KittyMahjong/','https://res.cloudinary.com/dxx8u5qnr/image/upload/v1730128455/15_vzjess.png' ,6),
(16, N'Balloon Maze', 'https://cdn.htmlgames.com/BalloonMaze/','https://res.cloudinary.com/dxx8u5qnr/image/upload/v1730128456/16_duqruw.png' ,2),
(17, N'Mysterious Pirate Jewels 3', 'https://cdn.htmlgames.com/MysteriousPirateJewels3/','https://res.cloudinary.com/dxx8u5qnr/image/upload/v1730128453/17_urluf9.png' ,2),
(18, N'Aladdin Solitaire', 'https://cdn.htmlgames.com/AladdinSolitaire/','https://res.cloudinary.com/dxx8u5qnr/image/upload/v1730128463/18_linw8x.png' ,3),
(19, N'Tap It Away 3D', 'https://cdn.htmlgames.com/TapItAway3D/','https://res.cloudinary.com/dxx8u5qnr/image/upload/v1730128459/19_nbcgxt.png' ,5),
(20, N'Pyramid Solitaire - Ancient China', 'https://cdn.htmlgames.com/PyramidSolitaire-AncientChina/','https://res.cloudinary.com/dxx8u5qnr/image/upload/v1730128467/20_d8w2fu.png' ,2),
(21, N'Ninja Breakout', 'https://cdn.htmlgames.com/NinjaBreakout/', 'https://res.cloudinary.com/dxx8u5qnr/image/upload/v1730128462/21_atiu5f.png',6),
(22, N'Bubble Throw', 'https://cdn.htmlgames.com/BubbleThrow/', 'https://res.cloudinary.com/dxx8u5qnr/image/upload/v1730128473/22_tvl6jc.png',6),
(23, N'Freecell Extreme', 'https://cdn.htmlgames.com/FreecellExtreme/','https://res.cloudinary.com/dxx8u5qnr/image/upload/v1730128474/23_ardt0p.png',4),
(24, N'Connect the Dots', 'https://cdn.htmlgames.com/ConnectTheDots/','https://res.cloudinary.com/dxx8u5qnr/image/upload/v1730128466/24_szcuqa.png' ,5),
(25, N'Harbour Escape', 'https://cdn.htmlgames.com/HarbourEscape/', 'https://res.cloudinary.com/dxx8u5qnr/image/upload/v1730128476/25_nag1rk.png',1),
(26, N'Flower World 2', 'https://cdn.htmlgames.com/FlowerWorld2/','https://res.cloudinary.com/dxx8u5qnr/image/upload/v1730128478/26_hrruhx.png' ,1),
(27, N'Black and White Mahjong 3', 'https://cdn.htmlgames.com/BlackAndWhiteMahjong3/','https://res.cloudinary.com/dxx8u5qnr/image/upload/v1730128471/27_uimb29.png' ,3),
(28, N'Archery Training', 'https://cdn.htmlgames.com/ArcheryTraining/','https://res.cloudinary.com/dxx8u5qnr/image/upload/v1730128480/28_sdcsmp.png' ,6),
(29, N'Spooky Dimensions', 'https://cdn.htmlgames.com/SpookyDimensions/','https://res.cloudinary.com/dxx8u5qnr/image/upload/v1730128482/29_xpuh9w.png' ,5),
(30, N'Circus Match 3', 'https://cdn.htmlgames.com/CircusMatch3/', 'https://res.cloudinary.com/dxx8u5qnr/image/upload/v1730128484/30_s6hfa9.png',5);


go
select * from game

CREATE TABLE UserActivityLog (
    log_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    activity_type VARCHAR(50) NOT NULL,
    activity_details NVARCHAR(MAX),
    post_id INT NULL,
    comment_id INT NULL,
    timestamp DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES userAccount(user_id),
    FOREIGN KEY (post_id) REFERENCES post(post_id),
    FOREIGN KEY (comment_id) REFERENCES comment(comment_id) 
);
go
CREATE TRIGGER TR_Post_Activity
ON post
AFTER INSERT, UPDATE
AS
BEGIN
 
    INSERT INTO UserActivityLog (user_id, activity_type, activity_details, post_id)
    SELECT 
        i.user_id,
        'POST_CREATED',
        i.body, 
        i.post_id
    FROM inserted i
    WHERE NOT EXISTS (SELECT 1 FROM deleted);

   
    INSERT INTO UserActivityLog (user_id, activity_type, activity_details, post_id)
    SELECT 
        i.user_id,
        'POST_UPDATED',
        'Changed from: ' + ISNULL(d.body, 'empty') + ' to: ' + ISNULL(i.body, 'empty'), -- Show content change
        i.post_id
    FROM inserted i
    INNER JOIN deleted d ON i.post_id = d.post_id;
END;

go
CREATE TRIGGER TR_Comment_Activity
ON comment
AFTER INSERT, UPDATE
AS
BEGIN
 
    INSERT INTO UserActivityLog (user_id, activity_type, activity_details, post_id, comment_id)
    SELECT 
        i.user_id,
        'COMMENT_CREATED',
        i.comment_text, 
        i.post_id,
        i.comment_id
    FROM inserted i
    WHERE NOT EXISTS (SELECT 1 FROM deleted);

  
    INSERT INTO UserActivityLog (user_id, activity_type, activity_details, post_id, comment_id)
    SELECT 
        i.user_id,
        'COMMENT_UPDATED',
        'Changed from: ' + ISNULL(d.comment_text, 'empty') + ' to: ' + ISNULL(i.comment_text, 'empty'), -- Show content change
        i.post_id,
        i.comment_id
    FROM inserted i
    INNER JOIN deleted d ON i.comment_id = d.comment_id;

 
    
END;



GO
CREATE TABLE product (
    product_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    product_name NVARCHAR(255) NOT NULL,
    product_description NVARCHAR(500), 
	product_img text NOT NULL,
    product_tag NVARCHAR(255) NOT NULL,
    publish_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    price DECIMAL(10, 2) NOT NULL, 
    CONSTRAINT fk_product_user_id FOREIGN KEY (user_id) REFERENCES userAccount(user_id)
);

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
