# Use the official Python image as the base image
FROM python:3.10-slim-buster


RUN apt-get update 

# Set the working directory
WORKDIR /app

# Copy the application code to the working directory
COPY dbt-intro/dbt_intro/ /app
# Copy the 
COPY dbt-intro/dbt-intro-prod/ /root/.dbt/

# Install the dependencies
RUN pip install --no-cache-dir dbt-postgres

# Entrypoint of the image
ENTRYPOINT [ "dbt" ]