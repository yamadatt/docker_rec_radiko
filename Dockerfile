FROM alpine:3.11.3
RUN apk add \
    --no-cache \
    --repository http://dl-3.alpinelinux.org/alpine/edge/testing \
    libtool automake autoconf nasm vips-dev fftw-dev gcc g++ make libc6-compat \
    rtmpdump \
    libxml2-utils \
    ffmpeg \
    wget
RUN apk update \
    && wget http://swftools.org/swftools-0.9.2.tar.gz \
    && tar -xvf swftools-0.9.2.tar.gz  \
    && cd swftools-0.9.2 \
    && LIBRARY_PATH=/lib:/usr/lib ./configure \
    && make \
    # Makefile includes rm with -o flag
    && sed -e 's/-o -L/#-o -L/' -i swfs/Makefile \
    && make install \
    && rm -rf /var/cache/apk/* \
    && rm -rf /swftools-0.9.2
COPY ./rec_radiko.sh /usr/local/bin/
ENV TZ Asia/Tokyo
WORKDIR /usr/volume
