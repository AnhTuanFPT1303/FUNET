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
drop procedure if exists checkDuplicateEmail
drop procedure if exists registerUser
drop procedure if exists getAllFriends

GO
CREATE TABLE userAccount (
  user_id INT IDENTITY(1,1) PRIMARY KEY,
  first_name NVARCHAR(50) NOT NULL,
  last_name NVARCHAR(50) NOT NULL,
  password NVARCHAR(MAX) NOT NULL,
  email VARCHAR(70) NOT NULL UNIQUE,
  profile_pic VARCHAR(MAX) NOT NULL,
  role VARCHAR(20) NOT NULL, 
  is_banned BIT NOT NULL,
);

GO
CREATE TABLE friendship (
	friendship_id INT IDENTITY(1,1) PRIMARY KEY,
	sender INT,
	receiver INT,
	status nvarchar(10) NOT NULL,
	CONSTRAINT fk_user_request FOREIGN KEY (sender) REFERENCES userAccount (user_id) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT fk_user_accept FOREIGN KEY (receiver) REFERENCES userAccount (user_id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

GO
CREATE TABLE post (
  post_id INT IDENTITY(1,1) PRIMARY KEY,
  user_id INT NOT NULL,
  body NVARCHAR(200),
  image_path NVARCHAR(max),
  post_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  like_count INT not null default 0,
  CONSTRAINT fk_post_user FOREIGN KEY (user_id) REFERENCES userAccount (user_id) ON DELETE CASCADE ON UPDATE CASCADE
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
    CONSTRAINT fk_comment_post FOREIGN KEY (post_id) REFERENCES post (post_id) ON DELETE CASCADE,
    CONSTRAINT fk_comment_user FOREIGN KEY (user_id) REFERENCES userAccount (user_id)
);

GO
CREATE TABLE conversation (
	conversation_id INT PRIMARY KEY, 
	conversation_name NVARCHAR(50),
	conversation_avater nvarchar(50) NOT NULL
)

GO
CREATE TABLE message (
	message_id INT IDENTITY(1,1) PRIMARY KEY,
	sender INT NOT NULL,
	receiver INT,
	conversation_id INT NOT NULL,
	message_text NVARCHAR(400) NOT NULL,
	message_type VARCHAR(40) NOT NULL,
	sent_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT fk_sender FOREIGN KEY (sender) REFERENCES userAccount (user_id) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT fk_receiver FOREIGN KEY (receiver) REFERENCES userAccount (user_id) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT fk_conversation_id FOREIGN KEY (conversation_id) REFERENCES conversation (conversation_id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

GO 
CREATE TABLE conversation_member (
	is_admin BIT NOT NULL,
	user_id INT,
	conversation_id INT,
	CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES userAccount(user_id),
	CONSTRAINT fk_convesation FOREIGN KEY (conversation_id) REFERENCES conversation (conversation_id) ON DELETE NO ACTION ON UPDATE NO ACTION,
	PRIMARY KEY (user_id, conversation_id)
)

GO
CREATE PROCEDURE getAllFriends
    @user_id INT
AS
BEGIN
    SELECT
        u2.first_name,
        u2.last_name,
        u2.profile_pic,
        f.status
    FROM userAccount u1
    JOIN
        friendship f ON (u1.user_id = f.sender OR u1.user_id = f.receiver)
    JOIN 
        userAccount u2 ON (u2.user_id = f.sender OR u2.user_id = f.receiver) AND u2.user_id != u1.user_id
    WHERE 
        u1.user_id = @user_id
        AND f.status = 'accepted';
END;

INSERT INTO userAccount (first_name, last_name, password, email, profile_pic, role, is_banned, salt) 
VALUES 
('Nguyen', 'Tuan', '123', 'anhtuan123@gmail.com', 'default_avt.jpg', 'student', 0), 
('Ha', 'Phan', '123', 'haphan123@gmail.com', 'default_avt.jpg', 'staff', 0), 
('Thanh', 'Tung', '123', 'thanhtung123@gmail.com', 'default_avt.jpg', 'student', 1);


Go
Select * from userAccount