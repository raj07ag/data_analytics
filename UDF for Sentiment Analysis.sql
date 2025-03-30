CREATE OR REPLACE FUNCTION analyze_sentiment(text string)
returns string
language Python
RUNTIME_VERSION = '3.8'
PACKAGES = ('textblob')
HANDLER = 'sentiment_analyzer'

AS $$
from textblob import TextBlob
def sentiment_analyzer(text):
    analysis = TextBlob(text)
    if analysis.sentiment.polarity > 0:
        return 'Positive'
    if analysis.sentiment.polarity == 0:
        return 'Neutral'
    else:
        return 'Negative'
$$;