# Yelp Review Analysis – End-to-End Data Analytics Project
## Overview
This project focuses on end-to-end data analysis of Yelp reviews using AWS, Snowflake, and Python. It involves ingesting large-scale JSON data, performing sentiment analysis using a user-defined function (UDF) in Snowflake, and answering analytical business questions using SQL. The dataset used includes millions of reviews and business details available from Yelp’s open dataset.

## Tools Used
Python – Data preprocessing, JSON splitting, API interaction, and sentiment UDF logic

AWS S3 – Cloud storage for scalable and parallel ingestion into Snowflake

Snowflake – Cloud data warehouse for storing, querying, and analyzing semi-structured JSON data

TextBlob – For sentiment analysis in Python

SQL – For writing and executing analytical queries

## Workflow / Steps Followed
### Download & Prepare Data:

Yelp review dataset (5GB JSON) and business dataset (100MB JSON) downloaded.

JSON review file is split into 10–25 smaller files using Python for efficient upload and parallel ingestion.

### Data Ingestion:

Upload the split JSON files to AWS S3.

Use COPY INTO commands in Snowflake to load data from S3 into tables using VARIANT type.

### Table Creation & Transformation:

Transform raw JSON data into structured format with relevant fields: business ID, review date, stars, review text, etc.

Create normalized tables for reviews and businesses.

### Sentiment Analysis:

Implemented a Python UDF in Snowflake using TextBlob.

UDF classifies sentiment as Positive, Negative, or Neutral.

Data Analysis via SQL:

## Write SQL queries to answer 10 business questions
