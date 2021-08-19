--Question 1: Top 5 most popular pieces of content consumed this week


/* Assumptions:
Given that there’s a one to many relationship between page_impression and content_metadata,
I’m assuming content_id will be duplicated in the page_impression table because multiple users
saw the same content_id. I can either count the users or simply count on the content_id field.
However, a user may have refreshed the page, registering 2 page impressions for a content id,
thus counting by the number of distinct users probably is more accurate.

I would have joined it to the content_metadata to display the headline or content name,
however the field is not available. I'm assuming content_id has some Id and perhaps a title in it.
Understanding what headlines clicked well is more interpretable for editorial folks. I started 
the date on Aug 18th, so I'm assuming this week means starting on a Monday. */

select content_id, count(distinct ad_user_id) as user_count
from Page_Impression
where date >= '2021-08-16'
group by content_id
order by count(distinct ad_user_id) desc
limit 5

/* Question 2: Number of weekly active users for the latest full week (Monday – Sunday). WAU
is calculated by counting registered users with > 60 seconds dwell time between
Monday-Sunday. */


With Temp as
(
select a.ads_user_id, sum(dwell_time) as total_dwell
from ad_service_interaction_data a
inner join oauth_id_service b on a.ads_user_id = b.ads_user_id
inner join registered_users c on b.oauth_id = c.oauth_id
where a.timestamp between '2021-08-09' and '2021-08-15'
group by a.ads_user_id
having sum(dwell_time) > 60
)
select count(distinct ads_user_id) as total_users
from temp

/* Question 3: Top 5 pieces of content from each content type consumed this week by only
active users (using the above definition).

Assumptions: I generally use left joins to uncover if there are any problems. For example,
content_id in the page_impression table may return a null in the content_metadata join. For
this exercise, I’m assuming the data is clean. */

With Temp as
(
select content_type, content_id, count(distinct ads_user_id) as user_count
from page_impression a
inner join content_metadata b on a.content_id = b.content_id
where a.timestamp between '2021-08-09' and '2021-08-15'
and a.ads_user_id in (select ads_user_id
from ads_service_interaction_data b
inner join oauth_id_service c on b.ads_user_id = c.ads_user_id
inner join registered_users d on c.oauth_id = d.oauth_id
where timestamp between '2021-08-09' and '2021-08-15'
group by ads_user_id
having sum(dwell_time) > 60)
group by content_type, content_id
), ranking as
(
select *, dense_rank() over(partition by content_type order by user_count desc) as
rank
from temp
)
select content_type, content_id, user_count
from ranking
where rank <= 5


