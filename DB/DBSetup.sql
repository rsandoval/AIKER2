-- -----------------------------------------------------------------------------
-- CONFIDENCIAL:
-- Este es un archivo de código fuente propiedad de RSolver SpA y está protegido
-- bajo derechos de autor y leyes de protección a la propiedad intelectual.
-- Ud. no debe ver, revisar, copiar, transferir, utilizar, compartir, o distribuir este archivo
-- excepto que cuente con la expresa licencia y/o autorización de RSolver SpA.
-- -----------------------------------------------------------------------------
--
--		Script de Creación y Setup de Base de Datos - SQL Server 201X
--		AIKER: AI-based Knowledge Enhancer & Reviewer
--
--  	Copyright © 2019-2020 RSolver SpA 
--  	Todos los derechos reservados sobre este código fuente
--		All rights reserved over this source code
--		Created: March 2019 by Rodrigo Sandoval U. (rodrigo@rsolver.com)
--		Last significant update: Sep 2020 by RSU
-- 		... and then some more (not-so-drastic) updates throughout 2021 to 2023
-- -----------------------------------------------------------------------------

-- -------------------------------------------------
-- Database Creation
-- -------------------------------------------------

IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = 'AIKER') DROP DATABASE [AIKER]
GO
CREATE DATABASE [AIKER]
GO
USE [AIKER]
GO




/* DELETE OperationalTables
DROP TABLE Student
DROP TABLE ScheduledTest
DROP TABLE TestQuestion
DROP TABLE StudentTest
DROP TABLE StudentTestAnswer
*/

/* DELETE Parametric Tables

*/

-- -------------------------------------------------
-- 	Parametric Tables
-- -------------------------------------------------







