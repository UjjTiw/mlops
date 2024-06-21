FROM python:3.8-slim-buster

# Switch to root user
USER root

# Create the /app directory
RUN mkdir /app

# Copy the current directory contents into the /app directory
COPY . /app/

# Set the working directory to /app
WORKDIR /app/

# Install build tools and dependencies
RUN apt-get update && \
    apt-get install -y gcc build-essential python3-dev

# Install Python dependencies
RUN pip3 install -r requirements_dev.txt

# Set environment variables
ENV AIRFLOW_HOME='/app/airflow'
ENV AIRFLOW_CORE_DAGBAG_IMPORT_TIMEOUT=1000
ENV AIRFLOW_CORE_ENABLE_XCOM_PICKLING=True

# Initialize the Airflow database
RUN airflow db init

# Create an Airflow user
RUN airflow users create -e ujjwaltiwari2004razor@gmail.com -f Ujjwal -l Tiwari -p admin -r Admin -u admin

# Make the start.sh script executable
RUN chmod 777 start.sh

# Update package lists
RUN apt-get update -y

# Set the entrypoint to /bin/sh
ENTRYPOINT [ "/bin/sh" ]

# Set the default command to run start.sh
CMD ["start.sh"]
