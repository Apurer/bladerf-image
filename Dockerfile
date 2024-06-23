# Use Ubuntu 20.04 LTS as the base image
FROM ubuntu:20.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install essential tools, dependencies, and documentation tools
RUN apt-get update && \
    apt-get install -y software-properties-common wget git build-essential cmake libusb-1.0-0-dev libusb-1.0-0 libncurses5-dev libtecla1 libtecla-dev pkg-config doxygen help2man pandoc udev lsof usbutils 

# Clone the latest bladeRF source code
RUN git clone https://github.com/Nuand/bladeRF.git /tmp/bladeRF

# Build and install bladeRF from source using all available cores
RUN cd /tmp/bladeRF/host && \
    mkdir build && \
    cd build && \
    cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local -DINSTALL_UDEV_RULES=ON .. && \
    make -j$(nproc) && \
    make install && \
    ldconfig

# Cleanup: Remove the bladeRF source code to save space
RUN rm -rf /tmp/bladeRF

ENTRYPOINT ["/bin/bash"]
