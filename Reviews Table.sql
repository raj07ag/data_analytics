create or replace table yelp_reviews (review_text variant);

COPY INTO yelp_reviews
FROM 's3://yelp-data-analysis/reviews/' 
CREDENTIALS = (
AWS_KEY_ID = '***************'
AWS_SECRET_KEY = '********************'
)
FILE_FORMAT = (TYPE = JSON);

select * from yelp_reviews limit 100;

create or replace table tabular_review as
select review_text:business_id::string as business_id, 
review_text:user_id::string as user_id,
review_text:date::date as review_date,
review_text:stars::float as star_ratings,
review_text:text::string as review,
analyze_sentiment(review) as sentiments
from yelp_reviews
;