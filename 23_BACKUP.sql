BACKUP DATABASE dbCompuCenter
TO DISK = 'C:\Backup\dbCompuCenter20240802.bak'
WITH NO_COMPRESSION, NAME='dbCompuCenter20240802.bak'

declare @fecha char(12)
declare @path varchar(100)
declare @name varchar(20)

--print convert(char(5),getdate(),108)
set @fecha = convert(char(8),getdate(),112) + replace(convert(char(5),getdate(),108),':','')
set @path = 'C:\Backup\dbCompuCenter'+@fecha+'.bak'
set @name = 'dbCompuCenter'+@fecha


BACKUP DATABASE dbCompuCenter
TO DISK = @path
WITH NO_COMPRESSION, NAME=@name