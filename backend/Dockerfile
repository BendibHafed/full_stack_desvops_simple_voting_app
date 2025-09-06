FROM python:3.12-slim

# Do not write .pyc files; show output immediately
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /application

# Install Python dependencies
COPY backend/requirements.txt ./backend/requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy backend and frontend into the image
# (Flask app serves templates/static from ../frontend)
COPY backend/ ./backend
COPY frontend/ ./frontend/

# Expose the app port (for documentation)
EXPOSE 5000

# Default command (Compose will override with the same gunicorn command)
CMD ["gunicorn", "-w", "4", "-b", "0.0.0.0:5000", "backend.run:app"]
