import pandas as pd
import matplotlib.pyplot as plt
from scipy.interpolate import make_interp_spline
from matplotlib import dates as mdates
import numpy as np
from Engine import engine

# Query 1
query_users_1 = 'SELECT DATE(FROM_UNIXTIME(login_timestamp)) AS date, COUNT(*) AS no_of_logins FROM login_history where date(from_unixtime(login_timestamp)) between "2018-02-03" and "2018-06-02" GROUP BY date ;'
df_users_1 = pd.read_sql_query(query_users_1, engine)
df_users_1.rename(columns={'date': 'date', 'no_of_logins': 'daily_users'}, inplace=True)
date_array_1 = df_users_1['date'].values
daily_users_array_1 = df_users_1['daily_users'].values

# Query 2
query_users_2 = 'SELECT DATE(FROM_UNIXTIME(login_timestamp)) AS date, COUNT(*) AS no_of_logins FROM login_history where date(from_unixtime(login_timestamp)) between "2018-06-02" and "2019-02-02" GROUP BY date ;'
df_users_2 = pd.read_sql_query(query_users_2, engine)
df_users_2.rename(columns={'date': 'date', 'no_of_logins': 'daily_users'}, inplace=True)
date_array_2 = df_users_2['date'].values
daily_users_array_2 = df_users_2['daily_users'].values

# Convert date values to ordinal numbers
ordinal_dates_1 = mdates.date2num(date_array_1)
ordinal_dates_2 = mdates.date2num(date_array_2)

# Smooth the data using spline interpolation
x_smooth_1 = np.linspace(ordinal_dates_1.min(), ordinal_dates_1.max(), 300)
y_smooth_1 = make_interp_spline(ordinal_dates_1, daily_users_array_1)(x_smooth_1)

x_smooth_2 = np.linspace(ordinal_dates_2.min(), ordinal_dates_2.max(), 300)
y_smooth_2 = make_interp_spline(ordinal_dates_2, daily_users_array_2)(x_smooth_2)

# Combine the data and plot
plt.figure(figsize=(12, 8))

plt.plot(mdates.num2date(x_smooth_1), y_smooth_1, label='Before Feature', color='blue')
plt.plot(mdates.num2date(x_smooth_2), y_smooth_2, label='After Feature', color='orange')

plt.title('Daily Average Users Before and After Feature')
plt.xlabel('Date')
plt.ylabel('Daily Average Users')
plt.legend()
plt.grid(True)
plt.xticks(rotation=45)
plt.tight_layout()
plt.show()
