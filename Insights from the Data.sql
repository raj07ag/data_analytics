-- 1) Find number of businesses in each category
with cte as(
select business_id, trim(A.value) as category  
from tabular_business,
lateral split_to_table(categories,',') A)
select category, count(*) as business_count
from cte
group by category
order by business_count desc;


-- 2) Find the top 10 users who have reviewed the most businesses in the "Restraurants" category

select user_id, count(distinct r.business_id) as businesses_reviewed
from tabular_review as r
inner join tabular_business as b
on r.business_id = b.business_id
where categories ilike '%Restaurants%'
group by user_id
order by businesses_reviewed desc
limit 10;

-- 3) Find the most popular categories of businesses based on the number of reviews
with cte as(
select business_id, trim(A.value) as category
from tabular_business,
lateral split_to_table(categories,',') as A
)
select cte.category, count(*) as review_count
from cte
inner join 
tabular_review
on cte.business_id = tabular_review.business_id
group by category
order by review_count desc;

-- 4) Find 3 most recent review for each business
with cte as(
select *, 
row_number() over (partition by business_id order by review_date desc) recent_review 
from tabular_review)
select business_id, review
from cte 
where recent_review <= 3;

-- 5) Find the month with the highest number of reviews
select monthname(review_date) as month_name, count(*) as number_of_reviews
from tabular_review
group by monthname(review_date)
order by number_of_reviews desc;

-- 6) FInd the percentage of 5-star reviews for each business

with cte as (
select business_id, 
case when star_ratings = 5 then 1 else 0 end as five_star
from tabular_review)
select business_id, 
--sum(five_star) as five_starrer, count(*) as total_reviews,
sum(five_star)*100/count(*) as percentage 
from cte
group by business_id


-- 7) Find the top 5 most reviwed businesses in each city

with cte as(
select b.city, r.business_id, count(*) as number_of_reviews,
from tabular_review as r
inner join tabular_business as b
on r.business_id = b.business_id
group by 1, 2)
, cte1 as(
select *, 
row_number() over(partition by city order by number_of_reviews desc) as rn
from cte)
select * from cte1
where rn <=5;


-- 8) Find the average rating of businesses having atleast 100 reviews
select business_id, avg(star_ratings) as avg_ratings
from tabular_review
group by business_id
having count(*) > 100;


-- 9) List the top 10 users who have written the most reviews, alongwith the businesses they reviewed
with cte as(
select user_id, count(r.business_id) businesses_reviewed, 
from tabular_review r
group by user_id
order by 2 desc
limit 10)
select distinct user_id, business_id
from tabular_review
where user_id in (select user_id from cte)
--group by user_id, business_id
order by user_id;


-- 10) Find top 10 businesses with highest positive sentiment reviews
select business_id, count(*) as positive_reviews
from tabular_review
where sentiments = 'Positive'
group by business_id
order by 2 desc
limit 10
