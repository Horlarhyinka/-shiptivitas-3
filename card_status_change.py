import pandas as pd
import matplotlib.pyplot as plt
from Engine import engine

query_cards = 'SELECT cardID, COUNT(*) AS num_status_change FROM card_change_history where oldStatus != newStatus GROUP BY cardID ORDER BY cardID;'
df_cards = pd.read_sql_query(query_cards, engine)

df_cards.rename(columns={'cardID': 'cardID', 'num_status_change': 'num_status_change'}, inplace=True)

card_id_array = df_cards['cardID'].values
status_change_array = df_cards['num_status_change'].values

plt.figure(figsize=(10, 6))
plt.plot(card_id_array, status_change_array, label='Status change by cards')
plt.title('status change by cards')
plt.xlabel('card ID')
plt.ylabel('number of status change')
plt.legend()
plt.show()
