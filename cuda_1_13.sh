#!/bin/bash

# CUDA 11.3 Installation Script for Ubuntu 20.04
# This script automates the installation of CUDA 11.3 on Ubuntu 20.04

# Exit immediately if a command exits with a non-zero status
set -e

# Function to print messages
print_message() {
    echo "$(tput setaf 2)$1$(tput sgr0)"
}

# Function to check if a command was successful
check_status() {
    if [ $? -eq 0 ]; then
        print_message "Success: $1"
    else
        echo "$(tput setaf 1)Error: $1 failed$(tput sgr0)"
        exit 1
    fi
}

# Uninstall existing NVIDIA drivers and CUDA
print_message "Uninstalling existing NVIDIA drivers and CUDA..."
sudo apt-get purge -y nvidia* cuda* libnvidia*
sudo apt-get autoremove -y && sudo apt-get autoclean
sudo rm -rf /usr/local/cuda*
check_status "Uninstallation of existing drivers and CUDA"

# Update package lists
print_message "Updating package lists..."
sudo apt-get update
check_status "Package list update"

# Install required packages
print_message "Installing required packages..."
sudo apt-get install -y g++ freeglut3-dev build-essential libx11-dev libxmu-dev libxi-dev libglu1-mesa libglu1-mesa-dev
check_status "Installation of required packages"

# Add NVIDIA PPA repository
print_message "Adding NVIDIA PPA repository..."
sudo add-apt-repository -y ppa:graphics-drivers/ppa
sudo apt-get update
check_status "Addition of NVIDIA PPA repository"

# Download and move CUDA repository pin
print_message "Setting up CUDA repository..."
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin
sudo mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600
check_status "CUDA repository setup"

# Add CUDA repository key and repository
print_message "Adding CUDA repository key and repository..."
sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/3bf863cc.pub
sudo add-apt-repository -y "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/ /"
sudo apt-get update
check_status "Addition of CUDA repository"

# Install CUDA 11.3
print_message "Installing CUDA 11.3..."
sudo apt-get install -y cuda-11-3
check_status "Installation of CUDA 11.3"

# Set up PATH and LD_LIBRARY_PATH
print_message "Setting up PATH and LD_LIBRARY_PATH..."
echo 'export PATH=/usr/local/cuda-11.3/bin:$PATH' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=/usr/local/cuda-11.3/lib64:$LD_LIBRARY_PATH' >> ~/.bashrc
source ~/.bashrc
check_status "PATH and LD_LIBRARY_PATH setup"

print_message "CUDA 11.3 installation completed successfully!"
print_message "Please reboot your system to complete the installation."
print_message "After reboot, run 'nvidia-smi' to verify the installation."
