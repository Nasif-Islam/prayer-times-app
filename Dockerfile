# Base Image
# Use the official Python 3.11 slim image as the base
FROM python:3.11-slim

# Working Directory
# Set the working directory inside the container
WORKDIR /app
# All subsequent commands will run inside /app

# Install Dependencies
# Copy the requirements.txt file into the container
COPY backend/requirements.txt .
# Install Python packages listed in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt
# --no-cache-dir prevents pip from caching packages to reduce image size

# Copy Application Code
# Copy all the source code from the local app/ folder into /app in the container
COPY backend/ .

# Expose Port
# Expose port 5000 inside the container (where Flask runs)
EXPOSE 5000

# Run the Application
# Command to run when the container starts
CMD ["python", "main.py"]
# This starts your Flask app