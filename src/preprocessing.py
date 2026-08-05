import pandas as pd


def load_data(path):
    df = pd.read_csv(path, encoding="latin1")
    return df


def clean_data(df):

    # Remove duplicates
    df = df.drop_duplicates()

    # Convert dates
    df["order_date"] = pd.to_datetime(
        df["order date (DateOrders)"], errors="coerce"
    )

    df["shipping_date"] = pd.to_datetime(
        df["shipping date (DateOrders)"], errors="coerce"
    )

    # Create shipping delay
    df["shipping_delay"] = (
        df["Days for shipping (real)"] -
        df["Days for shipment (scheduled)"]
    )

    # Convert numeric columns
    df["Order Item Total"] = pd.to_numeric(
        df["Order Item Total"], errors="coerce"
    )

    # Fix zipcode
    if "Customer Zipcode" in df.columns:
        df["Customer Zipcode"] = df["Customer Zipcode"].astype(str)

    # Feature engineering
    df["order_month"] = df["order_date"].dt.to_period("M").astype(str)
    df["is_late"] = df["Late_delivery_risk"] == 1

    # Clean column names
    df.columns = (
        df.columns
        .str.strip()
        .str.lower()
        .str.replace(" ", "_")
        .str.replace("(", "", regex=False)
        .str.replace(")", "", regex=False)
    )

    # Drop old raw date columns
    df = df.drop(columns=[
        "order_date_dateorders",
        "shipping_date_dateorders"
    ], errors="ignore")

    return df


def save_processed(df, path):
    df.to_parquet(path, index=False)