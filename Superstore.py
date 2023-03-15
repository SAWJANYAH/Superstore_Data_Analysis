import pandas as pd

# Read CSV file
df = pd.read_csv("superstore_final_dataset.csv")
print(f"original - {df.count()}")      

# Removing Rows whose few values are Missing 
df2 = df.dropna()

df2.to_csv("superstore_clean.csv")

print(f"After removing Null values - {df2.count()}")
df3 = df2[df2["Ship_Date"] >= df2["Order_Date"]]

df3.to_csv("processed_superstore.csv",index=False)
print(f"after ship date validation - {df3.count()}")

