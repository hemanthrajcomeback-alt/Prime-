FROM python:3.12.3-slim-buster

WORKDIR /usr/src/app

# Install system dependencies
RUN apt-get update -qq && apt-get install -y --no-install-recommends \
    git wget pv jq python3-dev mediainfo gcc aria2 \
    libsm6 libxext6 libfontconfig1 libxrender1 libgl1-mesa-glx ffmpeg \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy application files
COPY . .

# Install Python dependencies
RUN python3 -m pip install --upgrade pip \
    && python3 -m pip install --no-cache-dir -r requirements.txt

# Ensure the run script is executable
RUN chmod +x run.sh

# Default command
CMD ["bash", "run.sh"]
