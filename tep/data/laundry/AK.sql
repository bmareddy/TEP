/*** AK 2018 Data ***/
select cast('AK' as varchar(2)) as state
, cast(2018 as int) as election_year
, cast(race as varchar(255)) race
, max(case when data_element = 'Registered Voters' then value else null end) registered_voters
, max(case when data_element = 'Times Counted' then value else null end) votes
, max(case when data_element = 'Number of Precincts for Race' then value else null end) num_precincts_total
, max(case when data_element = 'Number of Precincts Reporting' then value else null end) num_precincts_reporting
, cast(max(case when race in ('US REPRESENTATIVE', 'US SENATOR', 'US PRESIDENT', 'GOVERNOR/LT. GOVERNOR') or race like 'BALLOT%' then 1 else 0 end) as int) as state_wide_flag
, cast(max(case when race in ('US REPRESENTATIVE', 'US SENATOR', 'US PRESIDENT') then 1 else 0 end) as int) as federal_race_flag
into dbo.table_election_summary
from dbo.resultsAK2018
where race <> 'Race Statistics'
group by cast(race as varchar(255))
Go

/*** AK 2016 Data ***/
insert into dbo.table_election_summary (state, election_year, race
, registered_voters, votes
, num_precincts_total, num_precincts_reporting
, state_wide_flag, federal_race_flag)
select cast('AK' as varchar(2)) as state
, cast(2016 as int) as election_year
, cast(race as varchar(255)) race
, max(case when data_element = 'Registered Voters' then value else null end) registered_voters
, max(case when data_element = 'Times Counted' then value else null end) votes
, max(case when data_element = 'Number of Precincts for Race' then value else null end) num_precincts_total
, max(case when data_element = 'Number of Precincts Reporting' then value else null end) num_precincts_reporting
, cast(max(case when race in ('US REPRESENTATIVE', 'US SENATOR', 'US PRESIDENT') 
					or race like 'BALLOT%'
					or race like '%GOVERNOR%'
					or race like 'UNITED STATES%' then 1 else 0 end) as int) as state_wide_flag
, cast(max(case when race in ('US REPRESENTATIVE', 'US SENATOR', 'US PRESIDENT') then 1 else 0 end) as int) as federal_race_flag
from dbo.resultsAK2016
where race <> 'Race Statistics'
group by cast(race as varchar(255))
Go

/*** AK 2014 Data ***/
insert into dbo.table_election_summary (state, election_year, race
, registered_voters, votes
, num_precincts_total, num_precincts_reporting
, state_wide_flag, federal_race_flag)
select cast('AK' as varchar(2)) as state
, cast(2014 as int) as election_year
, cast(race as varchar(255)) race
, max(case when data_element = 'Registered Voters' then value else null end) registered_voters
, max(case when data_element = 'Times Counted' then value else null end) votes
, max(case when data_element = 'Number of Precincts for Race' then value else null end) num_precincts_total
, max(case when data_element = 'Number of Precincts Reporting' then value else null end) num_precincts_reporting
, cast(max(case when race in ('US REPRESENTATIVE', 'US SENATOR', 'US PRESIDENT') 
					or race like 'BALLOT%'
					or race like '%GOVERNOR%'
					or race like 'UNITED STATES%' then 1 else 0 end) as int) as state_wide_flag
, cast(max(case when race in ('US REPRESENTATIVE', 'US SENATOR', 'US PRESIDENT', 'UNITED STATES SENATOR') then 1 else 0 end) as int) as federal_race_flag
from dbo.resultsAK2014
where race <> 'Race Statistics'
group by cast(race as varchar(255))

/*** AK 2012 Data ***/
insert into dbo.table_election_summary (state, election_year, race
, registered_voters, votes
, num_precincts_total, num_precincts_reporting
, state_wide_flag, federal_race_flag)
select cast('AK' as varchar(2)) as state
, cast(2012 as int) as election_year
, cast(race as varchar(255)) race
, max(case when data_element = 'Registered Voters' then value else null end) registered_voters
, max(case when data_element = 'Times Counted' then value else null end) votes
, max(case when data_element = 'Number of Precincts for Race' then value else null end) num_precincts_total
, max(case when data_element = 'Number of Precincts Reporting' then value else null end) num_precincts_reporting
, cast(max(case when race in ('US REPRESENTATIVE', 'US SENATOR', 'US PRESIDENT') 
					or race like 'BALLOT%'
					or race like '%GOVERNOR%'
					or race like 'UNITED STATES%' then 1 else 0 end) as int) as state_wide_flag
