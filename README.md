# French Bakery - Sales Analytics Solution

A French bakery is looking to gain insights into their data to enhance their business decisions.

They have been collecting data for 1 year and 9 months and it’s been saved within this excel spreadsheet:

[French bakery (unclean) CSV file](https://www.dropbox.com/scl/fi/tzltzcp7eu90eko8izm8u/Bakery-sales-unclean.csv?rlkey=8uhkq1c6offh1yibxban2u3fd&dl=0)

### Import the data:

```python
import numpy as np
import pandas as pd
data = pd.read_csv(r"C:\Users\georg\Desktop\Data Centre\DataPython\Projects\Bakery Sales Data\Bakery sales unclean.csv")
data.info()
```

```
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 234005 entries, 0 to 234004
Data columns (total 7 columns):
 #   Column         Non-Null Count   Dtype  
---  ------         --------------   -----  
 0   Unnamed: 0     234005 non-null  int64  
 1   date           234005 non-null  object 
 2   time           234005 non-null  object 
 3   ticket_number  234005 non-null  float64
 4   article        234005 non-null  object 
 5   Quantity       234005 non-null  float64
 6   unit_price     234005 non-null  object 
dtypes: float64(2), int64(1), object(4)
memory usage: 12.5+ MB
```

### View the data:

```python
data.head(5)
```

|  | Unnamed: 0 | date | time | ticket_number | article | Quantity | unit_price |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 0 | 0 | 2021-01-02 | 08:38 | 150040.0 | BAGUETTE | 1.0 | 0,90 € |
| 1 | 1 | 2021-01-02 | 08:38 | 150040.0 | PAIN AU CHOCOLAT | 3.0 | 1,20 € |
| 2 | 4 | 2021-01-02 | 09:14 | 150041.0 | PAIN AU CHOCOLAT | 2.0 | 1,20 € |
| 3 | 5 | 2021-01-02 | 09:14 | 150041.0 | PAIN | 1.0 | 1,15 € |
| 4 | 8 | 2021-01-02 | 09:25 | 150042.0 | TRADITIONAL BAGUETTE | 5.0 | 1,20 € |

### **Clean the data:**

To be cleaned:

1. Checking for null values and decide whether or not it's suitable for analysis.
2. Column naming tidied.
3. Drop index column.
4. Date column format changed from object to suitable quantifiable format.
5. Ticket number changed from float to an integer.
6. Quantity changed from float to an integer.
7. Price column format changed from object to suitable quantifiable format.

1.

```python
def null_values(data):
    null_count = data.isnull().sum()
    null_data = pd.DataFrame({'Column': null_count.index, 'Null values': null_count.values})
    return null_data
```

```python
null = null_values(data)
print(null)
```

```
          Column  Null values
0     Unnamed: 0            0
1           date            0
2           time            0
3  ticket_number            0
4        article            0
5       Quantity            0
6     unit_price            0
```

2.

```python
renamed = {"date": "Date", "time": "Time",
 "ticket_number": "Ticket_number",
 "article": "Product", "unit_price": "Euros" }
data.rename(columns = renamed, inplace = True)
data.head(5)
```

|  | Unnamed: 0 | Date | Time | Ticket_number | Product | Quantity | Euros |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 0 | 0 | 2021-01-02 | 08:38 | 150040.0 | BAGUETTE | 1.0 | 0,90 € |
| 1 | 1 | 2021-01-02 | 08:38 | 150040.0 | PAIN AU CHOCOLAT | 3.0 | 1,20 € |
| 2 | 4 | 2021-01-02 | 09:14 | 150041.0 | PAIN AU CHOCOLAT | 2.0 | 1,20 € |
| 3 | 5 | 2021-01-02 | 09:14 | 150041.0 | PAIN | 1.0 | 1,15 € |
| 4 | 8 | 2021-01-02 | 09:25 | 150042.0 | TRADITIONAL BAGUETTE | 5.0 | 1,20 € |

3.

```python
data.drop("Unnamed: 0", axis = 1, inplace = True)
data.columns
```

```
Index(['Date', 'Time', 'Ticket_number', 'Product', 'Quantity', 'Euros'], dtype='object')
```

4.

```python
data['Date'] = pd.to_datetime(data['Date'])
data.info()
```

```
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 234005 entries, 0 to 234004
Data columns (total 6 columns):
 #   Column         Non-Null Count   Dtype         
---  ------         --------------   -----         
 0   Date           234005 non-null  datetime64[ns]
 1   Time           234005 non-null  object        
 2   Ticket_number  234005 non-null  float64       
 3   Product        234005 non-null  object        
 4   Quantity       234005 non-null  float64       
 5   Euros          234005 non-null  object        
dtypes: datetime64[ns](1), float64(2), object(3)
memory usage: 10.7+ MB
```

5.

```python
data["Ticket_number"] = data["Ticket_number"].astype(int)
data.head()
```

6.

```python
data["Quantity"] = data["Quantity"].astype(int)
data.head()
```

7.

```python
data["Euros"] = data["Euros"].str[:-2]
data["Euros"] = data["Euros"].str.replace(',', '.')
data["Euros"] = data["Euros"].astype(float)
data.info()
```

```
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 234005 entries, 0 to 234004
Data columns (total 6 columns):
 #   Column         Non-Null Count   Dtype         
---  ------         --------------   -----         
 0   Date           234005 non-null  datetime64[ns]
 1   Time           234005 non-null  int32         
 2   Ticket_number  234005 non-null  int32         
 3   Product        234005 non-null  object        
 4   Quantity       234005 non-null  int32         
 5   Euros          234005 non-null  float64       
dtypes: datetime64[ns](1), float64(1), int32(3), object(1)
memory usage: 8.0+ MB
```

```python
data.head()
```

|  | Date | Time | Ticket_number | Product | Quantity | Euros |
| --- | --- | --- | --- | --- | --- | --- |
| 0 | 2021-01-02 | 8:38 | 150040 | BAGUETTE | 1 | 0.90 |
| 1 | 2021-01-02 | 8:38 | 150040 | PAIN AU CHOCOLAT | 3 | 1.20 |
| 2 | 2021-01-02 | 9:14 | 150041 | PAIN AU CHOCOLAT | 2 | 1.20 |
| 3 | 2021-01-02 | 9:14 | 150041 | PAIN | 1 | 1.15 |
| 4 | 2021-01-02 | 9:25 | 150042 | TRADITIONAL BAGUETTE | 5 | 1.20 |

Data is now ready for some EDA in SQL, I will save this dataset to a CSV file.

```python
data.to_csv(r"C:\Users\georg\Desktop\Data Centre\DataPython\Projects\Bakery Sales Data\Bakery sales.csv")
```

File:

[French Bakery (clean) CSV File](https://www.dropbox.com/scl/fi/3y0ccnggg7jjqhco4zujr/Bakery-sales.csv?rlkey=l9n4py2hs473xywboyaw7ybdn&dl=0)

### Analyse the data:

```sql
SELECT * FROM french_bakery
ORDER BY date ASC
LIMIT 1000;
```

The total number of sales per day

```sql
SELECT date, CAST(SUM(euros) AS numeric(10, 2)) AS total_sales
FROM french_bakery
GROUP BY date
ORDER BY date;
```

```
date total_sales

"2021-01-02"	716.95
"2021-01-03"	782.85
"2021-01-04"	340.00
"2021-01-05"	424.65
"2021-01-07"	428.30
"2021-01-08"	442.00
"2021-01-09"	518.90
"2021-01-10"	712.55
"2021-01-11"	353.35
"2021-01-12"	290.05
```

Average daily earnings

```sql
SELECT CAST(SUM(euros) / COUNT(DISTINCT date) AS numeric(10, 2))  AS average_daily_sales
FROM french_bakery;
```

```
average_daily_sales

648.69
```

Busiest time of day

```sql
SELECT time, COUNT(ticket_number) AS ticket_count
FROM french_bakery
GROUP BY time
ORDER BY ticket_count DESC
LIMIT 10;
```

```
time  ticket count

11:43	859
12:11	850
11:46	850
12:05	847
11:23	845
11:39	841
11:33	838
11:52	836
11:13	822
11:49	822
```

Top selling products

```sql
SELECT product, SUM(quantity) AS total_quantity
FROM french_bakery
GROUP BY product
ORDER BY total_quantity DESC;
```

```
product total_quantity

"TRADITIONAL BAGUETTE"	117463
"CROISSANT"	29654
"PAIN AU CHOCOLAT"	25236
"COUPE"	23505
"BANETTE"	22732
"BAGUETTE"	22053
"CEREAL BAGUETTE"	7427
"SPECIAL BREAD"	5456
"FORMULE SANDWICH"	5181
"TARTELETTE"	5020
```

Average sales per ticket number

```sql
SELECT ticket_number, CAST(AVG(euros) AS numeric(10, 2)) AS average_sales
FROM french_bakery
GROUP BY ticket_number
ORDER BY average_sales DESC;
```

```
ticket_number average_sales

157975	44.00
268189	35.00
214575	28.00
269498	22.10
169292	22.00
284721	21.67
233843	21.60
277215	21.00
271181	21.00
255208	21.00
```

Monthly revenue trend

```sql
SELECT EXTRACT(MONTH FROM date) AS month, SUM(euros) AS total_sales
FROM french_bakery
GROUP BY month
ORDER BY month;
```

```
month total_sales

1	23775.607
2	24756.902
3	28851.2
4	35292.56
5	41049.25
6	35324.45
7	59440.113
8	66049.14
9	31747.904
10	16126.679
11	13108.486
12	13447.59
```

Weekdays vs weekends revenue

```sql
SELECT 
    CASE
        WHEN EXTRACT(ISODOW FROM date) < 6 THEN 'Weekday'
        ELSE 'Weekend'
    END AS day_type,
    CAST(AVG(daily_revenue) AS numeric(10, 2)) AS average_daily_revenue
FROM (
    SELECT 
        date,
        SUM(euros) AS daily_revenue
    FROM french_bakery
    GROUP BY date
) AS subquery
GROUP BY day_type;
```

```
day_type average_daily_revenue

"Weekday"	583.86
"Weekend"	797.38
```

Product popularity over time

```sql
SELECT date, SUM(quantity) AS total_quantity
FROM french_bakery
WHERE product = 'TRADITIONAL BAGUETTE'
GROUP BY date
ORDER BY date;
```

```
date total_quantity

"2021-01-02"	128
"2021-01-03"	171
"2021-01-04"	128
"2021-01-05"	99
"2021-01-07"	109
"2021-01-08"	78
"2021-01-09"	135
"2021-01-10"	140
"2021-01-11"	88
"2021-01-12"	71
```

### Visualise the data:

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/e48279fc-5273-419e-990a-3dd34ca3c3fa/Untitled.png)

Full version: [Tableau Time Series Viz](https://public.tableau.com/app/profile/george.horgan/viz/French_bakery_series/TimeSeries)

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/ef5e3b3e-17c3-4130-882c-50ee057631c6/Untitled.png)

Full version: [Tableau Pie Viz](https://public.tableau.com/app/profile/george.horgan/viz/French_bakery_pie/PieChart)

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/d7641fdf-ae9a-46b7-9d36-af995eeaf207/Untitled.png)

Full version: [Power BI file download](https://www.dropbox.com/scl/fi/hsf6ftkdhvwmi2ru0td7l/French_bakery.pbix?rlkey=4iwbcfrw9d6l67nq6162tbh4k&dl=0)
