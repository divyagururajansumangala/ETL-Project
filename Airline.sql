
--Create table for ETL cleaned data
CREATE TABLE air_crash (
	AirlineID integer
	,Operator varchar
	,ICAO varchar
	,Country varchar
	,Active varchar(10)
	,Date timestamp without time zone
    ,Location varchar
	,Type varchar
	,Aboard decimal
	,Fatalities decimal
	--,Summary varchar
);


--Viewing table
SELECT 
	*
FROM
	air_crash

--Worst country by frequency of crashes by country (have an optional view)
CREATE VIEW country_safety_worst AS
SELECT
	COUNT(country) AS "No. Crashes"
	--,operator
	,country
	,SUM(fatalities) AS "fatalities"
	,SUM(aboard) AS  "aboard"
	,ROUND((SUM(fatalities)/SUM(aboard)*100),1) AS "fatality rate (%)"
FROM 
	air_crash
GROUP BY
	country
ORDER BY
	COUNT(country) DESC
LIMIT 
	50
	
--Best country by frequency of crashes	
--

CREATE VIEW country_safety_best AS
SELECT
	COUNT(country) AS "No. Crashes"
	--,operator
	,country
	,SUM(fatalities) AS "fatalities"
	,SUM(aboard) AS  "aboard"
	,ROUND((SUM(fatalities)/SUM(aboard)*100),1) AS "fatality rate (%)"
FROM 
	air_crash
WHERE
	country IS NOT NULL
GROUP BY
	country
ORDER BY
	COUNT(country)
LIMIT 
	50

--Worst airline by number of crashes
CREATE VIEW airline_safety_worst AS
SELECT
	COUNT(Operator) AS "No. Crashes"
	,operator
	,country
	,SUM(fatalities) AS "fatalities"
	,SUM(aboard) AS  "aboard"
	,ROUND((SUM(fatalities)/SUM(aboard)*100),1) AS "fatality rate (%)"
FROM 
	air_crash
GROUP BY
	Operator, country
ORDER BY
	COUNT(Operator) DESC
LIMIT 
	50

--Best airlines by number of crashes
CREATE VIEW airline_safety_best AS
SELECT
	COUNT(Operator) AS "No. Crashes"
	,operator
	,country
	,SUM(fatalities) AS "fatalities"
	,SUM(aboard) AS  "aboard"
	,ROUND((SUM(fatalities)/SUM(aboard)*100),1) AS "fatality rate (%)"
FROM 
	air_crash
GROUP BY
	Operator, "fatalities", country
ORDER BY
	COUNT(Operator)
LIMIT 
	50