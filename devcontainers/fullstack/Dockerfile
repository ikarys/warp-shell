FROM mcr.microsoft.com/devcontainers/base:ubuntu

# Install Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs

# Install Python
RUN apt-get update && apt-get install -y \
    python3.12 \
    python3-pip \
    python3-venv

# Set default Python
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.12 1

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/*
