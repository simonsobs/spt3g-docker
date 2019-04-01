# spt3g
# A container setup with an installation of spt3g.

# Use ubuntu base image
FROM ubuntu:18.04

# Set the working directory to /root
WORKDIR /root

ENV TZ=America/New_York

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get install -y cmake \
    libboost-all-dev \
    libflac-dev \
    libnetcdf-dev \
    libfftw3-dev \
    libgsl0-dev \
    tcl \
    environment-modules \
    python3 \
    python3-pip \
    python3-numpy \
    git

# Copy the current directory contents into the container at /root
COPY . /root/

RUN /bin/bash /root/spt3g-setup.sh
RUN cat /root/bashrc >> ~/.bashrc

# Run app.py when the container launches
#CMD ["python3", "thermometry_server.py"]
