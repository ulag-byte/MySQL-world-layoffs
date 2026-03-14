# World Layoffs Data Cleaning and Analysing

## Overview
Data cleaning project using MySQL on a real-world layoffs dataset.

## Dataset
The dataset contains information about company layoffs worldwide, including
company name, location, industry, number of employees laid off, percentage
laid off, date, stage, country, and funds raised.

## Steps Performed
1. Removed duplicate records using ROW_NUMBER() window function
2. Fixed NULL and empty string values in columns
3. Deleted rows where both total_laid_off and percentage_laid_off were NULL

## Tools Used
- MySQL / DBeaver
- Git / GitHub
