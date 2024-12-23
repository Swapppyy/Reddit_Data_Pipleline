# Use the specified Airflow image version
FROM apache/airflow:2.7.1-python3.9

# Copy requirements.txt first to leverage Docker cache for pip install
COPY requirements.txt /opt/airflow/

# Switch to root user to install system dependencies
USER root

# Install system dependencies and clean up to reduce image size
RUN apt-get update && apt-get install -y gcc python3-dev libpq-dev && apt-get clean

# Switch back to airflow user for running Airflow
USER airflow

# Install Python dependencies from the requirements.txt file
RUN pip install --no-cache-dir -r /opt/airflow/requirements.txt
