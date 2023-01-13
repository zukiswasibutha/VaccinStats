-- Getting all the Data from the Deaths Table

select *
from CoviData.dbo.CoviDeaths
Order By Location, CaseDate;



--Getting the Highest death cases and highest population from the Location that has district anywhere inbetween

select Location, max(Population) as HighestPopulation, max(DeathCases) as MaximunDeaths
from CoviData.dbo.CoviDeaths
where Location like '%District%'
Group by Location
Order By Location;


--Getting maximum new cases  in between the stated dates

select Location, CaseDate, max(NewCases) as HighestNewCases
from CoviData.dbo.CoviDeaths
Where CaseDate between '2020-03-01' and '2020-05-30' 
and NewCases is not null
group by Location, CaseDate
Order by Location, CaseDate;


--Getting death toll percentage of the district

select Location,(sum(DeathCases)/Population)* 100 as DeathPercentange
from CoviData.dbo.CoviDeaths
where Location Like '%District%' and DeathCases IS NOT NULL
Group By Location, Population
Order By Location;


-- Getting the highest new cases and highest death cases from the Hospitals

Select Location, max(NewCases) as HighestCases,max(DeathCases) as HighestDeathCases
from CoviData.dbo.CoviDeaths
Where Location like '%Hosp%' and DeathCases is not null
Group By Location
Order By Location;


--Getting the number of recoveries from all the hospitals recorded

Select Location,( sum(NewCases)) - (sum(DeathCases)) as RecoveryCases
from CoviData.dbo.CoviDeaths
Where Location like '%Hosp%' and DeathCases is not null
Group By Location
Order By Location;


/*Select*
from CoviVaccinations
order by Location;*/



-- Getting the highest vaccinted number and the total vaccinated per Location
Select c.Location, c.Population, max(cv.VaccinatedCases) as HighestVaccinated, sum(cv.VaccinatedCases) as TotalVaccinated
from CoviData.dbo.CoviDeaths as c
join CoviData.dbo.CoviVaccinations as cv
on c.NewCases = cv.NewCases
Group By c.Location, c.Population
Order By c.Location, c.Population;



/*Select c.Location, c.Population, cv.VaccinatedCases as HighestVaccinated
from CoviDeaths as c
join CoviVaccinations as cv
on c.NewCases = cv.NewCases
Order By Location;*/



-- Creating a new Table and copying data from other tables inorder to create a view since I'm working on an Excel workbook

drop table if exists VaccinStats

create table VaccinStats
(Location varchar(255), 
Population varchar(255),
HighestVaccinated varchar(255),
TotalVaccinated varchar(255))

insert into VaccinStats
Select c.Location, c.Population, max(cv.VaccinatedCases) as HighestVaccinated, sum(cv.VaccinatedCases) as TotalVaccinated
from CoviData.dbo.CoviDeaths as c
join CoviData.dbo.CoviVaccinations as cv
on c.NewCases = cv.NewCases
Group By c.Location, c.Population
Order By c.Location,c.Population;



/*Select *
from VaccinStats
Order By Location asc;*/