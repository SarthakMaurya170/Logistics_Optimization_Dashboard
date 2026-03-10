import pandas as pd
import numpy as np
from datetime import datetime, timedelta
import random

# 1. Setup the parameters
num_records = 5000
warehouse_ids = [1, 2, 3, 4, 5, 6] # Assuming 6 warehouses
partners = ['Delhivery', 'BlueDart', 'PharmEasy Fleet', 'Shadowfax']

# 2. Generate Base Data
data = {
    'ShipmentID': range(10000, 10000 + num_records),
    'WarehouseID': np.random.choice(warehouse_ids, num_records),
    'DeliveryPartner': np.random.choice(partners, num_records, p=[0.3, 0.3, 0.25, 0.15]),
    'OrderValue_INR': np.random.randint(200, 5000, num_records)
}

df = pd.DataFrame(data)

# 3. Generate Realistic Dates (spanning the last 6 months)
start_date = datetime(2025, 9, 1)
df['OrderDate'] = [start_date + timedelta(days=random.randint(0, 180)) for _ in range(num_records)]

# Promised delivery is usually 1-3 days after order
df['PromisedDeliveryDate'] = df['OrderDate'] + pd.to_timedelta(np.random.randint(1, 4, num_records), unit='D')

# 4. Create realistic Delivery Statuses & Actual Dates
# Let's say 80% are On Time, 15% Delayed, 5% In Transit
def calculate_actual_delivery(row):
    status_roll = random.random()
    
    if status_roll < 0.80:
        # Delivered On Time
        actual_date = row['OrderDate'] + timedelta(days=random.randint(1, (row['PromisedDeliveryDate'] - row['OrderDate']).days))
        return actual_date, 'Delivered'
    elif status_roll < 0.95:
        # Delayed (1 to 5 days late)
        actual_date = row['PromisedDeliveryDate'] + timedelta(days=random.randint(1, 5))
        return actual_date, 'Delayed'
    else:
        # In Transit (no actual delivery date yet)
        return pd.NaT, 'In Transit'

# Apply the logic
df[['ActualDeliveryDate', 'DeliveryStatus']] = df.apply(calculate_actual_delivery, axis=1, result_type='expand')

# 5. Export to CSV
df.to_csv('Massive_Shipments_Data.csv', index=False)
print("Successfully generated 5,000 shipment records!")