, cast(max(case when race in ('US REPRESENTATIVE', 'US SENATOR', 'US PRESIDENT', 'UNITED STATES SENATOR') then 1 else 0 end) as int) as federal_race_flag
from dbo.resultsAK2012
where race <> 'Race Statistics'
group by cast(race as varchar(255))
Go

/*** AK 2002 to 2010 Data ***/
insert into dbo.table_election_summary (state, election_year, race
, registered_voters, votes
, num_precincts_total, num_precincts_reporting
, state_wide_flag, federal_race_flag)
select cast(state as varchar(2)) as state
, cast(election_year as int) as election_year
, cast(trim(race) as varchar(255)) race
, max(case when data_element = 'Times Counted' then right(trim(value),len(trim(value))-charindex('/',trim(value))) else null end) registered_voters
, max(case when data_element = 'Times Counted' then left(trim(value),charindex('/',trim(value))-1) else null end) votes
, max(case when data_element = 'Number of Precincts' then value else null end) num_precincts_total
, max(case when data_element = 'Precincts Reporting' then value else null end) num_precincts_reporting
, cast(max(case when race in ('US REPRESENTATIVE', 'US SENATOR', 'US PRESIDENT', 'US SENATE') 
					or race like 'BALLOT%'
					or race like '%GOVERNOR%'
					or race like 'UNITED STATES%' then 1 else 0 end) as int) as state_wide_flag
, cast(max(case when race in ('US REPRESENTATIVE', 'US SENATOR', 'US PRESIDENT', 'UNITED STATES SENATOR', 'US SENATE') then 1 else 0 end) as int) as federal_race_flag
from dbo.resultsAK2000_10_2
where data_element <> ''
and cast(election_year as int) != 2000
group by cast(state as varchar(2)), cast(election_year as int), cast(trim(race) as varchar(255))
Go

/*** AK 2000 Data ***/
insert into dbo.table_election_summary (state, election_year, race
, registered_voters, votes
, num_precincts_total, num_precincts_reporting
, state_wide_flag, federal_race_flag)
select cast(state as varchar(2)) as state
, cast(election_year as int) as election_year
, cast(trim(race) as varchar(255)) race
, max(case when data_element = 'Ballots Cast/Reg. Voters' then right(trim(value),len(trim(value))-charindex('/',trim(value))) else null end) registered_voters
, max(case when data_element = 'Ballots Cast/Reg. Voters' then left(trim(value),charindex('/',trim(value))-1) else null end) votes
, max(case when data_element = 'Precincts Reporting' then right(trim(value),len(trim(value))-charindex('/',trim(value))) else null end) num_precincts_total
, max(case when data_element = 'Precincts Reporting' then left(trim(value),charindex('/',trim(value))-1) else null end) num_precincts_reporting
, cast(max(case when race in ('U.S. REPRESENTATIVE', 'U.S. PRESIDENT/VICE PRESIDENT') 
					or race like 'BALLOT%'
					or race like '%GOVERNOR%'
					or race like 'UNITED STATES%' then 1 else 0 end) as int) as state_wide_flag
, cast(max(case when race in ('U.S. REPRESENTATIVE', 'U.S. PRESIDENT/VICE PRESIDENT') then 1 else 0 end) as int) as federal_race_flag
from dbo.resultsAK2000_10_2
where data_element <> ''
and cast(election_year as int) = 2000
group by cast(state as varchar(2)), cast(election_year as int), cast(trim(race) as varchar(255))
Go

sp_rename 'dbo.table_election_summary', 'table_voter_turnout_summary'
Go

select * from dbo.table_voter_turnout_summary