# World Layoffs Data Cleaning & Exploration

## Overview
Data cleaning and exploratory data analysis (EDA) project using MySQL 
on a real-world layoffs dataset.

## Dataset
The dataset contains information about company layoffs worldwide, including
company name, location, industry, number of employees laid off, percentage
laid off, date, stage, country, and funds raised.

## Part 1: Data Cleaning
1. Removed duplicate records using ROW_NUMBER() window function
2. Fixed NULL and empty string values in columns
3. Deleted rows where both total_laid_off and percentage_laid_off were NULL

## Part 2: Exploratory Data Analysis
1. **Layoffs by country** — total layoffs per country, ordered by highest impact
2. **Date range** — identified the earliest and latest dates in the dataset
3. **Rolling monthly total** — running total of layoffs per month using 
   a window function to track trends over time
4. **Layoffs by company per year** — total layoffs grouped by company and year
5. **Top 5 companies per year** — ranked companies by layoffs for each year 
   using DENSE_RANK() window function

## Tools Used
- MySQL / DBeaver
- Git / GitHub