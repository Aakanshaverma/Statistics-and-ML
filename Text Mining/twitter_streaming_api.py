from tweepy.streaming import StreamListener
from tweepy import OAuthHandler
from tweepy import Stream
import json
import glob
import pandas as pd
from nltk.sentiment.vader import SentimentIntensityAnalyzer
import glob

senti = SentimentIntensityAnalyzer()

consumer_key = "UPhTA6R3r5ItZl3lj5oD4uX1V"
consumer_secret = "5ynPQBAKk94cUTGB2pxmRr3I4SDiWzrctbghYT9oPl056yToTv"

access_token = "735546481189474304-EaikHxhKPhL6d4LDDPVX5UgckiKPrgW"
access_token_secret = "ti24czV8dy4A0EvtmAvSkyhbA3e1bpgGrRrBUEjst1gnn"


class StdOutListener(StreamListener):

    def on_data(self, data):
        data = json.loads(data)
        user_name=data['user']['name']
        screen_name=data['user']['screen_name']
        created_at=data['created_at']
        geo=data['geo']
        location=data['user']['location']
        text=data['text']
        sentiment_score=senti.polarity_scores(text)['compound']
        if sentiment_score>0.2:
            sentiment='Positive'
        elif sentiment_score<-0.2:
            sentiment='Negative'
        else:
            sentiment='Neutral'
            
        #print('-------------some twittered with #MiddleClassWithModi--------')
        
        cwd_files=glob.glob('tweets_streaming.csv')
        is_file_exist='tweets_streaming.csv' in cwd_files
        print(cwd_files)
        
        tweet_df=pd.DataFrame({'user':[user_name],'text':[text],
                               'created_at':[created_at],'sentiment':[sentiment]})
        
        try:
            if not is_file_exist:
                tweet_df.to_csv('tweets_streaming.csv',index=False)
            else:
                with open('tweets_streaming.csv','a') as f:
                    tweet_df.to_csv(f, index=False, header=False)

        except Exception as error:
            print(error)
        #print(text, sentiment)
        return True

    def on_error(self, status):
        print (status)


if __name__ == '__main__':
    l = StdOutListener()
    auth = OAuthHandler(consumer_key, consumer_secret)
    auth.set_access_token(access_token, access_token_secret)
    stream = Stream(auth, l)
    stream.filter(track=['#MiddleClassWithModi'])

