#The second task is to write a ETL or ELT pipeline that is taking the data from the GCS bucket and 
#that is processing the data and calculating the revenue per day. This can be done in the Google Cloud 
#or on your local machine.

import pyarrow.parquet as pq
from time import time
from sqlalchemy import create_engine

# if the table already exists, we need to drop it first
green_taxi = pd.read_parquet('data/green_tripdata_2021-01.parquet')
green_taxi.head(n=0).to_sql(name='green_taxi', con=engine, if_exists='replace')

parquet_file = pq.ParquetFile('data/green_tripdata_2021-01.parquet')

for batch in parquet_file.iter_batches(batch_size=100000):
    start_time = time()
    batch_df = batch.to_pandas()
    batch_df.to_sql('green_taxi', engine, if_exists='append', index=False)
    end_time = time()
    
    print('Batch time: ', end_time - start_time)
else:
    print("All batches processed!")