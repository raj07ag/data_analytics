create or replace table yelp_business (business_text variant);

COPY INTO yelp_business
FROM 's3://yelp-data-analysis/yelp_academic_dataset_business.json' 
CREDENTIALS = (
AWS_KEY_ID= '****************'
AWS_SECRET_KEY = '**********************'
)
FILE_FORMAT = (TYPE = JSON);

select * from yelp_business limit 100;

create or replace table tabular_business as
select business_text:business_id::string as business_id,
business_text:name::string as name,
business_text:city::string as city,
business_text:state::string as state,
business_text:review_count::number as review_count,
business_text:stars::float as stars,
business_text:categories::string as categories
from yelp_business;