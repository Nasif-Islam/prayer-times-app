# --- Base Image ---
# Use a lightweight Python image for smaller, faster builds
FROM python:3.11-slim

# --- Environment Variables ---
# Prevent Python from buffering stdout/stderr and set Flask to production
ENV PYTHONUNBUFFERED=1
ENV FLASK_ENV=production

# --- Working Directory ---
WORKDIR /app

# --- Install Dependencies ---
# Copy the backend requirements file first for efficient layer caching
COPY backend/requirements.txt .
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# --- Copy Application Code ---
COPY backend/ .

# --- Security: Create a non-root user ---
RUN adduser --disabled-password appuser
USER appuser

# --- Expose Port ---
# Matches the Flask app running on port 8000
EXPOSE 8000

# --- Run the Flask Application ---
CMD ["python", "main.py"]
