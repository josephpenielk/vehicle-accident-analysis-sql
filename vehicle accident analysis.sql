SELECT *
FROM accident

SELECT * 
FROM vehicle

--How many accidents have occured in urban areas vs rural areas?
SELECT 
	Area,
	COUNT(Area) AS NumberOfAccidents
FROM accident
GROUP BY Area
ORDER BY 2 DESC

--Which day of the week has the highest amount of accidents?
SELECT
	[Day],
	COUNT(*) AS NumberOfAccidents
FROM accident
GROUP BY [Day]
ORDER BY 2 DESC

--What is the average age of vehicles based on their type?
SELECT 
	VehicleType,
	AVG(AgeVehicle) AS AverageAge
FROM vehicle
GROUP BY VehicleType
ORDER BY 2 DESC


-- Can we identify any trends based on the age of the vehicle?
WITH CTE AS(
	SELECT
		AgeVehicle,
		CASE
			WHEN AgeVehicle BETWEEN 0 AND 9 THEN '0-9 Years'
			WHEN AgeVehicle BETWEEN 10 AND 19 THEN '10-29 Years'
			WHEN AgeVehicle BETWEEN 20 AND 29 THEN '20-29 Years'
			WHEN AgeVehicle BETWEEN 30 AND 39 THEN '30-39 Years'
			WHEN AgeVehicle BETWEEN 40 AND 49 THEN '40-49 Years'
			WHEN AgeVehicle > 49 THEN '50+ Years'
		END AS AgeGroup
	FROM vehicle
WHERE AgeVehicle IS NOT NULL
)

SELECT 
	AgeGroup,
	COUNT(AgeVehicle) AS NumberOfAccidents
FROM CTE
GROUP BY AgeGroup
ORDER BY AgeGroup

--Are there any specific weather conditions that contribute to severe accidents?
SELECT
	WeatherConditions,
	COUNT(*) AS Cnt
FROM accident
WHERE Severity LIKE 'Serious' OR Severity like 'Fatal'
GROUP BY WeatherConditions
ORDER BY 2 DESC

--Do accidents often involve impacts on the left-hand side of vehicles?
SELECT
	LeftHand,
	COUNT(*)
FROM vehicle
WHERE LeftHand IS NOT NULL
GROUP BY LeftHand
ORDER BY 2 DESC

--Are there any relationship between journey purpose and the severity of the accident
SELECT
	a.Severity,
	v.JourneyPurpose,
	COUNT(*) AS NumberOfAccidents
	
FROM vehicle v 
JOIN accident a ON v.AccidentIndex = a.AccidentIndex
WHERE NOT v.JourneyPurpose like 'Not Known'
GROUP BY v.JourneyPurpose,a.Severity
ORDER BY a.Severity,  3 DESC

--Calculate the average age of vehicles involved in accidents, considering day light and point of impact
SELECT
	a.LightConditions,
	v.PointImpact,
	AVG(v.AgeVehicle) AS AvgYear
FROM vehicle v 
JOIN accident a on v.AccidentIndex = a.AccidentIndex
GROUP BY a.LightConditions, v.PointImpact
ORDER BY a.LightConditions, 3 DESC

