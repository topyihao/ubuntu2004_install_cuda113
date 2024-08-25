# this is a instruction of install cuda 11.3 on ubuntu 20.04
# remove all the previous installed nvidia drivers and cuda 
# From cuda 11.4 onwards, an uninstaller script has been provided. Use it for the uninstallation:

# To uninstall cuda
sudo /usr/local/cuda-11.4/bin/cuda-uninstaller 
# To uninstall nvidia
sudo /usr/bin/nvidia-uninstall

# Go to the line containing reference to Nvidia repo and comment it by appending # in front of the line, for e.g.:
#deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/ /
# Then run

sudo apt-get remove --purge "^nvidia-*" "^libnvidia-*" "*cublas*" "cuda*" "nsight*" "*nvidia*"
sudo apt-get autoremove && sudo apt-get autoclean
sudo rm /etc/apt/sources.list.d/cuda*
sudo rm -rf /usr/local/cuda*

sudo apt-get update


# install cuda 11.3
# I find that install nvidia first cannot install cuda correctly (Don't know why), could because multiple nvidia driver cause conflict
# just install cuda as following: 

sudo apt-get install g++ freeglut3-dev build-essential libx11-dev libxmu-dev libxi-dev libglu1-mesa libglu1-mesa-dev

# first get the PPA repository driver
sudo add-apt-repository ppa:graphics-drivers/ppa
sudo apt update

wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin
sudo mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600
sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/3bf863cc.pub
sudo add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/ /"
sudo apt-get update

 # installing CUDA-11.3
sudo apt install cuda-11-3 

# setup your paths
echo 'export PATH=/usr/local/cuda-11.3/bin:$PATH' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=/usr/local/cuda-11.3/lib64:$LD_LIBRARY_PATH' >> ~/.bashrc
source ~/.bashrc