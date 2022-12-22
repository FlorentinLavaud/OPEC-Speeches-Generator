# Let's first download the requiered packages 
import pandas as pd
import numpy as np
import datetime
import matplotlib.pyplot as plt
import seaborn as sns
#Import Excel files
df1 = pd.read_csv(r'C:\Users\flore\OneDrive\Bureau\DUBLIN\MSc\Dissertation\Data1.csv') 
new_df1_1 = df1.drop(labels='High', axis=1)
new_df1_2 = new_df1_1.drop(labels='Low', axis=1)
new_df1_3 = new_df1_2.drop(labels='Close', axis=1) 
new_df1 = new_df1_3.drop(labels='Volume', axis=1) 
new_df1.rename(columns = {'Local time' : 'Time', 'Open' : 'Brent'}, inplace = True)
print(new_df1)

df2 = pd.read_csv(r'C:\Users\flore\OneDrive\Bureau\DUBLIN\MSc\Dissertation\BRENT.CMDUSD_Candlestick_1_m_BID_01.01.2020-14.05.2022.csv') 
new_df2_1 = df2.drop(labels='High', axis=1)
new_df2_2 = new_df2_1.drop(labels='Low', axis=1)
new_df2_3 = new_df2_2.drop(labels='Close', axis=1) 
new_df2 = new_df2_3.drop(labels='Volume', axis=1) 
new_df2.rename(columns = {'Local time' : 'Time', 'Open' : 'Brent'}, inplace = True)
print(new_df2)

df3 = pd.read_csv(r'C:\Users\flore\OneDrive\Bureau\DUBLIN\MSc\Dissertation\BRENT.CMDUSD_Candlestick_1_m_BID_01.01.2017-02.01.2020.csv') 
new_df3_1 = df3.drop(labels='High', axis=1)
new_df3_2 = new_df3_1.drop(labels='Low', axis=1)
new_df3_3 = new_df3_2.drop(labels='Close', axis=1) 
new_df3 = new_df3_3.drop(labels='Volume', axis=1) 
new_df3.rename(columns = {'Local time' : 'Time', 'Open' : 'Brent'}, inplace = True)
print(new_df3)

# Merge Excel files 
df_1_3 = new_df1.append(new_df3)
df = df_1_3.append(new_df2)
print(df)


# Save the merged excel in the directory 
df.to_csv(r'C:\Users\flore\OneDrive\Bureau\DUBLIN\MSc\Dissertation\Merged_Data.csv', index = False, date_format = '%Y%m%d%m /// "%H:%M:%S')
# This is the final dataset, containing the min-by-minute oil price from 2015 until today
#df_ts.plot(style='k--')
df_ts = pd.read_csv(r'C:\Users\flore\OneDrive\Bureau\DUBLIN\MSc\Dissertation\Oil_market_intraday_data.csv') 
# Setting as time-series 
df_ts['Time'] =df_ts.Time.str.slice(0, 19)
df_ts['Time'] = pd.to_datetime(df_ts['Time'], format="%d.%m.%Y %H:%M:%S", errors='coerce')
# Calculating the rolling variance
df_ts = df_ts.assign(variance = df_ts.rolling(window=60).mean())
# Creare the lagged value of variance 
df_ts['LaggedVariance'] = df_ts['variance'].shift(-1)

# All we have to do now is to extract this variance for specific dates
# E.g. we want to extract row 3877860 - 3879299 (14/05/2022)
display(df_ts.iloc[3877860:3879299])
df_test = df_ts.iloc[3877860:3879299]

