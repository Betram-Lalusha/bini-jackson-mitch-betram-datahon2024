import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from matplotlib import ticker

def load_data(file_path):
    return pd.read_csv(file_path)

def aggregate_data(data):
    women_owned = data[data['woman_owned_business'] == 't']
    minority_owned = data[data['minority_owned_business'] == 't']
    return data, women_owned, minority_owned

def plot_average_values(data, women_owned, minority_owned, title_suffix):
    # Aggregate average current total value of awards by NAICS description
    naics_avg_all = data.groupby('naics_description')['current_total_value_of_award'].mean().sort_values(ascending=False).head(10)
    naics_avg_women = women_owned.groupby('naics_description')['current_total_value_of_award'].mean().sort_values(ascending=False).head(10)
    naics_avg_minority = minority_owned.groupby('naics_description')['current_total_value_of_award'].mean().sort_values(ascending=False).head(10)
    
    plot_visuals(naics_avg_all, naics_avg_women, naics_avg_minority, 'Average Current Total Value (' + title_suffix + ')')

def plot_total_numbers(data, women_owned, minority_owned, title_suffix):
    # Aggregate total number of contracts by NAICS description
    naics_count_all = data['naics_description'].value_counts().head(10)
    naics_count_women = women_owned['naics_description'].value_counts().head(10)
    naics_count_minority = minority_owned['naics_description'].value_counts().head(10)
    
    plot_visuals(naics_count_all, naics_count_women, naics_count_minority, 'Total Number of Contracts (' + title_suffix + ')')

def plot_total_values(data, women_owned, minority_owned, title_suffix):
    # Aggregate total current value of awards by NAICS description
    naics_value_all = data.groupby('naics_description')['current_total_value_of_award'].sum().sort_values(ascending=False).head(10)
    naics_value_women = women_owned.groupby('naics_description')['current_total_value_of_award'].sum().sort_values(ascending=False).head(10)
    naics_value_minority = minority_owned.groupby('naics_description')['current_total_value_of_award'].sum().sort_values(ascending=False).head(10)
    
    plot_visuals(naics_value_all, naics_value_women, naics_value_minority, 'Total Current Value of Awards (' + title_suffix + ')')

def plot_visuals(data_all, data_women, data_minority, title):
    plt.figure(figsize=(14, 10))
    
    formatter = ticker.StrMethodFormatter('${x:,.0f}') # Dollar sign, comma separator, no decimal places

    # Plot for all contracts
    plt.subplot(3, 1, 1)
    sns.barplot(x=data_all.values, y=data_all.index)
    plt.gca().xaxis.set_major_formatter(formatter) # Apply the formatter to the current axis
    plt.title('Top 10 NAICS Descriptions by ' + title + ' - All Contracts')
    plt.xlabel(title)
    plt.ylabel('NAICS Description')
    
    # Plot for women-owned businesses
    plt.subplot(3, 1, 2)
    sns.barplot(x=data_women.values, y=data_women.index)
    plt.gca().xaxis.set_major_formatter(formatter) # Apply the formatter to the current axis
    plt.title('Top 10 NAICS Descriptions by ' + title + ' - Women-Owned Businesses')
    plt.xlabel(title)
    plt.ylabel('NAICS Description')
    
    # Plot for minority-owned businesses
    plt.subplot(3, 1, 3)
    sns.barplot(x=data_minority.values, y=data_minority.index)
    plt.gca().xaxis.set_major_formatter(formatter) # Apply the formatter to the current axis
    plt.title('Top 10 NAICS Descriptions by ' + title + ' - Minority-Owned Businesses')
    plt.xlabel(title)
    plt.ylabel('NAICS Description')
    
    plt.tight_layout()
    plt.show()


if __name__ == '__main__':
    # Adjust the file path as necessary
    file_path = 'data/cleanedData_2023.csv'
    data = load_data(file_path)
    data, women_owned, minority_owned = aggregate_data(data)
    
    # Plot the average, total numbers, and total values
    plot_average_values(data, women_owned, minority_owned, '2023')
    plot_total_numbers(data, women_owned, minority_owned, '2023')
    plot_total_values(data, women_owned, minority_owned, '2023')