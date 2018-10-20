FROM debian:9.5-slim
RUN apt-get update && apt-get -y upgrade && apt-get -y install \
    rtmpdump \
    swftools \
    libxml2-utils \
    ffmpeg \
    libavcodec-extra \
    wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
COPY ./rec_radiko.sh /usr/local/bin/
ENV TZ Asia/Tokyo
WORKDIR /usr/volume

