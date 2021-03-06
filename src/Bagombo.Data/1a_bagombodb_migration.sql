

DECLARE @var0 sysname;
SELECT @var0 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'Topic') AND [c].[name] = N'Title');
IF @var0 IS NOT NULL EXEC(N'ALTER TABLE [Topic] DROP CONSTRAINT [' + @var0 + '];');
ALTER TABLE [Topic] ALTER COLUMN [Title] nvarchar(450);

GO

DECLARE @var1 sysname;
SELECT @var1 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'Category') AND [c].[name] = N'Name');
IF @var1 IS NOT NULL EXEC(N'ALTER TABLE [Category] DROP CONSTRAINT [' + @var1 + '];');
ALTER TABLE [Category] ALTER COLUMN [Name] nvarchar(450);

GO

CREATE UNIQUE INDEX [IX_Topic_Title] ON [Topic] ([Title]) WHERE [Title] IS NOT NULL;

GO

CREATE UNIQUE INDEX [IX_Category_Name] ON [Category] ([Name]) WHERE [Name] IS NOT NULL;

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20170528203126_1a', N'1.1.2');

GO


