import seaborn as sns
import pandas as pd
import matplotlib.pyplot as plt

def forward_chaining_viz(df_copy, df_cutoff_horizon):
    for i, (cutoff, horizon) in enumerate(df_cutoff_horizon.iterrows()):
      horizon_cutoff = horizon['ds']

      df_copy['type'] = df_copy['ds'].apply(
          lambda date: 'train' if date < cutoff else 
                       'test' if date < horizon_cutoff else 'unseen')

      plt.figure(figsize=(10, 5))
      sns.scatterplot(x='ds', y='y', hue='type', s=5,
                      palette=['black', 'red', 'gray'],
                      data=df_copy)
      plt.axvline(x=cutoff, color='gray', label='cutoff')
      plt.axvline(x=horizon_cutoff, color='gray', ls='--', label='horizon')
      plt.legend(bbox_to_anchor=(1, 1), loc='upper left')
      plt.title(f"FOLD {i+1}\nTRAIN SIZE: {df_copy['type'].value_counts()['train']} DAYS")
      plt.show()