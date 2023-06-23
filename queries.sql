-- Yammer User Engagement SQL Analysis (BigQuery)

-- Step 1: Investigate tables using SELECT *
-- Step 2: Find engagement trend by examining weekly active users from May through August 2022
-- Step 3: Examine user growth rate to see if stalling growth is the reason for decreased engagement
-- Step 4: Examine average account age by week to see if engagement is falling among existing older users
-- Step 5: Examine engagement by device type


-- Step 1: Investigate tables using SELECT *

select * from yammer.users limit 100;
select * from yammer.events limit 100;
select * from yammer.emails limit 100;


-- Step 2: Find engagement trend by examining weekly active users from May through August 2022
-- 'Weekly active users' is defined as 'accounts that logged in during the week starting on the measurement date'

select
    date_trunc(CAST(occurred_at as timestamp), week) AS week,
    count(distinct user_id) as weekly_active_users
from yammer.events
where 
    event_type = 'engagement'
    and event_name = 'login'
group by 1
order by 1


-- Step 3: Examine user growth rate to see if stalling growth is the reason for decreased engagement
-- Query result shows the number of created accounts vs. activated accounts per day

select
    distinct extract(date from cast(created_at as datetime)) as day,
    count(created_at) as created_acc,
    count(activated_at) as activated_acc
from yammer.users
where created_at between '2022-05-01' and '2022-09-01'
group by 1
order by 1


-- Step 4: Examine average account age by week to see if engagement is falling among existing older users

select
    date_trunc(cast(z.occurred_at as timestamp), week) as week,
    avg(z.age_at_event) as avg_age_during_week
from (
    select
        e.occurred_at,
        u.activated_at,
        u.user_id,
        date_diff(cast(e.occurred_at as timestamp), cast(u.activated_at as timestamp), day) as age_at_event
    from yammer.users u
    join yammer.events e
    on u.user_id = e.user_id
        and e.event_type = 'engagement'
        and e.event_name = 'login'
        and e.occurred_at >= '2022-05-01'
        and e.occurred_at < '2022-09-01'
    where u.activated_at is not null
) z
group by 1
order by 1


-- Step 5: Examine engagement by device type
-- Query groups all individual devices into three categories: computer, tablet, and phone

select
    date_trunc(cast(occurred_at as timestamp), week) as week,
    count(distinct user_id) as weekly_active_users,
    count(distinct case when device
        in('macbook pro','lenovo thinkpad','macbook air','dell inspiron notebook',
        'asus chromebook','dell inspiron desktop','acer aspire notebook',
        'hp pavilion desktop','acer aspire desktop','mac mini') 
        then user_id else null end) as computer,
    count(distinct case when device
        in('ipad air','nexus 7','ipad mini','nexus 10','kindle fire','windows surface',
        'samsumg galaxy tablet')
        then user_id else null end) as tablet,
    count(distinct case when device
        in('iphone 5','samsung galaxy s4','nexus 5','iphone 5s','iphone 4s','nokia lumia 635',
        'htc one','samsung galaxy note','amazon fire phone')
        then user_id else null end) as phone
from yammer.events
where event_type = 'engagement'
    and event_name = 'login'
group by 1
order by 1
    

