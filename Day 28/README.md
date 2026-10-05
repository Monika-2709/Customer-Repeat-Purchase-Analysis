# Customer Repeat Purchase Analysis — Level 2 Day 28

## Objective
Measure repeat purchase behavior, identify repeat-customer segments, and understand customer loyalty.

## Tools
- Python (Pandas, NumPy)
- SQL (SQLite-compatible)
- CSV dataset

## Dataset
A realistic synthetic e-commerce transaction dataset was generated for this project so the analysis is fully reproducible and shareable without external data licensing restrictions.

## Definition
A **repeat customer** is a customer with **2 or more distinct orders** during the analysis period.

## Key results
- Total customers: 2,500
- Repeat customers: 1,299
- One-time customers: 1,201
- Repeat customer rate: 51.96%
- First-time AOV: 52.36
- Repeat customer AOV: 65.83

## Segments
- One-time: exactly 1 order
- Repeat (2-3 orders): 2 to 3 orders
- Loyal (4+ orders): 4 or more orders

## Files
- `orders.csv` — transaction-level dataset
- `customer_segments.csv` — customer-level repeat/loyalty classification
- `segment_table.csv` — segment KPI table
- `category_summary.csv` — category summary
- `analysis.py` — Python analysis script
- `analysis.sql` — SQL queries
- `Customer_Repeat_Purchase_Analysis_Report.pdf` — final report

## How to run
```bash
pip install pandas numpy
python analysis.py
```

For SQL, import `orders.csv` into SQLite/MySQL/PostgreSQL and adapt the CSV import command if needed.