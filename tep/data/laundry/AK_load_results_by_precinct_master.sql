-- For AK, let's assume that State House Districts are a proxy for counties
-- AK does not have counties. They have boros. There is no mapping between boros and precincts
-- although, it could be derived using the text in the precinct column
-- recognizing that this will make it hard to integrate with other public data sets
Go

if object_id('TEP.dbo.table_AK_results_by_precinct_master') is null
begin
	create table TEP.dbo.table_AK_results_by_precinct_master (
	election_year smallint
	, precinct varchar(255)
	, race varchar(255)
	, data_element varchar(255)
	, party_affiliation varchar(255)
	, value int
	)
end
Go

declare @election_year smallint = 2018

insert into TEP.dbo.table_AK_results_by_precinct_master (election_year, precinct, race, data_element, party_affiliation, value)
select @election_year, precinct, race, data_element, party_affiliation, value
from TEP_DEV.dbo.AK_resultsbyprecinct_raw
where trim(data_element) not in ('Number of Precincts for Race', 'Number of Precincts Reporting')
and trim(race) not in ('Race Statistics')
Go

