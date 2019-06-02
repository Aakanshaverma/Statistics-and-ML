##### TIME SERIES FORECASTING

# Load necessary Libraries
import statsmodels.api as sm
import pandas as pd
import numpy as np
import itertools
import warnings
import seaborn as sns
import matplotlib.pyplot as plt
import matplotlib
warnings.filterwarnings("ignore")
from sklearn.metrics import mean_squared_error
from math import sqrt

# Predefine plotting styles
plt.style.use("fivethirtyeight")
matplotlib.rcParams['axes.labelsize']=14
matplotlib.rcParams['xtick.labelsize']=12
matplotlib.rcParams['ytick.labelsize']=12
matplotlib.rcParams['text.color']='k'

# Read the data files
df = pd.read_csv("ES-Data.csv")
df.head()

df = df.set_index('Period')
# Plot the time-series
df.plot(figsize=(12,5))
plt.xlabel('Period')
plt.ylabel('Calls Received')
plt.show()
# Inference: No Trend, No Seasonality

from statsmodels.tsa.api import ExponentialSmoothing, SimpleExpSmoothing, Holt
y_pred_avg = df.copy()

# SIMPLE EXPONENTIAL SMOOTHING
# m1 = SimpleExpSmoothing(np.asarray(df['Calls Received'])).fit(smoothing_level=0.6, optimized=False)
fitted =  SimpleExpSmoothing(df['Calls Received']).fit(optimized=True)
fitted.forecast(1)
y_pred_avg['SES'] = fitted.forecast(len(df))
plt.figure(figsize=(12,8))
plt.plot(df['Calls Received'],label='DF')
plt.plot(y_pred_avg['SES'], label='Simple Exponential Smoothing')
plt.legend(loc='best')
plt.title('Simple Exponential Smoothing')
plt.show()
# ALPHA
Alpha = print('Alpha : ',fitted.model.params['smoothing_level'])
Alpha = fitted.forecast(len(df)).rename(r'$\alpha=%s$'%fitted.model.params['smoothing_level'])
# ERROR
rmse_ses = sqrt(mean_squared_error(df['Calls Received'],y_pred_avg.SES))
print("RMSE using Simple Exponential Smoothing : ",rmse_ses)