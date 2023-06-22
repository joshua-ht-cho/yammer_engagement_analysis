-- Yammer User Engagement SQL Analysis (BigQuery)

-- Step 1: Investigate tables using SELECT *
-- Step 2: Find engagement trend by examining weekly active users from May through August 2022


-- Step 1: Investigate tables using SELECT *
select * from yammer.users limit 100;
select * from yammer.events limit 100;
select * from yammer.emails limit 100;


-- Step 2: Find engagement trend by examining weekly active users from May through August 2022
-- 'Weekly active users' metric is defined as 'accounts that logged in during the week starting on the measurement date.

select
    date_trunc(CAST(occurred_at as timestamp), week) AS week,
    count(distinct user_id) as weekly_active_users
from yammer.events
where 
    event_type = 'engagement'
    and event_name = 'login'
group by 1
order by 1
