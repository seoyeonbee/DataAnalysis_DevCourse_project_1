-- 여성 소비자의 연령대별 새벽시간(02-06시) 평균 결제건수 전년 대비 증감율 파악
WITH YearlyAverages AS (
    SELECT 
		agt.age_group,
        YEAR(dt.cri_date) AS year,
        AVG(trt.transaction_count) AS avg_transactions
    FROM 
        normalized_table nt
        INNER JOIN date_table dt ON nt.date_id = dt.date_id
        INNER JOIN gender_table gt ON nt.gender_id = gt.gender_id
        INNER JOIN time_table tit ON nt.time_id = tit.time_id
        INNER JOIN age_table agt ON nt.age_id = agt.age_id
        INNER JOIN transaction_table trt ON nt.transaction_id = trt.transaction_id
	WHERE gt.gender = 0 AND tit.time_range = '02-06' -- 새벽시간(02-06시) 여성 소비자로 한정
    GROUP BY 2, 1
),
GrowthRates AS (
    SELECT
        age_group,
        year,
        avg_transactions,
        LAG(avg_transactions) OVER (PARTITION BY age_group ORDER BY year) AS prev_year_transactions,
        (avg_transactions - LAG(avg_transactions) OVER (PARTITION BY age_group ORDER BY year)) / LAG(avg_transactions) OVER (PARTITION BY age_group ORDER BY year) 
        * 100 AS growth_rate
    FROM YearlyAverages
)
SELECT age_group, year, growth_rate
FROM GrowthRates
ORDER BY 1, 2;