-- -------------------------------------------------
-- 	Operational Tables
-- -------------------------------------------------
SET ANSI_NULLS ON
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Organization](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,

 CONSTRAINT [PK_Organization] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Course](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[OrganizationID] [int] NOT NULL,

 CONSTRAINT [PK_Course] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Student](
[ID] [int] IDENTITY(1,1) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[OrganizationID] [int] NULL,
	[CourseID] [int] NULL,
	[Phone] [varchar](20) NULL,
	[PersonalID] [varchar](20) NULL,
	[SerialNumber] [varchar](20) NULL,
	[PreferredName] [varchar](20) NULL,
	[Active] [bit] NULL,


 CONSTRAINT [PK_Student] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Action](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[StudentID] [int] NOT NULL,
	[ActionDate] [datetime] NOT NULL,
	[ActionType] [int] NOT NULL,
	[ActionInput] [varchar](MAX) NOT NULL,
	[ActionResult] [varchar](MAX) NOT NULL,

 CONSTRAINT [PK_Action] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [IX_ActionStudent] ON [dbo].[Action] 
(
	[StudentID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_ActionDate] ON [dbo].[Action] 
(
	[ActionDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO





SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ScheduledTest](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](50) NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NOT NULL,
	[NumberOfQuestions] [int] NOT NULL,
	[CourseID] [int] NOT NULL,
	[MaxScore] [float] NOT NULL,
	[ScoreUnit] [varchar](5) NOT NULL,
	[TakeOnline] [bit] NOT NULL,
	[ScoreUnit] [varchar](1500) NOT NULL,

 CONSTRAINT [PK_ScheduledTest] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [IX_ScheduledTestCourse] ON [dbo].[ScheduledTest] 
(
	[CourseID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TestQuestion](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ScheduledTestID] [int] NOT NULL,
	[QuestionGroup] [int] NOT NULL,
	[QuestionText] [varchar](1500) NOT NULL,
	[MaxScore] [float] NOT NULL,
	[PartialAnswers] [varchar](1500) NOT NULL,
	[ReferenceLink] [varchar](MAX) NOT NULL,
	[QuestionSubject] [varchar](500) NOT NULL,
	[RobotAnswer] [varchar](MAX) NOT NULL,

 CONSTRAINT [PK_TestQuestion] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [IX_TestQuestionScheduledTest] ON [dbo].[TestQuestion] 
(
	[ScheduledTestID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ReferenceAnswer](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TestQuestionID] [int] NOT NULL,
	[AnswerText] [varchar](MAX) NOT NULL,
	[AnswerScore] [float] NOT NULL,

 CONSTRAINT [PK_ReferenceAnswer] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [IX_TestQuestionReferenceAnswer] ON [dbo].[ReferenceAnswer] 
(
	[TestQuestionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[StudentTest](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[StudentID] [int] NOT NULL,
	[ScheduledTestID] [int] NOT NULL,
	[InitialToken] [varchar](50) NOT NULL,
	[TestDate] [datetime] NOT NULL,
	[FinalScore] [float] NOT NULL,
	[Finished] [bit] NOT NULL,
	[Reviewed] [bit] NOT NULL,

 CONSTRAINT [PK_StudentTest] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_StudentTestStudent] ON [dbo].[StudentTest] 
(
	[StudentID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_StudentTestScheduledTest] ON [dbo].[StudentTest] 
(
	[ScheduledTestID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[StudentTestAnswer](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TestQuestionID] [int] NOT NULL,
	[TestAnswerNumber] [int] NOT NULL,
	[StudentTestID] [int] NOT NULL,
	[AnswerDate] [datetime] NOT NULL,
	[AnswerText] [varchar](MAX) NOT NULL,
	[AnswerAutoScore] [float] NOT NULL,
	[AnswerRevisedScore] [float] NOT NULL,
	[ReviewText] [varchar](MAX) NOT NULL,
	[AnswerSimilarityScore] [float] NULL,
	[WasReviewed] [bit] NULL,
	[RobotSimilarityScore] [float] NULL,

 CONSTRAINT [PK_StudentTestAnswer] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_StudentTestAnswerStudentTest] ON [dbo].[StudentTestAnswer] 
(
	[StudentTestID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SimilarityScore](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TestQuestionID] [int] NOT NULL,
	[StudentTestAnswerID] [int] NOT NULL,
	[StudentTestAnswerComparedID] [int] NOT NULL,
	[Score] [float] NOT NULL,
	[Timestamp] [datetime] NOT NULL,

 CONSTRAINT [PK_SimilarityScore] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AppUser](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[OrganizationID] [int] NOT NULL,
	[CourseID] [int] NOT NULL,
	[Fullname] [varchar](50) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[PasswordNeedsChanging] [bit] NOT NULL,
	[IsAdmin] [bit] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[ConfirmationToken] [varchar](50) NULL,
	[LoginToken] [varchar](50) NULL,
	[IsConfirmed] [bit] NOT NULL,
	[PasswordFailures] [int] NOT NULL,

 CONSTRAINT [PK_AppUser] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [IX_AppUserOrganization] ON [dbo].[AppUser] 
(
	[OrganizationID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_AppUserCourse] ON [dbo].[AppUser] 
(
	[CourseID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_AppUserEmail] ON [dbo].[AppUser] 
(
	[Email] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO





-- ------------------------------------------------
-- ------------------------------------------------
-- ------------------------------------------------
-- ------------------------------------------------
-- ------------------------------------------------


-- -------------------------------------------------
-- 	Stored Procedures
-- -------------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE OrganizationAll
AS
	SET NOCOUNT ON

	SELECT * FROM Organization
	
	SET NOCOUNT OFF
	RETURN
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE OrganizationRead
	(
	@idOrganization int
	)
AS
	SET NOCOUNT ON

	SELECT * FROM Organization
	WHERE ID = @idOrganization
	
	SET NOCOUNT OFF
	RETURN
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE OrganizationUpdate
	(
	@idOrganization int,	
	@name [varchar](MAX)
	)
AS
	SET NOCOUNT ON

	UPDATE Organization
	SET [Name] = @name
	WHERE ID = @idOrganization
	
	SET NOCOUNT OFF
	RETURN
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE OrganizationInsert
	(
	@name [varchar](MAX),
	@newId int OUTPUT
	)
AS
	SET NOCOUNT ON

	SET @newId = 0
	
	INSERT INTO Organization ([Name])
	VALUES (@name)
	
	SELECT @newID = MAX(ID) FROM Organization
	
	SET NOCOUNT OFF
	RETURN
GO




SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE CourseAll
AS
	SET NOCOUNT ON

	SELECT * FROM Course
	
	SET NOCOUNT OFF
	RETURN
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE CourseRead
	(
	@idCourse int
	)
AS
	SET NOCOUNT ON

	SELECT * FROM Course
	WHERE ID = @idCourse
	
	SET NOCOUNT OFF
	RETURN
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE CourseUpdate
	(
	@idCourse int,	
	@name [varchar](MAX),
	@organizationID [int]
	)
AS
	SET NOCOUNT ON

	UPDATE Course
	SET [Name] = @name, [OrganizationID] = @organizationID
	WHERE ID = @idCourse
	
	SET NOCOUNT OFF
	RETURN
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE CourseInsert
	(
	@name [varchar](MAX),
	@organizationID [int],
	@newId int OUTPUT
	)
AS
	SET NOCOUNT ON

	SET @newId = 0
	
	INSERT INTO Course ([Name], [OrganizationID])
	VALUES (@name, @organizationID)
	
	SELECT @newID = MAX(ID) FROM Course
	
	SET NOCOUNT OFF
	RETURN
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE StudentAll
AS
	SET NOCOUNT ON

	SELECT * FROM Student
	
	SET NOCOUNT OFF
	RETURN
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE StudentRead
	(
	@idStudent int
	)
AS
	SET NOCOUNT ON

	SELECT * FROM Student
	WHERE ID = @idStudent
	
	SET NOCOUNT OFF
	RETURN
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE StudentReadFromEmail
	(
	@email [varchar](MAX)
	)
AS
	SET NOCOUNT ON

	SELECT * FROM Student
	WHERE Email = @email
	
	SET NOCOUNT OFF
	RETURN
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE StudentReadFromPhone
	(
	@phone [varchar](MAX)
	)
AS
	SET NOCOUNT ON

	SELECT * FROM Student
	WHERE Phone = @phone
	
	SET NOCOUNT OFF
	RETURN
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE StudentUpdate
	(
	@idStudent int,	
	@email [varchar](MAX),
	@name [varchar](MAX),
	@startDate [datetime],
	@organizationID [int],
	@courseID [int],
	@phone [varchar](MAX),
	@personalID [varchar](MAX),
	@serialNumber [varchar](MAX),
	@preferredName [varchar](MAX),
	@active [bit]
	)
AS
	SET NOCOUNT ON

	UPDATE Student
	SET [Email] = @email, [Name] = @name, [StartDate] = @startDate, [OrganizationID] = @organizationID, [CourseID] = @courseID, [Phone] = @phone, [PersonalID] = @personalID, [SerialNumber] = @serialNumber, [PreferredName] = @preferredName, [Active] = @active
	WHERE ID = @idStudent
	
	SET NOCOUNT OFF
	RETURNGO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE StudentInsert
	(
	@email [varchar](MAX),
	@name [varchar](MAX),
	@startDate [datetime],
	@organizationID [int],
	@courseID [int],
	@phone [varchar](MAX),
	@personalID [varchar](MAX),
	@serialNumber [varchar](MAX),
	@preferredName [varchar](MAX),
	@active [bit],
	@newId int OUTPUT
	)
AS
	SET NOCOUNT ON

	SET @newId = 0
	
	INSERT INTO Student ([Email], [Name], [StartDate], [OrganizationID], [CourseID], [Phone], [PersonalID], [SerialNumber], [PreferredName], [Active])
	VALUES (@email, @name, @startDate, @organizationID, @courseID, @phone, @personalID, @serialNumber, @preferredName, @active)
	
	SELECT @newID = MAX(ID) FROM Student
	
	SET NOCOUNT OFF
	RETURN
GO



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE ActionAll
AS
	SET NOCOUNT ON

	SELECT * FROM Action
	
	SET NOCOUNT OFF
	RETURN
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE ActionRead
	(
	@idAction int
	)
AS
	SET NOCOUNT ON

	SELECT * FROM Action
	WHERE ID = @idAction
	
	SET NOCOUNT OFF
	RETURN
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE ActionUpdate
	(
	@idAction int,	
	@studentID [int],
	@actionDate [datetime],
	@actionType [int],
	@actionInput [varchar](MAX),
	@actionResult [varchar](MAX)
	)
AS
	SET NOCOUNT ON

	UPDATE Action
	SET [StudentID] = @studentID, [ActionDate] = @actionDate, [ActionType] = @actionType, [ActionInput] = @actionInput, [ActionResult] = @actionResult
	WHERE ID = @idAction
	
	SET NOCOUNT OFF
	RETURN
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE ActionInsert
	(
	@studentID [int],
	@actionDate [datetime],
	@actionType [int],
	@actionInput [varchar](MAX),
	@actionResult [varchar](MAX),
	@newId int OUTPUT
	)
AS
	SET NOCOUNT ON

	SET @newId = 0
	
	INSERT INTO Action ([StudentID], [ActionDate], [ActionType], [ActionInput], [ActionResult])
	VALUES (@studentID, @actionDate, @actionType, @actionInput, @actionResult)
	
	SELECT @newID = MAX(ID) FROM Action
	
	SET NOCOUNT OFF
	RETURN
GO



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE ScheduledTestAll
AS
	SET NOCOUNT ON

	SELECT * FROM ScheduledTest
	
	SET NOCOUNT OFF
	RETURN
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE ScheduledTestRead
	(
	@idScheduledTest int
	)
AS
	SET NOCOUNT ON

	SELECT * FROM ScheduledTest
	WHERE ID = @idScheduledTest
	
	SET NOCOUNT OFF
	RETURN
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE ScheduledTestUpdate
	(
	@idScheduledTest int,	
	@title [varchar](MAX),
	@startDate [datetime],
	@endDate [datetime],
	@numberOfQuestions [int],
	@courseID [int],
	@maxScore [float],
	@scoreUnit [varchar](MAX),
	@takeOnline [bit],
	@headerText [varchar](MAX)
	)
AS
	SET NOCOUNT ON

	UPDATE ScheduledTest
	SET [Title] = @title, [StartDate] = @startDate, [EndDate] = @endDate, [NumberOfQuestions] = @numberOfQuestions, [CourseID] = @courseID, [MaxScore] = @maxScore, [ScoreUnit] = @scoreUnit, [TakeOnline] = @takeOnline, [HeaderText] = @headerText
	WHERE ID = @idScheduledTest
	
	SET NOCOUNT OFF
	RETURN
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE ScheduledTestInsert
	(
	@title [varchar](MAX),
	@startDate [datetime],
	@endDate [datetime],
	@numberOfQuestions [int],
	@courseID [int],
	@maxScore [float],
	@scoreUnit [varchar](MAX),
	@takeOnline [bit],
	@headerText [varchar](MAX),
	@newId int OUTPUT
	)
AS
	SET NOCOUNT ON

	SET @newId = 0
	
	INSERT INTO ScheduledTest ([Title], [StartDate], [EndDate], [NumberOfQuestions], [CourseID], [MaxScore], [ScoreUnit], [TakeOnline], [HeaderText])
	VALUES (@title, @startDate, @endDate, @numberOfQuestions, @courseID, @maxScore, @scoreUnit, @takeOnline, @headerText)
	
	SELECT @newID = MAX(ID) FROM ScheduledTest
	
	SET NOCOUNT OFF
	RETURN
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE TestQuestionAll
AS
	SET NOCOUNT ON

	SELECT * FROM TestQuestion
	
	SET NOCOUNT OFF
	RETURN
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE TestQuestionRead
	(
	@idTestQuestion int
	)
AS
	SET NOCOUNT ON

	SELECT * FROM TestQuestion
	WHERE ID = @idTestQuestion
	
	SET NOCOUNT OFF
	RETURN
GO



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE TestQuestionUpdate
	(
	@idTestQuestion int,	
	@scheduledTestID [int],
	@questionGroup [int],
	@questionText [varchar](MAX),
	@maxScore [float],
	@partialAnswers [varchar](MAX),
	@referenceLink [varchar](MAX),
	@questionSubject [varchar](MAX),
	@robotAnswer [varchar](MAX)
	)
AS
	SET NOCOUNT ON

	UPDATE TestQuestion
	SET [ScheduledTestID] = @scheduledTestID, [QuestionGroup] = @questionGroup, [QuestionText] = @questionText, [MaxScore] = @maxScore, [PartialAnswers] = @partialAnswers, [ReferenceLink] = @referenceLink, [QuestionSubject] = @questionSubject, [RobotAnswer] = @robotAnswer
	WHERE ID = @idTestQuestion
	
	SET NOCOUNT OFF
	RETURN
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE TestQuestionInsert
	(
	@scheduledTestID [int],
	@questionGroup [int],
	@questionText [varchar](MAX),
	@maxScore [float],
	@partialAnswers [varchar](MAX),
	@referenceLink [varchar](MAX),
	@questionSubject [varchar](MAX),
	@robotAnswer [varchar](MAX),
	@newId int OUTPUT
	)
AS
	SET NOCOUNT ON

	SET @newId = 0
	
	INSERT INTO TestQuestion ([ScheduledTestID], [QuestionGroup], [QuestionText], [MaxScore], [PartialAnswers], [ReferenceLink], [QuestionSubject], [RobotAnswer])
	VALUES (@scheduledTestID, @questionGroup, @questionText, @maxScore, @partialAnswers, @referenceLink, @questionSubject, @robotAnswer)
	
	SELECT @newID = MAX(ID) FROM TestQuestion
	
	SET NOCOUNT OFF
	RETURN
GO




SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE ReferenceAnswerAll
AS
	SET NOCOUNT ON

	SELECT * FROM ReferenceAnswer
	
	SET NOCOUNT OFF
	RETURN
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE ReferenceAnswerRead
	(
	@idReferenceAnswer int
	)
AS
	SET NOCOUNT ON

	SELECT * FROM ReferenceAnswer
	WHERE ID = @idReferenceAnswer
	
	SET NOCOUNT OFF
	RETURN
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE ReferenceAnswerUpdate
	(
	@idReferenceAnswer int,	
	@testQuestionID [int],
	@answerText [varchar](MAX),
	@answerScore [float]
	)
AS
	SET NOCOUNT ON

	UPDATE ReferenceAnswer
	SET [TestQuestionID] = @testQuestionID, [AnswerText] = @answerText, [AnswerScore] = @answerScore
	WHERE ID = @idReferenceAnswer
	
	SET NOCOUNT OFF
	RETURN
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE ReferenceAnswerInsert
	(
	@testQuestionID [int],
	@answerText [varchar](MAX),
	@answerScore [float],
	@newId int OUTPUT
	)
AS
	SET NOCOUNT ON

	SET @newId = 0
	
	INSERT INTO ReferenceAnswer ([TestQuestionID], [AnswerText], [AnswerScore])
	VALUES (@testQuestionID, @answerText, @answerScore)
	
	SELECT @newID = MAX(ID) FROM ReferenceAnswer
	
	SET NOCOUNT OFF
	RETURN
GO





SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE StudentTestAll
AS
	SET NOCOUNT ON

	SELECT * FROM StudentTest
	
	SET NOCOUNT OFF
	RETURN
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE StudentTestRead
	(
	@idStudentTest int
	)
AS
	SET NOCOUNT ON

	SELECT * FROM StudentTest
	WHERE ID = @idStudentTest
	
	SET NOCOUNT OFF
	RETURN
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE StudentTestUpdate
	(
	@idStudentTest int,	
	@studentID [int],
	@scheduledTestID [int],
	@initialToken [varchar](MAX),
	@testDate [datetime],
	@finalScore [float],
	@finished [bit],
	@reviewed [bit]
	)
AS
	SET NOCOUNT ON

	UPDATE StudentTest
	SET [StudentID] = @studentID, [ScheduledTestID] = @scheduledTestID, [InitialToken] = @initialToken, [TestDate] = @testDate, [FinalScore] = @finalScore, [Finished] = @finished, [Reviewed] = @reviewed
	WHERE ID = @idStudentTest
	
	SET NOCOUNT OFF
	RETURN
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE StudentTestInsert
	(
	@studentID [int],
	@scheduledTestID [int],
	@initialToken [varchar](MAX),
	@testDate [datetime],
	@finalScore [float],
	@finished [bit],
	@reviewed [bit],
	@newId int OUTPUT
	)
AS
	SET NOCOUNT ON

	SET @newId = 0
	
	INSERT INTO StudentTest ([StudentID], [ScheduledTestID], [InitialToken], [TestDate], [FinalScore], [Finished], [Reviewed])
	VALUES (@studentID, @scheduledTestID, @initialToken, @testDate, @finalScore, @finished, @reviewed)
	
	SELECT @newID = MAX(ID) FROM StudentTest
	
	SET NOCOUNT OFF
	RETURN
GO






SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE StudentTestAnswerAll
AS
	SET NOCOUNT ON

	SELECT * FROM StudentTestAnswer
	
	SET NOCOUNT OFF
	RETURN
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE StudentTestAnswerRead
	(
	@idStudentTestAnswer int
	)
AS
	SET NOCOUNT ON

	SELECT * FROM StudentTestAnswer
	WHERE ID = @idStudentTestAnswer
	
	SET NOCOUNT OFF
	RETURN
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE StudentTestAnswerUpdate
	(
	@idStudentTestAnswer int,	
	@testQuestionID [int],
	@testAnswerNumber [int],
	@studentTestID [int],
	@answerDate [datetime],
	@answerText [varchar](MAX),
	@answerAutoScore [float],
	@answerRevisedScore [float],
	@reviewText [varchar](MAX),
	@answerSimilarityScore [float],
	@wasReviewed [bit],
	@robotSimilarityScore [float]
	)
AS
	SET NOCOUNT ON

	UPDATE StudentTestAnswer
	SET [TestQuestionID] = @testQuestionID, [TestAnswerNumber] = @testAnswerNumber, [StudentTestID] = @studentTestID, [AnswerDate] = @answerDate, [AnswerText] = @answerText, [AnswerAutoScore] = @answerAutoScore, [AnswerRevisedScore] = @answerRevisedScore, [ReviewText] = @reviewText, [AnswerSimilarityScore] = @answerSimilarityScore, [WasReviewed] = @wasReviewed, [RobotSimilarityScore] = @robotSimilarityScore
	WHERE ID = @idStudentTestAnswer
	
	SET NOCOUNT OFF
	RETURN
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE StudentTestAnswerInsert
	(
	@testQuestionID [int],
	@testAnswerNumber [int],
	@studentTestID [int],
	@answerDate [datetime],
	@answerText [varchar](MAX),
	@answerAutoScore [float],
	@answerRevisedScore [float],
	@reviewText [varchar](MAX),
	@answerSimilarityScore [float],
	@wasReviewed [bit],
	@robotSimilarityScore [float],
	@newId int OUTPUT
	)
AS
	SET NOCOUNT ON

	SET @newId = 0
	
	INSERT INTO StudentTestAnswer ([TestQuestionID], [TestAnswerNumber], [StudentTestID], [AnswerDate], [AnswerText], [AnswerAutoScore], [AnswerRevisedScore], [ReviewText], [AnswerSimilarityScore], [WasReviewed], [RobotSimilarityScore])
	VALUES (@testQuestionID, @testAnswerNumber, @studentTestID, @answerDate, @answerText, @answerAutoScore, @answerRevisedScore, @reviewText, @answerSimilarityScore, @wasReviewed, @robotSimilarityScore)
	
	SELECT @newID = MAX(ID) FROM StudentTestAnswer
	
	SET NOCOUNT OFF
	RETURN
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE SimilarityScoreAll
AS
	SET NOCOUNT ON

	SELECT * FROM SimilarityScore
	
	SET NOCOUNT OFF
	RETURN
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE SimilarityScoreRead
	(
	@idSimilarityScore int
	)
AS
	SET NOCOUNT ON

	SELECT * FROM SimilarityScore
	WHERE ID = @idSimilarityScore
	
	SET NOCOUNT OFF
	RETURN
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE SimilarityScoreUpdate
	(
	@idSimilarityScore int,	
	@testQuestionID [int],
	@studentTestAnswerID [int],
	@studentTestAnswerComparedID [int],
	@score [float],
	@timestamp [datetime]
	)
AS
	SET NOCOUNT ON

	UPDATE SimilarityScore
	SET [TestQuestionID] = @testQuestionID, [StudentTestAnswerID] = @studentTestAnswerID, [StudentTestAnswerComparedID] = @studentTestAnswerComparedID, [Score] = @score, [Timestamo] = @timestamo
	WHERE ID = @idSimilarityScore
	
	SET NOCOUNT OFF
	RETURN
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE SimilarityScoreInsert
	(
	@testQuestionID [int],
	@studentTestAnswerID [int],
	@studentTestAnswerComparedID [int],
	@score [float],
	@timestamp [datetime],
	@newId int OUTPUT
	)
AS
	SET NOCOUNT ON

	SET @newId = 0
	
	INSERT INTO SimilarityScore ([TestQuestionID], [StudentTestAnswerID], [StudentTestAnswerComparedID], [Score], [Timestamp])
	VALUES (@testQuestionID, @studentTestAnswerID, @studentTestAnswerComparedID, @score, @timestamp)
	
	SELECT @newID = MAX(ID) FROM SimilarityScore
	
	SET NOCOUNT OFF
	RETURN
GO




SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE AppUserAll
AS
	SET NOCOUNT ON

	SELECT * FROM AppUser
	
	SET NOCOUNT OFF
	RETURN
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE AppUserRead
	(
	@idAppUser int
	)
AS
	SET NOCOUNT ON

	SELECT * FROM AppUser
	WHERE ID = @idAppUser
	
	SET NOCOUNT OFF
	RETURN
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE AppUserUpdate
	(
	@idAppUser int,	
	@organizationID [int],
	@courseID [int],
	@fullname [varchar](MAX),
	@email [varchar](MAX),
	@password [varchar](MAX),
	@passwordNeedsChanging [bit],
	@isAdmin [bit],
	@isActive [bit],
	@creationDate [datetime],
	@confirmationToken [varchar](MAX),
	@loginToken [varchar](MAX),
	@isConfirmed [bit],
	@passwordFailures [int]
	)
AS
	SET NOCOUNT ON

	UPDATE AppUser
	SET [OrganizationID] = @organizationID, [CourseID] = @courseID, [Fullname] = @fullname, [Email] = @email, [Password] = @password, [PasswordNeedsChanging] = @passwordNeedsChanging, [IsAdmin] = @isAdmin, [IsActive] = @isActive, [CreationDate] = @creationDate, [ConfirmationToken] = @confirmationToken, [LoginToken] = @loginToken, [IsConfirmed] = @isConfirmed, [PasswordFailures] = @passwordFailures
	WHERE ID = @idAppUser
	
	SET NOCOUNT OFF
	RETURN
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE AppUserInsert
	(
	@organizationID [int],
	@courseID [int],
	@fullname [varchar](MAX),
	@email [varchar](MAX),
	@password [varchar](MAX),
	@passwordNeedsChanging [bit],
	@isAdmin [bit],
	@isActive [bit],
	@creationDate [datetime],
	@confirmationToken [varchar](MAX),
	@loginToken [varchar](MAX),
	@isConfirmed [bit],
	@passwordFailures [int],
	@newId int OUTPUT
	)
AS
	SET NOCOUNT ON

	SET @newId = 0
	
	INSERT INTO AppUser ([OrganizationID], [CourseID], [Fullname], [Email], [Password], [PasswordNeedsChanging], [IsAdmin], [IsActive], [CreationDate], [ConfirmationToken], [LoginToken], [IsConfirmed], [PasswordFailures])
	VALUES (@organizationID, @courseID, @fullname, @email, @password, @passwordNeedsChanging, @isAdmin, @isActive, @creationDate, @confirmationToken, @loginToken, @isConfirmed, @passwordFailures)
	
	SELECT @newID = MAX(ID) FROM AppUser
	
	SET NOCOUNT OFF
	RETURN
GO


