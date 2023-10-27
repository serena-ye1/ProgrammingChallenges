-- Question 1: Get the sum of impressions by day.
SELECT date, SUM(impressions) AS total_impressions
FROM marketing_data
GROUP BY date
ORDER BY date;

-- Question 2: Get the top three revenue-generating states and the revenue of the third best state.
SELECT state, SUM(revenue) AS total_revenue
FROM website_revenue
GROUP BY state
ORDER BY total_revenue DESC
LIMIT 3 OFFSET 2;

-- Question 3: Show total cost, impressions, clicks, and revenue of each campaign including the campaign name.
SELECT c.name AS campaign_name, SUM(m.cost) AS total_cost, SUM(m.impressions) AS total_impressions,
       SUM(m.clicks) AS total_clicks, SUM(w.revenue) AS total_revenue
FROM campaign_info c
LEFT JOIN marketing_data m ON c.id = m.campaign_id
LEFT JOIN website_revenue w ON c.id = w.campaign_id
GROUP BY c.name;

-- Question 4: Get the number of conversions of Campaign5 by state and identify the state with the most conversions.
SELECT m.geo AS state, SUM(m.conversions) AS total_conversions
FROM marketing_data m
WHERE m.campaign_id = 'Campaign5'
GROUP BY m.geo
ORDER BY total_conversions DESC
LIMIT 1;

-- Question 5: Determine the most efficient campaign and provide a rationale.
-- You can define efficiency as the ratio of revenue to cost.
SELECT c.name AS campaign_name, 
       SUM(w.revenue) / SUM(m.cost) AS efficiency
FROM campaign_info c
LEFT JOIN marketing_data m ON c.id = m.campaign_id
LEFT JOIN website_revenue w ON c.id = w.campaign_id
GROUP BY c.name
ORDER BY efficiency DESC
LIMIT 1;

-- Bonus Question: Find the best day of the week to run ads based on total impressions.
SELECT DAYNAME(date) AS day_of_week, SUM(impressions) AS total_impressions
FROM marketing_data
GROUP BY day_of_week
ORDER BY total_impressions DESC
LIMIT 1;
