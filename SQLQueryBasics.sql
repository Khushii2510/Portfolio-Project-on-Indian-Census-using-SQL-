SELECT count(District) as NoDistrict
FROM PortfolioProject..Data1

SELECT count(District) as NoDistrict
FROM PortfolioProject..Data2

--dataset for jharkhand and bihar

SELECT *
FROM PortfolioProject..Data1
WHERE State in ('Jharkhand','Bihar')

--population of India

select sum(population) as TotalPopulation
from PortfolioProject..Data2

--average growth 

Select State,AVG(Growth)*100
FROM PortfolioProject..Data1
GROUP BY State

--average sex ratio

Select State,ROUND(AVG(Sex_Ratio),0) AS AvgGrowth
FROM PortfolioProject..Data1
GROUP BY State
ORDER BY AvgGrowth DESC

--avg literacy rate

Select State,ROUND(AVG(literacy),0) AS AvgLiteracyRatio
FROM PortfolioProject..Data1
GROUP BY State
HAVING ROUND(AVG(Literacy),0)>90
ORDER BY AvgLiteracyRatio DESC

--top 3 state with highest growth ratio

Select top 3 State,AVG(Growth) as AvgGrowth
FROM PortfolioProject..Data1
GROUP BY State
ORDER BY AvgGrowth DESC

--top and bottom 3 states in literacy rate
DROP TABLE if exists #topstates;
CREATE TABLE #topstates
(States nvarchar(300),
 topstates float
 )
 INSERT INTO #topstates
 SELECT State, AVG(literacy) AS AvgLiteracy
 FROM PortfolioProject..Data1
 GROUP BY State 
 ORDER BY AvgLiteracy DESC

 SELECT top 3 *
 FROM #topstates
 ORDER BY #topstates.topstates desc

 DROP TABLE if exists #bottomstates;
CREATE TABLE #bottomstates
(States nvarchar(300),
 bottomstates float
 )
 INSERT INTO #bottomstates
 SELECT State, AVG(literacy) AS AvgLiteracy
 FROM PortfolioProject..Data1
 GROUP BY State 
 ORDER BY AvgLiteracy DESC

 SELECT * FROM(
 SELECT top 3 *
 FROM #bottomstates
 ORDER BY #bottomstates.bottomstates )a

 UNION
 SELECT * FROM(
 SELECT top 3 *
 FROM #topstates
 ORDER BY #topstates.topstates desc)b

 --states starting from letter a

 SELECT distinct State
 FROM PortfolioProject..Data1
 WHERE State like 'a%'


