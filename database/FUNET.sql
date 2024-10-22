<<<<<<< HEAD
CREATE DATABASE FUNET;

GO
USE FUNET;

GO
DROP TABLE IF EXISTS friendship;
DROP TABLE IF EXISTS message;
DROP TABLE IF EXISTS comment;
DROP TABLE IF EXISTS post_like;
DROP TABLE IF EXISTS post;
DROP TABLE IF EXISTS conversation_user;
DROP TABLE IF EXISTS userAccount;
DROP TABLE IF EXISTS conversation;
DROP TABLE IF EXISTS product
DROP TABLE IF EXISTS learningmaterial
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS game;
drop procedure if exists getAllFriends


GO
CREATE TABLE userAccount (
  user_id INT IDENTITY(1,1) PRIMARY KEY,
  first_name NVARCHAR(50) NOT NULL,
  last_name NVARCHAR(50) NOT NULL,
  password VARCHAR(30) NULL,
  email VARCHAR(70) NOT NULL UNIQUE,
  profile_pic VARCHAR(max) NOT NULL,
  role VARCHAR(20) NOT NULL, 
  is_banned BIT NOT NULL
);

GO
CREATE TABLE friendship (
	friendship_id INT IDENTITY(1,1) PRIMARY KEY,
	sender INT,
	receiver INT,
	status nvarchar(10) NOT NULL,
	FOREIGN KEY (sender) REFERENCES userAccount (user_id),
	FOREIGN KEY (receiver) REFERENCES userAccount (user_id)
);

GO
CREATE TABLE post (
  post_id INT IDENTITY(1,1) PRIMARY KEY,
  user_id INT NOT NULL,
  body NVARCHAR(200),
  image_path NVARCHAR(max),
  post_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  like_count INT not null default 0,
  FOREIGN KEY (user_id) REFERENCES userAccount (user_id)
);

GO
CREATE TABLE post_like (
	like_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY, 
    user_id INT NOT NULL,
    post_id INT NOT NULL,
    like_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (user_id) REFERENCES userAccount (user_id),
    FOREIGN KEY (post_id) REFERENCES post(post_id)
);

GO
CREATE TABLE comment (
    comment_id INT IDENTITY(1,1) PRIMARY KEY,
    post_id INT NOT NULL,
    user_id INT NOT NULL,
    comment_text NVARCHAR(MAX) NOT NULL,
	comment_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES post (post_id),
    FOREIGN KEY (user_id) REFERENCES userAccount (user_id)
);

GO
CREATE TABLE conversation (
	conversation_id INT PRIMARY KEY, 
	conversation_name NVARCHAR(50),
	conversation_avatar nvarchar(50) NOT NULL
);

