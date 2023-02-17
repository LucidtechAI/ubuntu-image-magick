FROM ubuntu:22.04

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    ca-certificates \
    gcc \
    libfreetype6-dev \
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    libx11-dev \
    libxext-dev \
    libxml2-dev \
    make \
    wget \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists

ARG GHOSTSCRIPT_VERSION=10.0.0
WORKDIR /ghostscript_build
RUN wget https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs1000/ghostscript-$GHOSTSCRIPT_VERSION.tar.gz
RUN tar -xvf ghostscript-$GHOSTSCRIPT_VERSION.tar.gz
RUN cd ghostscript-$GHOSTSCRIPT_VERSION/ && ./configure && make install
RUN gs --version

ARG IMAGE_MAGICK_VERSION=7.1.0-62
WORKDIR /image_magick_build
RUN wget https://download.imagemagick.org/ImageMagick/download/ImageMagick-$IMAGE_MAGICK_VERSION.tar.gz
RUN tar -xvf ImageMagick-$IMAGE_MAGICK_VERSION.tar.gz
RUN cd ImageMagick-$IMAGE_MAGICK_VERSION/ && ./configure && make -j4 && make install && ldconfig /usr/local/lib
RUN magick --version
RUN convert --version

WORKDIR /
RUN rm -r ghostscript_build
RUN rm -r image_magick_build
