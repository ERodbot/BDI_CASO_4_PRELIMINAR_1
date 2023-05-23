USE [Esencial Verde Linked Copy]
GO
/****** Object:  Table [dbo].[event_logs]    Script Date: 5/22/2023 2:40:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[event_logs](
	[event_log_id] [bigint] IDENTITY(1,1) NOT NULL,
	[description] [varchar](20) NOT NULL,
	[reference_id1] [bigint] NOT NULL,
	[reference_id2] [bigint] NOT NULL,
	[value1] [varchar](60) NOT NULL,
	[value2] [varchar](60) NOT NULL,
	[event_type_id] [int] NOT NULL,
	[object_type_id] [int] NOT NULL,
	[level_id] [int] NOT NULL,
	[source_id] [int] NOT NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NOT NULL,
	[computer] [varchar](50) NOT NULL,
	[username] [varchar](50) NOT NULL,
	[checksum] [varbinary](150) NOT NULL,
 CONSTRAINT [PK_event_logs] PRIMARY KEY CLUSTERED 
(
	[event_log_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[event_types]    Script Date: 5/22/2023 2:40:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[event_types](
	[event_type_id] [int] IDENTITY(1,1) NOT NULL,
	[event_type_name] [varchar](20) NOT NULL,
 CONSTRAINT [PK_event_types] PRIMARY KEY CLUSTERED 
(
	[event_type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[levels]    Script Date: 5/22/2023 2:40:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[levels](
	[level_id] [int] IDENTITY(1,1) NOT NULL,
	[level_name] [varchar](20) NOT NULL,
 CONSTRAINT [PK_levels] PRIMARY KEY CLUSTERED 
(
	[level_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[object_types]    Script Date: 5/22/2023 2:40:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[object_types](
	[object_type_id] [int] IDENTITY(1,1) NOT NULL,
	[object_type_name] [varchar](20) NOT NULL,
 CONSTRAINT [PK_object_types] PRIMARY KEY CLUSTERED 
(
	[object_type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sources]    Script Date: 5/22/2023 2:40:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sources](
	[source_id] [int] IDENTITY(1,1) NOT NULL,
	[source_name] [varchar](20) NOT NULL,
 CONSTRAINT [PK_sources] PRIMARY KEY CLUSTERED 
(
	[source_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[event_logs]  WITH CHECK ADD  CONSTRAINT [FK_event_logs_event_types] FOREIGN KEY([event_type_id])
REFERENCES [dbo].[event_types] ([event_type_id])
GO
ALTER TABLE [dbo].[event_logs] CHECK CONSTRAINT [FK_event_logs_event_types]
GO
ALTER TABLE [dbo].[event_logs]  WITH CHECK ADD  CONSTRAINT [FK_event_logs_levels] FOREIGN KEY([level_id])
REFERENCES [dbo].[levels] ([level_id])
GO
ALTER TABLE [dbo].[event_logs] CHECK CONSTRAINT [FK_event_logs_levels]
GO
ALTER TABLE [dbo].[event_logs]  WITH CHECK ADD  CONSTRAINT [FK_event_logs_object_types] FOREIGN KEY([object_type_id])
REFERENCES [dbo].[object_types] ([object_type_id])
GO
ALTER TABLE [dbo].[event_logs] CHECK CONSTRAINT [FK_event_logs_object_types]
GO
ALTER TABLE [dbo].[event_logs]  WITH CHECK ADD  CONSTRAINT [FK_event_logs_sources] FOREIGN KEY([source_id])
REFERENCES [dbo].[sources] ([source_id])
GO
ALTER TABLE [dbo].[event_logs] CHECK CONSTRAINT [FK_event_logs_sources]
GO



