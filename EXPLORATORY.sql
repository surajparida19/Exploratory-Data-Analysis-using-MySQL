-- Exploratry Data Analysis

Select *
from layoffs_staging2;


Select MAX(total_laid_off),MAX(percentage_laid_off)
from layoffs_staging2;

Select *
from layoffs_staging2
Where percentage_laid_off=1
ORDER BY funds_raised_millions DESC;


Select company, SUM(total_laid_off)
from layoffs_staging2
GROUP BY company
order by 2 DESC;
SELECT MIN(`DATE`),MAX(`DATE`)
FROM layoffs_staging2;


Select Industry, SUM(total_laid_off)
from layoffs_staging2
GROUP BY Industry
order by 2 DESC;

Select YEAR(`DATE`), SUM(total_laid_off)
from layoffs_staging2
GROUP BY YEAR(`DATE`)
order by 1 DESC;


SELECT SUBSTRING(`date`,6,2) AS `MONTH` ,SUM(total_laid_off)
from layoffs_staging2
WHERE substring(`date`,1,7) IS NOT NULL
GROUP BY `month`
ORDER BY 1 ASC;


SELECT *
from layoffs_staging2;


WITH Rolling_Total AS
(
SELECT SUBSTRING(`date`,1,7) AS `MONTH` ,SUM(total_laid_off) AS total_off
from layoffs_staging2
WHERE substring(`date`,1,7) IS NOT NULL
GROUP BY `month`
ORDER BY 1 ASC
)
SELECT `Month`,SUM(total_off) OVER(Order BY `Month`) AS Rolling_total
From Rolling_Total;



Select Company, YEAR(`DATE`), SUM(total_laid_off)
from layoffs_staging2
GROUP BY Company, YEAR(`DATE`)
order by 3 DESC;


WITH Company_year (company,years,total_laid_off) As
(
Select Company, YEAR(`DATE`), SUM(total_laid_off)
from layoffs_staging2
GROUP BY Company, YEAR(`DATE`)
),Comapny_year_rank AS 
(SELECT *,
DENSE_rank() OVER(partition by years order by total_laid_off DESC) AS total_ytl
from company_year
WHERE years is NOT NULL
)
SELECT *
from Comapny_year_rank
WHERE total_ytl <=5;

