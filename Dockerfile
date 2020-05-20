# spt3g
# An image with an installation of spt3g

# Use ubuntu base image
FROM ubuntu:18.04

# Set the working directory to /app_lib
WORKDIR /app_lib

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
    python3-scipy \
    git

# Copy the current directory contents into the container at /app_lib
COPY spt3g-setup.sh /app_lib
COPY spt3g_software/ /app_lib/spt3g_software/

# Setup spt3g
RUN /bin/bash /app_lib/spt3g-setup.sh

# Setup environment, else it's not setup to import spt3g in container
ENV SPT3G_SOFTWARE_PATH /app_lib/spt3g_software
ENV SPT3G_SOFTWARE_BUILD_PATH /app_lib/spt3g_software/build

ENV PATH="/app_lib/spt3g_software/build/bin:${PATH}"
ENV LD_LIBRARY_PATH="/app_lib/spt3g_software/build/spt3g:${LD_LIBRARY_PATH}"
ENV PYTHONPATH="/app_lib/spt3g_software/build:${PYTHONPATH}"
