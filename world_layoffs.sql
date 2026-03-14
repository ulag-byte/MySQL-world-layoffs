-- looking for and cleaning duplicates

select company, industry, total_laid_off,`date`,
		row_number() over (
			partition by company, industry, total_laid_off,`date`) as row_num
	from 
		world_layoffs.layoffs_staging;


select *
from (
	select company, industry, total_laid_off,`date`,
		row_number() over (
			partition by company, industry, total_laid_off,`date`
			) as row_num
	from 
		world_layoffs.layoffs_staging
) duplicates
where 
	row_num > 1;

select *
from world_layoffs.layoffs_staging
where company = 'oda'
;

    
select *
from (
	select company, location, industry, total_laid_off,percentage_laid_off,`date`, stage, country, funds_raised_millions,
		row_number() over (
			partition by company, location, industry, total_laid_off,percentage_laid_off,`date`, stage, country, funds_raised_millions
			) as row_num
	from 
		world_layoffs.layoffs_staging
) duplicates
where 
	row_num > 1;

delete t1
from world_layoffs.layoffs_staging t1
join (
    select company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions,
        row_number() over (
            partition by company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions
        ) as row_num
    from world_layoffs.layoffs_staging
) duplicates
    on  t1.company = duplicates.company
    and t1.location = duplicates.location
    and t1.industry = duplicates.industry
    and t1.total_laid_off = duplicates.total_laid_off
    and t1.percentage_laid_off = duplicates.percentage_laid_off
    and t1.`date` = duplicates.`date`
    and t1.stage = duplicates.stage
    and t1.country = duplicates.country
    and t1.funds_raised_millions = duplicates.funds_raised_millions
where duplicates.row_num > 1;


delete t1
from world_layoffs.layoffs_staging t1
join (
    select company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions,
        row_number() over (
            partition by company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions
        ) as row_num
    from world_layoffs.layoffs_staging
) ranked
    on  t1.company = ranked.company
    and t1.location = ranked.location
    and t1.industry = ranked.industry
    and t1.total_laid_off = ranked.total_laid_off
    and t1.percentage_laid_off = ranked.percentage_laid_off
    and t1.`date` = ranked.`date`
    and t1.stage = ranked.stage
    and t1.country = ranked.country
    and t1.funds_raised_millions = ranked.funds_raised_millions
where ranked.row_num > 1;


alter table world_layoffs.layoffs_staging add row_num int;

create table `world_layoffs`.`layoffs_staging2` (
`company` text,
`location`text,
`industry`text,
`total_laid_off` int,
`percentage_laid_off` text,
`date` text,
`stage`text,
`country` text,
`funds_raised_millions` int,
row_num int
);


insert into `world_layoffs`.`layoffs_staging2`
(`company`,
`location`,
`industry`,
`total_laid_off`,
`percentage_laid_off`,
`date`,
`stage`,
`country`,
`funds_raised_millions`,
`row_num`)
select `company`,
`location`,
`industry`,
`total_laid_off`,
`percentage_laid_off`,
`date`,
`stage`,
`country`,
`funds_raised_millions`,
		row_number() over (
			partition by company, location, industry, total_laid_off,percentage_laid_off,`date`, stage, country, funds_raised_millions
			) as row_num
	from 
		world_layoffs.layoffs_staging;


-- stardardizing data

update world_layoffs.layoffs_staging2
set industry = null
where industry = '';

update layoffs_staging2 t1
join layoffs_staging2 t2
on t1.company = t2.company
set t1.industry = t2.industry
where t1.industry is null
and t2.industry is not null;

select *
from world_layoffs.layoffs_staging2
where industry is null 
or industry = ''
order by industry;


update layoffs_staging2
set industry = 'crypto'
where industry in ('crypto currency', 'cryptocurrency');

update layoffs_staging2
set country = trim(trailing '.' from country);

alter table layoffs_staging2
modify column `date` date;

alter table world_layoffs.layoffs_staging2
add column id int auto_increment primary key first;

select * 
from layoffs_staging2;

delete from layoffs_staging2 
where total_laid_off is null; 


delete from world_layoffs.layoffs_staging2
where percentage_laid_off regexp '[^0-9.]';


