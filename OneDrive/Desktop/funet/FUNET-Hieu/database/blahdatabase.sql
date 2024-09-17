CREATE DATABASE Blah;
GO

USE Blah;
GO

DROP TABLE IF EXISTS friendship;
DROP TABLE IF EXISTS message;
DROP TABLE IF EXISTS comment;
DROP TABLE IF EXISTS post_like;
DROP TABLE IF EXISTS post;
DROP TABLE IF EXISTS userAccount;
drop procedure if exists checkDuplicateEmail
drop procedure if exists registerUser
drop procedure if exists getAllFriends
GO

CREATE TABLE userAccount (
  user_id INT IDENTITY(1,1) PRIMARY KEY,
  first_name NVARCHAR(100) NOT NULL,
  last_name NVARCHAR(100) NOT NULL,
  password VARCHAR(20) NOT NULL,
  email VARCHAR(50) NOT NULL UNIQUE,
  profile_pic nvarchar(max) NOT NULL
);

GO
CREATE TABLE friendship (
	user_request int,
	user_accept int,
	status nvarchar(10) not null,
	CONSTRAINT fk_user_request FOREIGN KEY (user_request) REFERENCES userAccount (user_id) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT fk_user_accept FOREIGN KEY (user_accept) REFERENCES userAccount (user_id) ON DELETE NO ACTION ON UPDATE NO ACTION
);
GO

CREATE TABLE message (
  chat_id INT IDENTITY(1,1) PRIMARY KEY,
  from_user INT NOT NULL,
  to_user INT NOT NULL,
  message NVARCHAR(400) NOT NULL,
  chat_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_from_user FOREIGN KEY (from_user) REFERENCES userAccount (user_id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT fk_to_user FOREIGN KEY (to_user) REFERENCES userAccount (user_id) ON DELETE NO ACTION ON UPDATE NO ACTION
);
GO

CREATE TABLE post (
  post_id INT IDENTITY(1,1) PRIMARY KEY,
  user_id INT NOT NULL,
  body VARCHAR(500) NOT NULL,
  image_path varchar(max) NULL,
  post_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  like_count INT not null default 0,
  CONSTRAINT fk_post_user FOREIGN KEY (user_id) REFERENCES userAccount (user_id) ON DELETE CASCADE ON UPDATE CASCADE
);

GO
CREATE TABLE post_like (
    user_id INT NOT NULL,
    post_id INT NOT NULL,
    like_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, post_id),
	CONSTRAINT fk_like_user FOREIGN KEY (user_id) REFERENCES userAccount (user_id),
    CONSTRAINT fk_like_post FOREIGN KEY (post_id) REFERENCES post (post_id)
);

GO
CREATE TABLE comment (
    comment_id INT IDENTITY(1,1) PRIMARY KEY,
    post_id INT NOT NULL,
    user_id INT NOT NULL,
    comment_text NVARCHAR(MAX) NOT NULL,
    CONSTRAINT fk_comment_post FOREIGN KEY (post_id) REFERENCES post (post_id) ON DELETE CASCADE,
    CONSTRAINT fk_comment_user FOREIGN KEY (user_id) REFERENCES userAccount (user_id)
);

GO
CREATE PROCEDURE registerUser
    @first_name varchar(20),
    @last_name varchar(20),
    @password varchar(20),
    @email varchar(50)
AS
	BEGIN TRANSACTION	
    
	IF EXISTS (
        SELECT 1
        FROM userAccount
        WHERE email = @email
    )
    BEGIN
        ROLLBACK TRANSACTION;
		THROW 5000, 'Duplicated Email.', 1;
        RETURN;
    END
    
    INSERT INTO userAccount (first_name, last_name, password, email) 
    VALUES (@first_name, @last_name, @password, @email)
    
    COMMIT TRANSACTION;

GO
CREATE PROCEDURE getAllFriends
    @userId INT
AS
BEGIN
    SELECT u.first_name, u.last_name, u.profile_pic, f.status
    FROM userAccount u
    INNER JOIN friendship f ON f.user_request = u.user_id
    WHERE f.user_accept = @userId AND f.status = 'accepted'
    
    UNION
    
    -- Select users who have accepted and requested a friendship with the specified user
    SELECT u.first_name, u.last_name, u.profile_pic, f.status
    FROM userAccount u
    INNER JOIN friendship f ON f.user_accept = u.user_id
    WHERE f.user_request = @userId AND f.status = 'accepted';
END;

Go
Select * from userAccount

insert into userAccount values ('Nguyen', 'Tuan' , '123', 'nguyenhuuanhtuan123@gmail.com', 'assets/profile_avt/default_avt.jpg')
insert into userAccount values ('Ha', 'Phan', '123', 'haphan123@gmail.com', 'assets/profile_avt/default_avt.jpg')
insert into userAccount values ('Tung', 'Nui', '123', 'tungnui123@gmail.com', 'assets/profile_avt/default_avt.jpg')
insert into userAccount values ('Tuan', 'Khi', '123', 'tuankhi123@gmail.com', 'assets/profile_avt/default_avt.jpg')
