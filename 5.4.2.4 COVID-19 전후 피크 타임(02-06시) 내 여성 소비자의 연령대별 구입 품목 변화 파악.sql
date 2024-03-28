-- 각 연도에 따른 여성 소비자의 새벽시간대(02-06시) 연령대별 구입 품목 건수합계 파악
-- COVID-19 확산 이전 2019
SELECT agt.age_group, tt.tag, SUM(trt.transaction_count) AS sum_transactions
FROM normalized_table nt
INNER JOIN date_table dt ON nt.date_id = dt.date_id
INNER JOIN gender_table gt ON nt.gender_id = gt.gender_id
INNER JOIN age_table agt ON nt.age_id = agt.age_id 
INNER JOIN time_table tit ON nt.time_id = tit.time_id
INNER JOIN tag_table tt ON nt.tag_id = tt.tag_id
INNER JOIN transaction_table trt ON nt.transaction_id = trt.transaction_id
WHERE YEAR(dt.cri_date) = 2019 AND gt.gender = 0 AND tit.time_range = '02-06'
GROUP BY 2, 1
ORDER BY 2;



-- 각 연도에 따른 여성 소비자의 새벽시간대(02-06시) 연령대별 구입 품목 건수합계 파악
-- COVID-19 확산 이후 2020
SELECT agt.age_group, tt.tag, SUM(trt.transaction_count) AS sum_transactions
FROM normalized_table nt
INNER JOIN date_table dt ON nt.date_id = dt.date_id
INNER JOIN gender_table gt ON nt.gender_id = gt.gender_id
INNER JOIN age_table agt ON nt.age_id = agt.age_id 
INNER JOIN time_table tit ON nt.time_id = tit.time_id
INNER JOIN tag_table tt ON nt.tag_id = tt.tag_id
INNER JOIN transaction_table trt ON nt.transaction_id = trt.transaction_id
WHERE YEAR(dt.cri_date) = 2020 AND gt.gender = 0 AND tit.time_range = '02-06'
GROUP BY 2, 1
ORDER BY 2;
