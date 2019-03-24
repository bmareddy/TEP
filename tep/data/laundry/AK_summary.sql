USE TEP
Go

/***
raw data is import into dbo.AK_turnout_summary_raw table
***/

insert into dbo.table_lookup_races (state, race)
select distinct 'AK', race from dbo.AK_turnout_summary_raw
order by 1
Go

--Presidential (type = 1)
update r
set race_type_id = 1
from dbo.table_lookup_races r
where state = 'AK'
and race_type_id is null
and race in ('U.S. PRESIDENT/VICE PRESIDENT', 'US PRESIDENT', 'US PRESIDENT / VICE PRESIDENT')
Go

--House (type = 2)
update r
set race_type_id = 2
from dbo.table_lookup_races r
where state = 'AK'
and race_type_id is null

--Senate (type = 3)
update r
set race_type_id = 3
from dbo.table_lookup_races r
where state = 'AK'
and race_type_id is null
and race in ('UNITED STATES SENATOR', 'US SENATE', 'US SENATOR')

--Gubernatorial (type = 4)
update r
set race_type_id = 4
from dbo.table_lookup_races r
where state = 'AK'
and race_type_id is null
and race in ('GOVERNOR/LT GOVERNOR', 'GOVERNOR/LT. GOVERNOR')

--State Assembly (type = 5)
update r
set race_type_id = 5
from dbo.table_lookup_races r
where state = 'AK'
and race_type_id is null
and race like 'HOUSE DISTRICT%' or race like 'SENATE DISTRICT%'
Go

--Judiciary (type = 6)
update r
set race_type_id = 6
from dbo.table_lookup_races r
where state = 'AK'
and race_type_id is null
and race like '%JD[0-9]%'
Go

update r
set race_type_id = 6
from dbo.table_lookup_races r
where state = 'AK'
and race_type_id is null
and race like 'SUPREME%' or race like 'SUPERIOR%' or race like 'APPEALS%'
Go

update r
set race_type_id = 6
from dbo.table_lookup_races r
where state = 'AK'
and race_type_id is null
and race like 'COURT%'
Go

--Other Statewide (type = 7)
update r
set race_type_id = 7
from dbo.table_lookup_races r
where state = 'AK'
and race_type_id is null
Go

/***
AK summary by year and race
***/

select cast('AK' as varchar(2)) as state, raw.election_year, r.race_id, raw.registered_voters, raw.votes, raw.num_precincts_total, raw.num_precincts_reporting
into dbo.table_turnout_summary_AK
from dbo.AK_turnout_summary_raw raw
join dbo.table_lookup_races r
	on raw.race = r.race
	and r.state = 'AK'
Go