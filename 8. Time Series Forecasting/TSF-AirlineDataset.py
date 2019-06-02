"""
TIME SERIES FORECASTING
UNIVARIATE
"""

# Load necessary Libraries
import statsmodels.api as sm
import pandas as pd
import numpy as np
import itertools
import warnings
import seaborn as sns
import matplotlib.pyplot as plt

# Set default actions and sizes
warnings.filterwarnings("ignore")
plt.style.use("fivethirtyeight")
plt.rcParams['axes.labelsize'] = 14
plt.rcParams['xtick.labelsize'] = 12
plt.rcParams['ytick.labelsize'] = 12
plt.rcParams['text.color'] = 'k'

# Read the data file
data = pd.read_csv('airline.csv')

# Convert the date to DateTime object format in python
data['Month'] = pd.to_datetime(data['Month'])
data = data.set_index('Month')

# Plot the time-series
data.plot(figsize=(15,6))
plt.xlabel('Month')
plt.ylabel('Passengers')
plt.show()

"""
Positive Trend Observed
Seasonality Observed
"""

'''
METHOD 1 - Detecting a Trend in Data
'''

# Looking at the Rolling/Moving Average
plt.figure(figsize=(25,10))
passenger = data[['Passenger']]
moving_avg = passenger.rolling(12).mean()
moving_avg.plot(linewidth=5,fontsize=20)
plt.xlabel('Year',fontsize=20)
plt.ylabel('Average Passengers per year')
plt.title('Plotting Yearly Averages')
plt.legend()
plt.show()

# Looking at the Variations
data.reset_index(inplace=True)
data2 = data[['Month','Passenger']]

# YEARLY VARIATIONS
data2['Only_year'] = data2['Month'].dt.year
group_y = data2.groupby('Only_year')
yearly_aggregate = group_y.sum()
print(yearly_aggregate)
yearly_average = group_y.mean()
print(yearly_average)

plt.figure(figsize=(15,10))
plt.subplot(221)
plt.plot(yearly_aggregate)
plt.xlabel('Year')
plt.ylabel('Aggregate Passengers per year')
plt.subplot(222)
plt.plot(yearly_average)
plt.xlabel('Year')
plt.ylabel('Average Passengers per year')
plt.show()

# MONTHLY VARIATION
data2['Only_month'] = data2['Month'].dt.month
data2.boxplot(column='Passenger', by='Only_month', figsize=(15,10))
plt.title('Monthwise Passenger Variation')
plt.show()

# Decomposing the time-series into Train-Test 
train = passenger[0:120]
test = passenger[120:]
# Plotting Train-Test Dataset
train.Passenger.plot(figsize=(15,8), title='MonthlyPassenger', fontsize=14)
test.Passenger.plot(figsize=(15,8), title='MonthlyPassenger', fontsize=14)
plt.legend()
plt.show()

# FORECASTING
train_passengers = np.asarray(train.Passenger)
y_test_pred = test.copy()

# NAIVE FORECASTING
y_test_pred['naive'] = train_passengers[len(train_passengers)-1]
plt.figure(figsize=(12,8))
plt.plot(train.index, train['Passenger'],label='Train')
plt.plot(test.index, test['Passenger'],label='Test')
plt.plot(y_test_pred.index, y_test_pred['naive'], label='Naive Forecast')
plt.legend(loc='best')
plt.title('Naive Forecast')
plt.show()

# SIMPLE AVERAGE FORECASTING
y_test_pred['avg'] = train['Passenger'].mean()
plt.figure(figsize=(12,8))
plt.plot(train.index, train['Passenger'],label='Train')
plt.plot(test.index, test['Passenger'],label='Test')
plt.plot(y_test_pred.index, y_test_pred['avg'], label='Average Forecast')
plt.legend(loc='best')
plt.title('Simple Average Forecast')
plt.show()

# MOVING AVERAGE FORECASTING
y_test_pred['mov_avg'] = train['Passenger'].rolling(10).mean().iloc[-1]
plt.figure(figsize=(12,8))
plt.plot(train.index, train['Passenger'],label='Train')
plt.plot(test.index, test['Passenger'],label='Test')
plt.plot(y_test_pred.index, y_test_pred['mov_avg'], label='Moving Average Forecast')
plt.legend(loc='best')
plt.title('Moving Average Forecast')
plt.show()

# Compute the Root Mean square Error (RMSE)
from sklearn.metrics import mean_squared_error
from math import sqrt
print("\nERRORS\n")
rmse_naive = sqrt(mean_squared_error(test.Passenger,y_test_pred.naive))
print("RMSE using Naive Forecasting : ",rmse_naive)
rmse_avg = sqrt(mean_squared_error(test.Passenger,y_test_pred.avg))
print("RMSE using Simple Average Forecasting : ",rmse_avg)
rmse_mov_avg = sqrt(mean_squared_error(test.Passenger,y_test_pred.mov_avg))
print("RMSE using Moving Average Forecasting : ",rmse_mov_avg)

# MODEL FITTING

from statsmodels.tsa.api import ExponentialSmoothing, SimpleExpSmoothing, Holt
y_pred_avg = test.copy()

m1 = SimpleExpSmoothing(np.asarray(train['Passenger'])).fit(smoothing_level=0.6, optimized=False)
fitted =  SimpleExpSmoothing(train['Passenger']).fit(optimized=True)
y_pred_avg['SES'] = fitted.forecast(len(test))
plt.figure(figsize=(12,8))
plt.plot(train['Passenger'],label='Train')
plt.plot(test['Passenger'],label='Test')
plt.plot(y_pred_avg['SES'], label='Simple Exponential Smoothing')
plt.legend(loc='best')
plt.title('Simple Exponential Smoothing')
plt.show()

Alpha = print('Alpha:%s'%fitted.model.params['smoothing_level'])
Alpha = fitted.forecast(len(test)).rename(r'$\alpha=%s$'%fitted.model.params['smoothing_level'])

rmse_ses = sqrt(mean_squared_error(test.Passenger,y_pred_avg.SES))
print("RMSE using Simple Exponential Smoothing : ",rmse_ses)




















