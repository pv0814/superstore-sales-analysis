# Superstore Sales Analysis (MySQL + Tableau)

An end-to-end analysis of 9,994 retail orders (2014-2017) from the Superstore dataset. I cleaned the data, answered business questions with SQL in MySQL, and built an interactive dashboard in Tableau Public.

![Superstore Sales Dashboard](Dashboard.png)

**Live dashboard:** [View on Tableau Public](https://public.tableau.com/app/profile/deekshitha.palnati/viz/SuperstoreSalesDashboard_17912803934920/SuperstoreSalesDashboard)

## Business questions

1. What are total sales and profit?
2. Which categories and sub-categories make or lose money?
3. How does discounting affect profit?
4. Which regions and states perform best and worst?
5. How have sales and profit changed over time?

## Key findings

- **Overall:** about $2.30M in sales and $286K in profit (12.5% margin).
- **Loss-making sub-categories:** Tables (about -$17.7K), Bookcases (about -$3.5K) and Supplies (about -$1.2K).
- **Discounts drive losses:** orders with no discount earned about $321K profit and discounts up to 20% earned about $101K. Discounts of 20-40% lost about $36K and discounts above 40% lost about $100K.
- **Regions:** West has the best margin (14.9%) and Central the weakest (7.9%).
- **States losing the most money:** Texas (about -$25.7K), Ohio (about -$17.0K) and Pennsylvania (about -$15.6K).
- **Growth:** sales rose from about $484K in 2014 to $733K in 2017, with the strongest growth in 2016 (+29.5%) and 2017 (+20.4%).
- **Recommendation:** cap discounts near 20% and review pricing for Tables and Bookcases.

## SQL skills used

Aggregations (`SUM`, `COUNT`, `AVG`), `GROUP BY` / `HAVING`, `CASE` expressions, subqueries, window functions (`RANK`, `LAG`), date functions and data quality checks.

## Files

| File | Description |
|---|---|
| `analysis.sql` | 12 SQL queries, each with the business question above it |
| `notes.md` | Data cleaning notes |
| `Dashboard.png` | Screenshot of the Tableau dashboard |
| `superstore_clean.csv` | Cleaned dataset used for the Tableau dashboard |
| `superstore_mysql_ascii.csv` | Cleaned dataset used for the SQL analysis |

## How to run

1. Install MySQL and MySQL Workbench.
2. Create the `superstore` database and the `orders` table.
3. Import `superstore_mysql_ascii.csv` with the Table Data Import Wizard.
4. Run the queries in `analysis.sql`.

## Data cleaning

- Converted the file encoding to UTF-8 and then to plain ASCII for a reliable MySQL import (accents and non-breaking spaces removed in 367 text cells).
- Converted dates from M/D/YYYY to YYYY-MM-DD.
- Checked for missing values and duplicates: none found.

## Tools

MySQL, MySQL Workbench, Tableau Public, SQL.