D1="18/01/2017 07:25"
D2="13/02/2017 08:35"
D3="14/03/2017 07:20"
D4="12/04/2017 06:30"
D5="11/05/2017 06:30"
D6="13/06/2017 06:20"
D7="12/07/2017 06:35"
D8="10/08/2017 06:15"
D9="12/09/2017 07:10"
D10="11/10/2017 06:30"
D11="13/11/2017 07:20"
D12="13/12/2017 07:50"
D13="18/01/2018 07:30"
D14="12/02/2018 06:50"
D15="14/03/2018 06:50"
D16="12/04/2018 06:50"
D17="14/05/2018 06:15"
D18="12/06/2018 06:45"
D19="11/07/2018 06:20"
D20="13/08/2018 07:25"
D21="12/09/2018 06:40"
D22="11/10/2018 06:50"
D23="13/11/2018 06:50"
D24="12/12/2018 06:50"
D25="17/01/2019 06:30"
D26="12/02/2019 06:30"
D27="14/03/2019 06:30"
D28="10/04/2019 06:30"
D29="14/05/2019 06:30"
D30="13/06/2019 06:30"
D31="11/07/2019 06:30"
D32="16/08/2019 06:30"
D33="11/09/2019 06:30"
D34="10/10/2019 06:30"
D35="14/11/2019 06:30"
D36="11/12/2019 06:30"
D37="15/01/2020 06:30"
D38="12/02/2020 07:30"
D39="11/03/2020 06:30"
D40="16/04/2020 06:30"
D41="13/05/2020 06:30"
D42="17/06/2020 06:30"
D43="14/07/2020 06:30"
D44="12/08/2020 06:30"
D45="14/09/2020 06:30"
D46="13/10/2020 06:30"
D47="11/11/2020 06:30"
D48="14/12/2020 06:30"
D49="14/01/2021 07:30"
D50="11/02/2021 07:30"
D51="11/03/2021 06:30"
D52="13/04/2021 06:30"
D53="11/05/2021 07:30"
D54="11/05/2021 06:30"
D55="10/06/2021 06:30"
D56="15/07/2021 06:30"
D57="12/08/2021 06:30"
D58="13/09/2021 06:30"
D59="13/10/2021 06:30"
D60="11/11/2021 07:30"
D61="13/12/2021 07:30"
F1="18 01 2017 07:55"
F2="13 02 2017 08:05"
F3="14 03 2017 07:50"
F4="12 04 2017 07:00"
F5="11 05 2017 07:00"
F6="13 06 2017 06:50"
F7="12 07 2017 07:05"
F8="10 08 2017 06:45"
F9="12 09 2017 07:40"
F10="11 10 2017 06:30"
F11="13 11 2017 06:20"
F12="13 12 2017 07:50"
F13="18 01 2018 07:30"
F14="12 02 2018 06:50"
F15="14 03 2018 06:50"
F16="12 04 2018 06:50"
F17="14 05 2018 06:15"
F18="12 06 2018 06:45"
F19="11 07 2018 06:20"
F20="13 08 2018 07:25"
F21="12 09 2018 06:40"
F22="11 10 2018 06:50"
F23="13 11 2018 06:50"
F24="12 12 2018 06:50"
F25="17 01 2019 06:30"
F26="12 02 2019 06:30"
F27="14 03 2019 06:30"
F28="10 04 2019 06:30"
F29="14 05 2019 06:30"
F30="13 06 2019 06:30"
F31="11 07 2019 06:30"
F32="16 08 2019 06:30"
F33="11 09 2019 06:30"
F34="10 10 2019 06:30"
F35="14 11 2019 06:30"
F36="11 12 2019 06:30"
F37="15 01 2020 06:30"
F38="12 02 2020 07:30"
F39="11 03 2020 06:30"
F40="16 04 2020 06:30"
F41="13 05 2020 06:30"
F42="17 06 2020 06:30"
F43="14 07 2020 06:30"
F44="12 08 2020 06:30"
F45="14 09 2020 06:30"
F46="13 10 2020 06:30"
F47="11 11 2020 06:30"
F48="14 12 2020 06:30"
F49="14 01 2021 07:30"
F50="11 02 2021 07:30"
F51="11 03 2021 06:30"
F52="13 04 2021 06:30"
F53="11 05 2021 07:30"
F54="11 05 2021 06:30"
F55="10 06 2021 06:30"
F56="15 07 2021 06:30"
F57="12 08 2021 06:30"
F58="13 09 2021 06:30"
F59="13 10 2021 06:30"
F60="11 11 2021 07:30"
F61="13 12 2021 07:30"
# First we want to sum up the squared value of the one-minute returns over an event window +/- 30min
Test = df_ts[df_ts.Time.between(D61, F61)]
Test['RV'] = (np.log(Test['variance']) - np.log(Test['LaggedVariance']))*(np.log(Test['variance']) - np.log(Test['LaggedVariance']))
Result = Test["RV"].sum()
Result # This is the RV variance
# Let's now get the results for all speeches 

###Statistics & Vizualisation###

df_ts["Brent"].describe()

# Simple plot
plt.plot(df_ts["Brent"], marker=',')
# Labelling 
plt.xlabel("Time")
plt.ylabel("Brent price")
plt.title("Oil prices between 2017 - 2022")
plt.show()

# Kernel distribution:
sns.distplot(df_ts["Brent"] , color="dodgerblue", axlabel='Frequency')

# matplotlib histogram:
plt.hist(df_ts["Brent"], color = 'blue', edgecolor = 'black',
         bins = int(180/5))

# seaborn histogram
sns.distplot(df_ts["Brent"], hist=True, kde=False, 
             bins=int(180/5), color = 'blue',
             hist_kws={'edgecolor':'black'})

df = pd.DataFrame(df_ts["Brent"], columns=list('ABCD'))
ax = df.plot.box()

df_ts.boxplot(by ='Time', column =['Brent'], grid = False)
