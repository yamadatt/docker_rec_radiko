FROM alpine:3.10.3 as swftools
RUN apk --update add \
    --no-cache \
    libtool automake autoconf nasm vips-dev fftw-dev gcc g++ make libc6-compat \
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

FROM alpine:3.10.3 as tzdata
RUN apk --update add \
    --no-cache \
    tzdata

FROM alpine:3.10.3
RUN apk --update add \
    --no-cache \
    rtmpdump \
    libxml2-utils \
    ffmpeg \
    bash \
    perl \
    curl \
    wget 

COPY --from=swftools /usr/local/bin/swfextract /usr/local/bin/
COPY --from=tzdata /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

COPY ./rec_radiko.sh /usr/local/bin/
WORKDIR /usr/volume