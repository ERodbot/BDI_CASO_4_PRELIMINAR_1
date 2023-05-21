USE [Esencial V];

GO
CREATE NONCLUSTERED INDEX noncluster_Index_Containers
ON [dbo].[producers] (producer_id)
INCLUDE ([name],[corporation_id])
GO
