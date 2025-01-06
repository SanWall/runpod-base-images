#!/usr/bin/env bash

#!/usr/bin/env bash
set -e  # Exit immediately if a command exits with a non-zero status

# Update package list and install gnupg if not already installed
apt-get update && apt-get install -y gnupg wget
echo "   >>>>>> Installed gnupg and wget"

# Add NVIDIA GPG key to avoid signature issues
if ! apt-key list | grep -q "NVIDIA CORPORATION"; then
    echo "Adding NVIDIA GPG key..."
    wget -qO- https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/3bf863cc.pub | apt-key add -
else
    echo "NVIDIA GPG key already added."
fi

# Fix Ubuntu repository keys
if ! apt-key list | grep -q "Ubuntu Archive Automatic Signing Key"; then
    echo "Fixing Ubuntu repository keys..."
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3B4FE6ACC0B21F32
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 871920D1991BC93C
else
    echo "Ubuntu keys already added."
fi

# Update and upgrade packages
apt-get update && apt-get -y upgrade
echo "   >>>>>> Updated and upgraded packages"



# apt update
# apt -y upgrade
apt install -y --no-install-recommends \
    build-essential \
    software-properties-common \
    python3-pip \
    nodejs \
    npm \
    bash \
    dos2unix \
    git \
    git-lfs \
    ncdu \
    nginx \
    net-tools \
    dnsutils \
    inetutils-ping \
    openssh-server \
    libglib2.0-0 \
    libsm6 \
    libgl1 \
    libxrender1 \
    libxext6 \
    ffmpeg \
    wget \
    curl \
    psmisc \
    rsync \
    vim \
    nano \
    zip \
    unzip \
    p7zip-full \
    htop \
    screen \
    tmux \
    bc \
    aria2 \
    cron \
    pkg-config \
    plocate \
    parallel \
    pv \
    sysstat \
    pigz \
    lz4 \
    zstd \
    cpio \
    jq \
    libcairo2-dev \
    libgoogle-perftools4 \
    libtcmalloc-minimal4 \
    apt-transport-https \
    ca-certificates

if [ -n "${PYTHON_VERSION}" ]; then
    # Install Python from deadsnakes PPA
    add-apt-repository ppa:deadsnakes/ppa
    apt install -y --no-install-recommends \
        "python${PYTHON_VERSION}" \
        "python${PYTHON_VERSION}-dev" \
        "python${PYTHON_VERSION}-venv" \
        "python${PYTHON_VERSION}-tk"

    # Link Python
    # rm /usr/bin/python
    # ln -s /usr/bin/python${PYTHON_VERSION} /usr/bin/python
    # rm /usr/bin/python3
    # ln -s /usr/bin/python${PYTHON_VERSION} /usr/bin/python3

    # Link Python
    if [ -f /usr/bin/python ]; then
        rm /usr/bin/python
    fi
    ln -sf /usr/bin/python${PYTHON_VERSION} /usr/bin/python

    if [ -f /usr/bin/python3 ]; then
        rm /usr/bin/python3
    fi
    ln -sf /usr/bin/python${PYTHON_VERSION} /usr/bin/python3

    # Upgrade pip
    pip3 install --upgrade --no-cache-dir pip
fi

update-ca-certificates
apt clean
rm -rf /var/lib/apt/lists/*
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
