import pandas as pd
import numpy as np
from prophet import Prophet
from sklearn.metrics import mean_absolute_error, mean_squared_error

np.random.seed(42)
# PREPARE DATA

def prepare_demand_data(df):
    df["order_date"] = pd.to_datetime(df["order_date"])

    # Weekly aggregation
    demand = df.groupby(
        pd.Grouper(key="order_date", freq="W")
    )["order_item_quantity"].sum().reset_index()

    demand.columns = ["ds", "y"]

    weekly_counts = df.groupby(
        pd.Grouper(key="order_date", freq="W")
    ).size().reset_index(name="count")

    threshold = weekly_counts["count"].quantile(0.25)
    valid_weeks = weekly_counts[weekly_counts["count"] > threshold]["order_date"]

    demand = demand[demand["ds"].isin(valid_weeks)].reset_index(drop=True)
    
    demand["y"] = demand["y"].rolling(window=3, center=True).mean()
    demand = demand.dropna().reset_index(drop=True)
    # Data sufficiency check
    if len(demand) < 30:
        raise ValueError(
        f"Not enough weekly data after filtering: only {len(demand)} weeks available."
    )

    return demand


# TRAIN/TEST SPLIT

def train_test_split(demand_df, test_weeks=13):
    if len(demand_df) <= test_weeks:
        raise ValueError("Not enough data for the requested test split.")

    train = demand_df[:-test_weeks]
    test = demand_df[-test_weeks:]
    return train, test


# TRAIN MODEL

def train_forecast_model(train_df):

    # Auto-select seasonality mode
    if train_df["y"].min() <= 0:
        mode = "additive"
    else:
        mode = "multiplicative"

    model = Prophet(
        yearly_seasonality=True,
        weekly_seasonality=False,
        daily_seasonality=False,
        seasonality_mode=mode,
        interval_width=0.75,
        changepoint_prior_scale=0.03,
        seasonality_prior_scale=5
    )

    model.add_seasonality(
        name='monthly',
        period=30.5,
        fourier_order=4
    )

    model.add_seasonality(
        name='quarterly',
        period=91.25,
        fourier_order=4
    )

    model.fit(train_df)

    return model


# PREDICT

def predict_future(model, periods=13, freq="W", only_future=False):
    future = model.make_future_dataframe(periods=periods, freq=freq)
    forecast = model.predict(future)

    if only_future:
        forecast = forecast.tail(periods)

    return forecast


# EVALUATE
def evaluate_forecast(forecast, test_df):
    merged = pd.merge(
        test_df,
        forecast[["ds", "yhat", "yhat_lower", "yhat_upper"]],
        on="ds",
        how="left"
    )

    if merged.empty:
        raise ValueError(
            "No matching dates between forecast and test set. "
            "Check that forecast freq matches the weekly test data."
        )
    
    merged = merged.dropna()
    if len(merged) == 0:
        raise ValueError("All merged rows became NaN after alignment.")

    mae = mean_absolute_error(merged["y"], merged["yhat"])
    rmse = np.sqrt(mean_squared_error(merged["y"], merged["yhat"]))

    return mae, rmse, merged 