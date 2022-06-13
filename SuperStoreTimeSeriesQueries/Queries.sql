
--Compare Sales of one date to the sales of the next date.
SELECT [Order Date], sum(Sales) as [Daily Sales],
	LEAD(sum(Sales), 1, 0) OVER (ORDER BY [Order Date]) as [Next Day Sales]
FROM superstore_test
GROUP BY [Order Date]
ORDER BY [Order Date]

--Compare sales of one date to sales of previous date.
SELECT [Order Date], sum(Sales) as [Daily Sales],
	LAG(SUM(Sales),1,0) OVER (ORDER BY [Order Date]) as [Previous Days Sales]
FROM superstore_test
GROUP By [Order Date]
ORDER BY [Order Date]

-- Presents the top 10 selling states by year.
SELECT * FROM (
	SELECT Year, State, Sales,
		RANK() OVER (PARTITION BY Year ORDER BY Sales desc) Rank
		FROM
		(
		SELECT 
			YEAR([Order Date]) AS Year, SUM(Sales) as Sales, State
			FROM superstore_test
			GROUP BY Year([Order Date]), State
		) AS a
) as b where Rank <=10

-- Present the Average sales of a given day of a month.
SELECT DATENAME(month, [Order Date]) as Month, DAY([Order Date]) AS Day, AVG(Sales) AS Average_Sales
	FROM superstore_test
	GROUP BY DATENAME(month, [Order Date]), DAY([Order Date]), MONTH([Order Date])
	ORDER BY MONTH([Order Date]), DAY([Order Date])

-- Displays the change in average daily discount
SELECT [Order Date], AVG(Discount) as Averge_Daily_Discount,
	LEAD(AVG(Discount), 1, 0) OVER (ORDER BY [Order Date]) AS Average_Next_Day_Discount,
	LEAD(AVG(Discount), 1, 0) OVER (ORDER BY [Order Date]) - AVG(Discount) AS Change_In_Discount
	FROM superstore_test
	GROUP BY [Order Date]
	ORDER BY [Order Date]

-- Displays change in average monthly discount
SELECT DATENAME(month, [Order Date]) AS MONTH, AVG(Discount) as Averge_Monthly_Discount,
	LEAD(AVG(Discount), 1, 0) OVER (ORDER BY MONTH([Order Date])) AS Average_Next_Day_Discount,
	LEAD(AVG(Discount), 1, 0) OVER (ORDER BY MONTH([Order Date])) - AVG(Discount) AS Change_In_Discount
	FROM superstore_test
	GROUP BY DATENAME(month, [Order Date]), MONTH([Order Date])
	ORDER BY MONTH([Order Date])

-- Presents the moving sales average of a one week preceding and following a given date.
SELECT [Order Date] AS Date, Sales, AVG(Sales) 
	OVER (ORDER BY [Order Date] ROWS BETWEEN 6 preceding and 7 FOLLOWING) AS Two_Week_Moving_Average
	FROM superstore_test

	






