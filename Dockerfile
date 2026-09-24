FROM python:3.11-slim

WORKDIR /app

# Fix apt sources + install only needed packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    gcc \
    libffi-dev \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

COPY . .

# Flask + Bot dono ek saath
CMD sh -c "gunicorn app:app --bind 0.0.0.0:$PORT & python -m Extractor"
