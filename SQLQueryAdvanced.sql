--joining both the table
--total males and female

SELECT d.state, SUM(d.males) AS TotalMale ,SUM(d.female) AS TotalFemale
FROM(
SELECT District , State,round(population/(sex_ratio+1),0)AS males,round((population*sex_ratio)/(sex_ratio+1),0)AS female
FROM(
SELECT a.district,a.state,a.Sex_Ratio,b.population 
FROM PortfolioProject..Data1 a
INNER JOIN PortfolioProject..Data2 b 
ON a.District=b.District) c) d 
GROUP BY d.state  

-- total literacy rate


select c.state,sum(literate_people) total_literate_pop,sum(illiterate_people) total_lliterate_pop
FROM
(select d.district,d.state,round(d.literacy_ratio*d.population,0) literate_people,
round((1-d.literacy_ratio)* d.population,0) illiterate_people
from
(select a.district,a.state,a.literacy/100 literacy_ratio,b.population
from PortfolioProject..data1 a 
inner join PortfolioProject..data2 b
on a.district=b.district) d) c
group by c.state

-- population in previous census


select sum(m.previous_census_population) previous_census_population,sum(m.current_census_population) current_census_population
from(
select e.state,sum(e.previous_census_population) previous_census_population,sum(e.current_census_population) current_census_population
from
(select d.district,d.state,round(d.population/(1+d.growth),0) previous_census_population,d.population current_census_population
from
(select a.district,a.state,a.growth growth,b.population 
from PortfolioProject..data1 a
inner join PortfolioProject..data2 b
on a.district=b.district) d) e
group by e.state)m


-- population vs area

select (g.total_area/g.previous_census_population)  as previous_census_population_vs_area, (g.total_area/g.current_census_population) as 
current_census_population_vs_area
from
(select q.*,r.total_area
from (
select '1' as keyy,n.*
from
(select sum(m.previous_census_population) previous_census_population,sum(m.current_census_population) current_census_population
from(
select e.state,sum(e.previous_census_population) previous_census_population,sum(e.current_census_population) current_census_population
from
(select d.district,d.state,round(d.population/(1+d.growth),0) previous_census_population,d.population current_census_population
from
(select a.district,a.state,a.growth growth,b.population from PortfolioProject..data1 a
inner join PortfolioProject..data2 b
on a.district=b.district) d) e
group by e.state)m) n) q
inner join (
select '1' as keyy,z.*
from (
select sum(area_km2) total_area from PortfolioProject..data2)z) r on q.keyy=r.keyy)g

--window 
  
output top 3 districts
from each state
with highest literacy rate
select a.* from
(select district,state,literacy,rank() over(partition by state order by literacy desc) rnk from PortfolioProject..data1) a
where a.rnk in (1,2,3)
order by state
