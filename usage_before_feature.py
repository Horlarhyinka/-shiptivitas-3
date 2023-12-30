import pandas as pd
import matplotlib.pyplot as plt
from Engine import engine

query_users = 'SELECT DATE(FROM_UNIXTIME(login_timestamp)) AS date, COUNT(*) AS no_of_logins FROM login_history where date(from_unixtime(login_timestamp)) between "2018-02-03" and "2018-06-02" GROUP BY date ;'
df_users = pd.read_sql_query(query_users, engine)

df_users.rename(columns={'date': 'date', 'no_of_logins': 'daily_users'}, inplace=True)

date_array = df_users['date'].values
daily_users_array = df_users['daily_users'].values

plt.figure(figsize=(10, 6))
plt.plot(date_array, daily_users_array, label='Daily Average Users')
plt.title('Daily Average Users Before Feature')
plt.xlabel('Date')
plt.ylabel('Daily Average Users')
plt.legend()
plt.show()
