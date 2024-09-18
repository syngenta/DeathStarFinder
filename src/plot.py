import pandas as pd
import matplotlib.pyplot as plt
import json
import numpy as np
from numpy.polynomial.polynomial import Polynomial

# Read the churn CSV file
churn_df = pd.read_csv('tmp/churn.csv', skiprows=3)

# Read the complexity JSON file
with open('tmp/complexity.json', 'r') as f:
    complexity_data = json.load(f)

# Extract relevant data from the JSON
complexity_list = []
for component in complexity_data['components']:
    file_path = component['path']
    complexity_value = int(component['measures'][0]['value'])
    complexity_list.append({'FILE NAME': file_path, 'COMPLEXITY': complexity_value})

complexity_df = pd.DataFrame(complexity_list)

# Merge the DataFrames on the file names
merged_df = pd.merge(churn_df, complexity_df, on='FILE NAME')

# Scatter plot
plt.figure(figsize=(10, 6))
plt.scatter(merged_df['LINES CHANGED'], merged_df['COMPLEXITY'], alpha=0.5, label='Data points')

# Annotate each point with the file name
for i, row in merged_df.iterrows():
    plt.annotate(row['FILE NAME'], (row['LINES CHANGED'], row['COMPLEXITY']), fontsize=8, alpha=0.7)

# Fit a polynomial regression model (degree 2 for example)
x = merged_df['LINES CHANGED']
y = merged_df['COMPLEXITY']
p = Polynomial.fit(x, y, 2)

# Generate predicted values
x_fit = np.linspace(x.min(), x.max(), 100)
y_fit = p(x_fit)

# Plot the regression curve
plt.plot(x_fit, y_fit, color='red', label='Polynomial fit (degree 2)')

# Add labels and title
plt.title('Complexity vs Churn')
plt.xlabel('Churn (Lines Changed)')
plt.ylabel('Complexity')
plt.grid(True)
plt.legend()

# Save the plot as an image file
plt.savefig('complexity_vs_churn_plot.png')

plt.show()



if __name__ == '__main__':
    pass