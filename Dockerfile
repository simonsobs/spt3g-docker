# spt3g
# An image with an installation of spt3g

# Use ubuntu base image
FROM ubuntu:18.04

# Set the working directory to /root
WORKDIR /root

# Ensure we're set to UTC
ENV TZ=Etc/UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get install -y cmake \
    libboost-all-dev \
    libflac-dev \
    libnetcdf-dev \
    libfftw3-dev \
    libgsl0-dev \
    python3 \
    python3-pip \
    python3-numpy \
    git

# Copy the current directory contents into the container at /root
COPY spt3g-setup.sh /root
COPY spt3g_software/ /root/spt3g_software/

# Setup spt3g
RUN /bin/bash /root/spt3g-setup.sh

# Setup environment, else it's not setup to import spt3g in container
ENV SPT3G_SOFTWARE_PATH /root/spt3g_software
ENV SPT3G_SOFTWARE_BUILD_PATH /root/spt3g_software/build

ENV PATH="/root/spt3g_software/build/bin:${PATH}"
ENV LD_LIBRARY_PATH="/root/spt3g_software/build/spt3g:${LD_LIBRARY_PATH}"
ENV PYTHONPATH="/root/spt3g_software/build:${PYTHONPATH}"