GO
CREATE TABLE message (
	message_id INT IDENTITY(1,1) PRIMARY KEY,
	sender INT NOT NULL,
	receiver INT,
	conversation_id INT NULL,
	message_text NVARCHAR(400) NOT NULL,
	message_type VARCHAR(40) NOT NULL,
	sent_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (sender) REFERENCES userAccount (user_id),
	FOREIGN KEY (receiver) REFERENCES userAccount (user_id),
	FOREIGN KEY (conversation_id) REFERENCES conversation (conversation_id)
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
CREATE TABLE product (
    product_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    product_name VARCHAR(255) NOT NULL,
    product_description VARCHAR(255) NOT NULL,
    product_tag VARchAR(255) NOT NULL,
    publish_date DATE NOT NULL,
    price INT NOT NULL,
    CONSTRAINT fk_product_user_id FOREIGN KEY (user_id) REFERENCES userAccount(user_id)
);

GO
CREATE TABLE learningmaterial (
    learningmaterial_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    learningmaterial_name VARCHAR(255) NOT NULL,
    learningmaterial_description VARCHAR(255) NOT NULL,
    subject_code VARCHAR(7) NOT NULL,
    publish_date DATE NOT NULL,
    review TEXT NOT NULL,
    CONSTRAINT fk_learningmaterial_user_id FOREIGN KEY (user_id) REFERENCES userAccount(user_id)
);

GO
CREATE TABLE categories (
    tag_id INT PRIMARY KEY IDENTITY(1,1),
    tag_name NVARCHAR(50) NOT NULL
);

GO
CREATE TABLE game (
    game_id INT PRIMARY KEY,
    game_name NVARCHAR(50) NOT NULL,
    game_link NVARCHAR(200), --link embed game
    tag_id INT,
    FOREIGN KEY (tag_id) REFERENCES categories(tag_id)
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

SELECT sender, message_text, receiver FROM message WHERE (sender = 1 AND receiver = 0) OR (sender = 0 AND receiver = 1) ORDER BY sent_date ASC;
=======
CREATE DATABASE FUNET;

GO
USE FUNET;

GO
DROP TABLE IF EXISTS friendship;
DROP TABLE IF EXISTS message;
DROP TABLE IF EXISTS comment;
DROP TABLE IF EXISTS post_like;
DROP TABLE IF EXISTS post;
DROP TABLE IF EXISTS conversation_member;
DROP TABLE IF EXISTS userAccount;
DROP TABLE IF EXISTS conversation;
DROP TABLE IF EXISTS product
DROP TABLE IF EXISTS learningmaterial
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS game;
drop procedure if exists getAllFriends


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
  is_banned BIT NOT NULL
);

GO
CREATE TABLE friendship (
	friendship_id INT IDENTITY(1,1) PRIMARY KEY,
	sender INT,
	receiver INT,
	status nvarchar(10) NOT NULL,
	FOREIGN KEY (sender) REFERENCES userAccount (user_id),
	FOREIGN KEY (receiver) REFERENCES userAccount (user_id)
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
  FOREIGN KEY (user_id) REFERENCES userAccount (user_id)
);
GO
CREATE TABLE post_like (
	like_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY, 
    user_id INT NOT NULL,
    post_id INT NOT NULL,
    like_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (user_id) REFERENCES userAccount (user_id),
    FOREIGN KEY (post_id) REFERENCES post(post_id)
);

GO
CREATE TABLE comment (
    comment_id INT IDENTITY(1,1) PRIMARY KEY,
    post_id INT NOT NULL,
    user_id INT NOT NULL,
    comment_text NVARCHAR(MAX) NOT NULL,
	comment_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES post (post_id),
    FOREIGN KEY (user_id) REFERENCES userAccount (user_id)
);

GO
CREATE TABLE conversation (
	conversation_id INT PRIMARY KEY, 
	conversation_name NVARCHAR(50),
	conversation_avater nvarchar(50) NOT NULL
);

GO
CREATE TABLE message (
	message_id INT IDENTITY(1,1) PRIMARY KEY,
	sender INT NOT NULL,
	receiver INT,
	conversation_id INT NULL,
	message_text NVARCHAR(400) NOT NULL,
	message_type VARCHAR(40) NOT NULL,
	sent_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (sender) REFERENCES userAccount (user_id),
	FOREIGN KEY (receiver) REFERENCES userAccount (user_id),
	FOREIGN KEY (conversation_id) REFERENCES conversation (conversation_id)
);

GO 
CREATE TABLE conversation_member (
	is_admin BIT NOT NULL,
	user_id INT,
	conversation_id INT,
	FOREIGN KEY (user_id) REFERENCES userAccount(user_id),
	FOREIGN KEY (conversation_id) REFERENCES conversation (conversation_id),
	PRIMARY KEY (user_id, conversation_id)
);

GO
CREATE TABLE product (
    product_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    product_name VARCHAR(255) NOT NULL,
    product_description VARCHAR(255) NOT NULL,
    product_tag VARchAR(255) NOT NULL,
    publish_date DATE NOT NULL,
    price INT NOT NULL,
    CONSTRAINT fk_product_user_id FOREIGN KEY (user_id) REFERENCES userAccount(user_id)
);

GO
CREATE TABLE learningmaterial (
    learningmaterial_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    learningmaterial_name VARCHAR(255) NOT NULL,
    learningmaterial_description VARCHAR(255) NOT NULL,
    subject_code VARCHAR(7) NOT NULL,
    publish_date DATE NOT NULL,
    review TEXT NOT NULL,
    CONSTRAINT fk_learningmaterial_user_id FOREIGN KEY (user_id) REFERENCES userAccount(user_id)
);

GO
CREATE TABLE categories (
    tag_id INT PRIMARY KEY IDENTITY(1,1),
    tag_name NVARCHAR(50) NOT NULL
);

GO
CREATE TABLE game (
    game_id INT PRIMARY KEY,
    game_name NVARCHAR(50) NOT NULL,
    game_link NVARCHAR(200), --link embed game
    tag_id INT,
    FOREIGN KEY (tag_id) REFERENCES categories(tag_id)
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

SELECT sender, message_text, receiver FROM message WHERE (sender = 1 AND receiver = 0) OR (sender = 0 AND receiver = 1) ORDER BY sent_date ASC;

GO
CREATE TABLE post_share (
    share_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    post_id INT NOT NULL,
    share_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_share_user FOREIGN KEY (user_id) REFERENCES userAccount (user_id),
    CONSTRAINT fk_share_post FOREIGN KEY (post_id) REFERENCES post (post_id)
);



SELECT * FROM comment
SELECT * FROM post
SELECT * FROM userAccount
UPDATE post
SET privacy_mode = 'public'
WHERE post_id = 122;

>>>>>>> origin/Ha3_Uc
