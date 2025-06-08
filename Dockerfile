# Use official Python image
FROM python:3.12-slim

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y netcat-openbsd gcc libpq-dev && apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy app files
COPY . .

# Install Python dependencies
RUN pip install --upgrade pip && pip install -r requirements.txt

# Collect static files (if using WhiteNoise)
RUN python manage.py collectstatic --noinput

# Expose port Django will run on
EXPOSE 8000

# Start Django app with production server
CMD ["gunicorn", "gettingstarted.wsgi:application", "--bind", "0.0.0.0:8000"]
