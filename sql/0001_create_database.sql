USE master;
GO
CREATE DATABASE TEP
ON
( NAME = Sales_dat,
    FILENAME = 'C:\myapps\sqlserver\TEP\TEP.mdf',
    SIZE = 10MB,
    MAXSIZE = 500MB,
    FILEGROWTH = 5 )
LOG ON
( NAME = Sales_log,
    FILENAME = 'C:\myapps\sqlserver\TEP\TEP.ldf',
    SIZE = 5MB,
    MAXSIZE = 100MB,
    FILEGROWTH = 5MB ) ;
GO