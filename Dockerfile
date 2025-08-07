FROM ubuntu:24.04

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    ca-certificates \
    gcc \
    libfreetype6-dev \
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    libwebp-dev \
    libx11-dev \
    libxext-dev \
    libxml2-dev \
    make \
    pkg-config \
    webp \
    wget \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists

ARG GHOSTSCRIPT_VERSION=10.03.1
ARG GHOSTSCRIPT_VERSION_SHORT=10031
WORKDIR /ghostscript_build
RUN wget https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs$GHOSTSCRIPT_VERSION_SHORT/ghostscript-$GHOSTSCRIPT_VERSION.tar.gz
RUN tar -xvf ghostscript-$GHOSTSCRIPT_VERSION.tar.gz
RUN cd ghostscript-$GHOSTSCRIPT_VERSION/ && ./configure && make install
RUN gs --version

ARG IMAGE_MAGICK_VERSION=7.1.1-32
WORKDIR /image_magick_build
RUN wget https://imagemagick.org/archive/releases/ImageMagick-$IMAGE_MAGICK_VERSION.tar.xz
RUN tar -xvf ImageMagick-$IMAGE_MAGICK_VERSION.tar.xz
RUN cd ImageMagick-$IMAGE_MAGICK_VERSION/ && ./configure && make -j4 && make install && ldconfig /usr/local/lib
RUN magick --version
RUN convert --version

WORKDIR /
RUN rm -r ghostscript_build
RUN rm -r image_magick_build
