USE TEP
Go

CREATE TABLE dbo.table_lookup_race_types (
race_type_id INT not null IDENTITY(1,1),
race_type VARCHAR(255)
CONSTRAINT PK_table_lookup_race_types PRIMARY KEY (race_type_id),
CONSTRAINT UQ_table_lookup_race_types UNIQUE (race_type)
)
Go

INSERT INTO dbo.table_lookup_race_types (race_type)
VALUES ('Presidential')
, ('House')
, ('Senate')
, ('Gubernatorial')
, ('State Assembly')
, ('Judiciary')
, ('Other Statewide')
, ('Other Local')
Go

CREATE TABLE dbo.table_lookup_races (
race_id INT not null IDENTITY(1,1),
state VARCHAR(2) not null,
race NVARCHAR(255) not null,
race_type_id INT,
lastModified DATETIME,
lastModifiedBy VARCHAR(255)
CONSTRAINT PK_table_lookup_races PRIMARY KEY (race_id),
CONSTRAINT UQ_table_lookup_races UNIQUE (state, race),
CONSTRAINT FK_table_lookup_races_race_type_id FOREIGN KEY (race_type_id)     
    REFERENCES dbo.table_lookup_race_types (race_type_id)     
    ON DELETE CASCADE    
    ON UPDATE CASCADE
)
Go
