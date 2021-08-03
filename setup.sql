USE [master]
GO
/****** Object:  Database [QandA]    Script Date: 8/3/2021 10:06:01 AM ******/
CREATE DATABASE [QandA]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QandA', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\QandA.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'QandA_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\QandA_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [QandA] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QandA].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QandA] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QandA] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QandA] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QandA] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QandA] SET ARITHABORT OFF 
GO
ALTER DATABASE [QandA] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [QandA] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QandA] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QandA] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QandA] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QandA] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QandA] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QandA] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QandA] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QandA] SET  DISABLE_BROKER 
GO
ALTER DATABASE [QandA] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QandA] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QandA] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QandA] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QandA] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QandA] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QandA] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QandA] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [QandA] SET  MULTI_USER 
GO
ALTER DATABASE [QandA] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QandA] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QandA] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QandA] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [QandA] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [QandA] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [QandA] SET QUERY_STORE = OFF
GO
USE [QandA]
GO
/****** Object:  Table [dbo].[Answer]    Script Date: 8/3/2021 10:06:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Answer](
	[AnswerId] [int] IDENTITY(1,1) NOT NULL,
	[QuestionId] [int] NOT NULL,
	[Content] [nvarchar](max) NOT NULL,
	[UserId] [nvarchar](150) NOT NULL,
	[UserName] [nvarchar](150) NOT NULL,
	[Created] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Answer] PRIMARY KEY CLUSTERED 
(
	[AnswerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Question]    Script Date: 8/3/2021 10:06:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Question](
	[QuestionId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](100) NOT NULL,
	[Content] [nvarchar](max) NOT NULL,
	[UserId] [nvarchar](150) NOT NULL,
	[UserName] [nvarchar](150) NOT NULL,
	[Created] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Question] PRIMARY KEY CLUSTERED 
(
	[QuestionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SchemaVersions]    Script Date: 8/3/2021 10:06:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SchemaVersions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ScriptName] [nvarchar](255) NOT NULL,
	[Applied] [datetime] NOT NULL,
 CONSTRAINT [PK_SchemaVersions_Id] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Answer]  WITH CHECK ADD  CONSTRAINT [FK_Answer_Question] FOREIGN KEY([QuestionId])
REFERENCES [dbo].[Question] ([QuestionId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Answer] CHECK CONSTRAINT [FK_Answer_Question]
GO
/****** Object:  StoredProcedure [dbo].[Answer_Delete]    Script Date: 8/3/2021 10:06:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Answer_Delete]
	(
	@AnswerId int
)
AS
BEGIN
	SET NOCOUNT ON

	DELETE
	FROM dbo.Answer
	WHERE AnswerID = @AnswerId
END
GO
/****** Object:  StoredProcedure [dbo].[Answer_Get_ByAnswerId]    Script Date: 8/3/2021 10:06:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Answer_Get_ByAnswerId]
	(
	@AnswerId int
)
AS
BEGIN
	SET NOCOUNT ON

	SELECT AnswerId, Content, Username, Created
	FROM dbo.Answer 
	WHERE AnswerId = @AnswerId
END
GO
/****** Object:  StoredProcedure [dbo].[Answer_Get_ByQuestionId]    Script Date: 8/3/2021 10:06:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Answer_Get_ByQuestionId]
	(
	@QuestionId int
)
AS
BEGIN
	SET NOCOUNT ON

	SELECT AnswerId, QuestionId, Content, Username, Created
	FROM dbo.Answer 
	WHERE QuestionId = @QuestionId
END
GO
/****** Object:  StoredProcedure [dbo].[Answer_Post]    Script Date: 8/3/2021 10:06:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Answer_Post]
	(
	@QuestionId int,
	@Content nvarchar(max),
	@UserId nvarchar(150),
	@UserName nvarchar(150),
	@Created datetime2
)
AS
BEGIN
	SET NOCOUNT ON

	INSERT INTO dbo.Answer
		(QuestionId, Content, UserId, UserName, Created)
	SELECT @QuestionId, @Content, @UserId, @UserName, @Created

	SELECT AnswerId, Content, UserName, UserId, Created
	FROM dbo.Answer
	WHERE AnswerId = SCOPE_IDENTITY()
END
GO
/****** Object:  StoredProcedure [dbo].[Answer_Put]    Script Date: 8/3/2021 10:06:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Answer_Put]
	(
	@AnswerId int,
	@Content nvarchar(max)
)
AS
BEGIN
	SET NOCOUNT ON

	UPDATE dbo.Answer
	SET Content = @Content
	WHERE AnswerId = @AnswerId

	SELECT a.AnswerId, a.QuestionId, a.Content, u.UserName, a.Created
	FROM dbo.Answer a
		LEFT JOIN AspNetUsers u ON a.UserId = u.Id
	WHERE AnswerId = @AnswerId
END
GO
/****** Object:  StoredProcedure [dbo].[Question_AddForLoadTest]    Script Date: 8/3/2021 10:06:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Question_AddForLoadTest]
AS
BEGIN
	DECLARE @i int = 1

	WHILE @i < 10000
	BEGIN
		INSERT INTO dbo.Question
			(Title, Content, UserId, UserName, Created)
		VALUES('Question ' + CAST(@i AS nvarchar(5)), 'Content ' + CAST(@i AS nvarchar(5)), 'User1', 'User1', GETUTCDATE())
		SET @i = @i + 1
	END
END
GO
/****** Object:  StoredProcedure [dbo].[Question_Delete]    Script Date: 8/3/2021 10:06:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Question_Delete]
	(
	@QuestionId int
)
AS
BEGIN
	SET NOCOUNT ON

	DELETE
	FROM dbo.Question
	WHERE QuestionID = @QuestionId
END
GO
/****** Object:  StoredProcedure [dbo].[Question_Exists]    Script Date: 8/3/2021 10:06:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Question_Exists]
	(
	@QuestionId int
)
AS
BEGIN
	SET NOCOUNT ON

	SELECT CASE WHEN EXISTS (SELECT QuestionId
		FROM dbo.Question
		WHERE QuestionId = @QuestionId) 
        THEN CAST (1 AS BIT) 
        ELSE CAST (0 AS BIT) END AS Result

END
GO
/****** Object:  StoredProcedure [dbo].[Question_GetMany]    Script Date: 8/3/2021 10:06:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Question_GetMany]
AS
BEGIN
	SET NOCOUNT ON

	SELECT QuestionId, Title, Content, UserId, UserName, Created
	FROM dbo.Question 
END
GO
/****** Object:  StoredProcedure [dbo].[Question_GetMany_BySearch]    Script Date: 8/3/2021 10:06:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Question_GetMany_BySearch]
	(
	@Search nvarchar(100)
)
AS
BEGIN
	SET NOCOUNT ON

		SELECT QuestionId, Title, Content, UserId, UserName, Created
		FROM dbo.Question 
		WHERE Title LIKE '%' + @Search + '%'

	UNION

		SELECT QuestionId, Title, Content, UserId, UserName, Created
		FROM dbo.Question 
		WHERE Content LIKE '%' + @Search + '%'
END
GO
/****** Object:  StoredProcedure [dbo].[Question_GetMany_BySearch_WithPaging]    Script Date: 8/3/2021 10:06:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Question_GetMany_BySearch_WithPaging]
	(
	@Search nvarchar(100),
	@PageNumber int,
	@PageSize int
)
AS
BEGIN
	SELECT QuestionId, Title, Content, UserId, UserName, Created
	FROM
		(	SELECT QuestionId, Title, Content, UserId, UserName, Created
			FROM dbo.Question 
			WHERE Title LIKE '%' + @Search + '%'

		UNION

			SELECT QuestionId, Title, Content, UserId, UserName, Created
			FROM dbo.Question 
			WHERE Content LIKE '%' + @Search + '%') Sub
	ORDER BY QuestionId
	OFFSET @PageSize * (@PageNumber - 1) ROWS
    FETCH NEXT @PageSize ROWS ONLY
END
GO
/****** Object:  StoredProcedure [dbo].[Question_GetMany_WithAnswers]    Script Date: 8/3/2021 10:06:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Question_GetMany_WithAnswers]
AS
BEGIN
	SET NOCOUNT ON

	SELECT q.QuestionId, q.Title, q.Content, q.UserName, q.Created,
		a.QuestionId, a.AnswerId, a.Content, a.Username, a.Created
	FROM dbo.Question q
		LEFT JOIN dbo.Answer a ON q.QuestionId = a.QuestionId
END
GO
/****** Object:  StoredProcedure [dbo].[Question_GetSingle]    Script Date: 8/3/2021 10:06:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Question_GetSingle]
	(
	@QuestionId int
)
AS
BEGIN
	SET NOCOUNT ON

	SELECT QuestionId, Title, Content, UserId, Username, Created
	FROM dbo.Question 
	WHERE QuestionId = @QuestionId
END
GO
/****** Object:  StoredProcedure [dbo].[Question_GetUnanswered]    Script Date: 8/3/2021 10:06:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Question_GetUnanswered]
AS
BEGIN
	SET NOCOUNT ON

	SELECT QuestionId, Title, Content, UserId, UserName, Created
	FROM dbo.Question q
	WHERE NOT EXISTS (SELECT *
	FROM dbo.Answer a
	WHERE a.QuestionId = q.QuestionId)
END
GO
/****** Object:  StoredProcedure [dbo].[Question_Post]    Script Date: 8/3/2021 10:06:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Question_Post]
	(
	@Title nvarchar(100),
	@Content nvarchar(max),
	@UserId nvarchar(150),
	@UserName nvarchar(150),
	@Created datetime2
)
AS
BEGIN
	SET NOCOUNT ON

	INSERT INTO dbo.Question
		(Title, Content, UserId, UserName, Created)
	VALUES(@Title, @Content, @UserId, @UserName, @Created)

	SELECT SCOPE_IDENTITY() AS QuestionId
END
GO
/****** Object:  StoredProcedure [dbo].[Question_Put]    Script Date: 8/3/2021 10:06:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Question_Put]
	(
	@QuestionId int,
	@Title nvarchar(100),
	@Content nvarchar(max)
)
AS
BEGIN
	SET NOCOUNT ON

	UPDATE dbo.Question
	SET Title = @Title, Content = @Content
	WHERE QuestionID = @QuestionId
END
GO
USE [master]
GO
ALTER DATABASE [QandA] SET  READ_WRITE 
GO
