import pandas as pd
import sqlite3

# load cleaned dataset
df = pd.read_parquet("data/processed/clean_supply_chain.parquet")

# create database
conn = sqlite3.connect("database/supply_chain.db")

# write table
df.to_sql("supply_chain", conn, if_exists="replace", index=False)

conn.close()

print("Database created successfully.")