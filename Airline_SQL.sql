DROP TABLE IF EXISTS airline;

CREATE TABLE airline (
	"Airline ID" integer
	,"Operator" varchar
	,"IATA" varchar
	,"ICAO" varchar
	,"Country" varchar	
	,"Active" varchar(10)
	,"Date" varchar
    ,"Location" varchar
	,"Type" varchar
	,"Aboard" decimal
	,"Fatalities" decimal	
	--,Summary long varchar
);


SELECT 
	*
FROM
	airline;

--Worst country by frequency of crashes by country
DROP VIEW IF EXISTS country_safety_worst;

CREATE VIEW country_safety_worst AS
SELECT
	COUNT("Country") AS "No. Crashes"
	--,operator
	,"Country"
	,SUM("Fatalities") AS "Fatalities"
	,SUM("Aboard") AS  "Aboard"
	,ROUND((SUM("Fatalities")/SUM("Aboard")*100),1) AS "fatality rate (%)"
FROM 
	airline
WHERE 
	"Date" >= '1970-01-01'
GROUP BY
	"Country"
ORDER BY
	COUNT("Country") DESC
LIMIT 
	50;

SELECT * FROM country_safety_worst;

--Best Country by frequency of crashes	
DROP VIEW IF EXISTS country_safety_best;

CREATE VIEW country_safety_best AS
SELECT
	COUNT("Country") AS "No. Crashes"
	,"Country"
	,SUM("Fatalities") AS "Fatalities"
	,SUM("Aboard") AS  "Aboard"
	,ROUND((SUM("Fatalities")/SUM("Aboard")*100),1) AS "Fatality Rate (%)"
FROM 
	airline
WHERE
	"Country" IS NOT NULL
AND
	"Date" >= '1970-01-01'
GROUP BY
	"Country"
ORDER BY
	COUNT("Country")
LIMIT 
	50;

SELECT * FROM country_safety_best;

--Worst airline by number of crashes
DROP VIEW IF EXISTS airline_safety_worst;

CREATE VIEW airline_safety_worst AS
SELECT
	COUNT("Operator") AS "No. Crashes"
	,"Operator"
	,"Country"
	,SUM("Fatalities") AS "Fatalities"
	,SUM("Aboard") AS  "Aboard"
	,ROUND((SUM("Fatalities")/SUM("Aboard")*100),1) AS "Fatality Rate (%)"
FROM 
	airline
WHERE 
	"Date" >= '1970-01-01'
GROUP BY
	"Operator", "Country"
ORDER BY
	COUNT("Operator") DESC
LIMIT 
	50;
	
SELECT * FROM airline_safety_worst;

--Best airlines by number of crashes
DROP VIEW IF EXISTS airline_safety_best;

CREATE VIEW airline_safety_best AS
SELECT
	COUNT("Operator") AS "No. Crashes"
	,"Operator"
	,"Country"
	,SUM("Fatalities") AS "Fatalities"
	,SUM("Aboard") AS  "Aboard"
	,ROUND((SUM("Fatalities")/SUM("Aboard")*100),1) AS "Fatality Rate (%)"
FROM 
	airline
GROUP BY
	"Operator", "Fatalities", "Country"
ORDER BY
	COUNT("Operator")
LIMIT 
	50;

SELECT * FROM airline_safety_best;