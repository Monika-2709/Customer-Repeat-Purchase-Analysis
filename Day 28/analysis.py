import pandas as pd

orders = pd.read_csv("orders.csv", parse_dates=["Order_Date"])

customer = orders.groupby("Customer_ID").agg(
    Orders=("Order_ID", "nunique"),
    Total_Sales=("Sales", "sum"),
    Total_Quantity=("Quantity", "sum"),
    First_Order=("Order_Date", "min"),
    Last_Order=("Order_Date", "max")
).reset_index()

customer["AOV"] = customer["Total_Sales"] / customer["Orders"]
customer["Repeat_Customer"] = customer["Orders"].ge(2).map({True:"Repeat", False:"First-time"})
customer["Segment"] = customer["Orders"].apply(
    lambda x: "One-time" if x == 1 else ("Repeat (2-3 orders)" if x <= 3 else "Loyal (4+ orders)")
)

repeat_rate = customer["Orders"].ge(2).mean() * 100
first_aov = customer.loc[customer["Orders"].eq(1), "AOV"].mean()
repeat_aov = customer.loc[customer["Orders"].ge(2), "AOV"].mean()

print(f"Repeat customer rate: {repeat_rate:.2f}%")
print(f"First-time AOV: {first_aov:.2f}")
print(f"Repeat customer AOV: {repeat_aov:.2f}")

segments = customer.groupby("Segment").agg(
    Customers=("Customer_ID","nunique"),
    Total_Sales=("Total_Sales","sum"),
    Avg_Orders=("Orders","mean"),
    Avg_AOV=("AOV","mean")
).reset_index()

segments.to_csv("segment_table_recreated.csv", index=False)
print(segments)