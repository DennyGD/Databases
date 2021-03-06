USE [master]
GO
/****** Object:  Database [PeopleDB]    Script Date: 7.10.2015 г. 00:07:57 ч. ******/
CREATE DATABASE [PeopleDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PeopleDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\PeopleDB.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'PeopleDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\PeopleDB_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [PeopleDB] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PeopleDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PeopleDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PeopleDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PeopleDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PeopleDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PeopleDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [PeopleDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [PeopleDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PeopleDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PeopleDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PeopleDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PeopleDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PeopleDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PeopleDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PeopleDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PeopleDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [PeopleDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PeopleDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PeopleDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PeopleDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PeopleDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PeopleDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PeopleDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PeopleDB] SET RECOVERY FULL 
GO
ALTER DATABASE [PeopleDB] SET  MULTI_USER 
GO
ALTER DATABASE [PeopleDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PeopleDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PeopleDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PeopleDB] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [PeopleDB] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'PeopleDB', N'ON'
GO
USE [PeopleDB]
GO
/****** Object:  Table [dbo].[Addresses]    Script Date: 7.10.2015 г. 00:07:57 ч. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Addresses](
	[AddressId] [int] IDENTITY(1,1) NOT NULL,
	[AddressText] [nvarchar](200) NOT NULL,
	[CityId] [int] NOT NULL,
 CONSTRAINT [PK_Addresses] PRIMARY KEY CLUSTERED 
(
	[AddressId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Cities]    Script Date: 7.10.2015 г. 00:07:57 ч. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cities](
	[CityId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](70) NOT NULL,
	[CountryId] [int] NOT NULL,
 CONSTRAINT [PK_Cities] PRIMARY KEY CLUSTERED 
(
	[CityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Continents]    Script Date: 7.10.2015 г. 00:07:57 ч. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Continents](
	[ContinentId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](15) NOT NULL,
 CONSTRAINT [PK_Continents] PRIMARY KEY CLUSTERED 
(
	[ContinentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Countries]    Script Date: 7.10.2015 г. 00:07:57 ч. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Countries](
	[CountryId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](90) NOT NULL,
	[ContinentId] [int] NOT NULL,
 CONSTRAINT [PK_Countries] PRIMARY KEY CLUSTERED 
(
	[CountryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[People]    Script Date: 7.10.2015 г. 00:07:57 ч. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[People](
	[PersonId] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[AddressId] [int] NOT NULL,
 CONSTRAINT [PK_People] PRIMARY KEY CLUSTERED 
(
	[PersonId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Addresses] ON 

INSERT [dbo].[Addresses] ([AddressId], [AddressText], [CityId]) VALUES (1, N'46 Some str.', 1)
INSERT [dbo].[Addresses] ([AddressId], [AddressText], [CityId]) VALUES (3, N'54 Another str.', 3)
SET IDENTITY_INSERT [dbo].[Addresses] OFF
SET IDENTITY_INSERT [dbo].[Cities] ON 

INSERT [dbo].[Cities] ([CityId], [Name], [CountryId]) VALUES (1, N'Melbourne', 1)
INSERT [dbo].[Cities] ([CityId], [Name], [CountryId]) VALUES (3, N'Barcelona', 3)
SET IDENTITY_INSERT [dbo].[Cities] OFF
SET IDENTITY_INSERT [dbo].[Continents] ON 

INSERT [dbo].[Continents] ([ContinentId], [Name]) VALUES (1, N'Australia')
INSERT [dbo].[Continents] ([ContinentId], [Name]) VALUES (2, N'Europe')
SET IDENTITY_INSERT [dbo].[Continents] OFF
SET IDENTITY_INSERT [dbo].[Countries] ON 

INSERT [dbo].[Countries] ([CountryId], [Name], [ContinentId]) VALUES (1, N'Australia', 1)
INSERT [dbo].[Countries] ([CountryId], [Name], [ContinentId]) VALUES (3, N'Spain', 2)
SET IDENTITY_INSERT [dbo].[Countries] OFF
SET IDENTITY_INSERT [dbo].[People] ON 

INSERT [dbo].[People] ([PersonId], [FirstName], [LastName], [AddressId]) VALUES (1, N'Jane', N'Doe', 1)
INSERT [dbo].[People] ([PersonId], [FirstName], [LastName], [AddressId]) VALUES (2, N'John', N'Doe', 3)
SET IDENTITY_INSERT [dbo].[People] OFF
SET ANSI_PADDING ON

GO
/****** Object:  Index [UK_Addresses_AddressText]    Script Date: 7.10.2015 г. 00:07:57 ч. ******/
CREATE UNIQUE NONCLUSTERED INDEX [UK_Addresses_AddressText] ON [dbo].[Addresses]
(
	[AddressText] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UK_Cities_Name]    Script Date: 7.10.2015 г. 00:07:57 ч. ******/
CREATE NONCLUSTERED INDEX [UK_Cities_Name] ON [dbo].[Cities]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UK_Continents_Name]    Script Date: 7.10.2015 г. 00:07:57 ч. ******/
CREATE UNIQUE NONCLUSTERED INDEX [UK_Continents_Name] ON [dbo].[Continents]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UK_Countries_Name]    Script Date: 7.10.2015 г. 00:07:57 ч. ******/
CREATE UNIQUE NONCLUSTERED INDEX [UK_Countries_Name] ON [dbo].[Countries]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Addresses]  WITH CHECK ADD  CONSTRAINT [FK_Addresses_Cities] FOREIGN KEY([CityId])
REFERENCES [dbo].[Cities] ([CityId])
GO
ALTER TABLE [dbo].[Addresses] CHECK CONSTRAINT [FK_Addresses_Cities]
GO
ALTER TABLE [dbo].[Cities]  WITH CHECK ADD  CONSTRAINT [FK_Cities_Countries] FOREIGN KEY([CountryId])
REFERENCES [dbo].[Countries] ([CountryId])
GO
ALTER TABLE [dbo].[Cities] CHECK CONSTRAINT [FK_Cities_Countries]
GO
ALTER TABLE [dbo].[Countries]  WITH CHECK ADD  CONSTRAINT [FK_Countries_Continents] FOREIGN KEY([ContinentId])
REFERENCES [dbo].[Continents] ([ContinentId])
GO
ALTER TABLE [dbo].[Countries] CHECK CONSTRAINT [FK_Countries_Continents]
GO
ALTER TABLE [dbo].[People]  WITH CHECK ADD  CONSTRAINT [FK_People_Addresses] FOREIGN KEY([AddressId])
REFERENCES [dbo].[Addresses] ([AddressId])
GO
ALTER TABLE [dbo].[People] CHECK CONSTRAINT [FK_People_Addresses]
GO
USE [master]
GO
ALTER DATABASE [PeopleDB] SET  READ_WRITE 
GO
