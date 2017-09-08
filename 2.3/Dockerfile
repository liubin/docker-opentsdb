FROM openjdk:8-jdk-alpine

ENV GNUPLOT_VER 5.2.0
ENV TSDB_VERSION 2.3.0

RUN mkdir -p /opt/

# run opentsdb need `make`
RUN apk --no-cache --update add bash make

RUN apk --no-cache --update add --virtual builddeps \
    build-base \
    autoconf \
    automake \
    git \
    python \
    openssl ca-certificates \
  && : +++++++++++++++++ \
  && : Install OpenTSDB and scripts \
  && cd /opt \
  && wget --no-check-certificate \
    -O v${TSDB_VERSION}.zip \
    https://github.com/OpenTSDB/opentsdb/archive/v${TSDB_VERSION}.zip \
  && unzip v${TSDB_VERSION}.zip \
  && rm v${TSDB_VERSION}.zip \
  && cd /opt/opentsdb-${TSDB_VERSION} \
  && ./build.sh \
  && : +++++++++++++++++ \
  && : do some clean to reduce image size \
  && rm -rf build/gwt-unitCache/* \
  && ln -s /opt/opentsdb-${TSDB_VERSION} /opt/opentsdb \
  && : +++++++++++++++++ \
  && : install gnuplot \
  && apk --no-cache --update add gd gd-dev libpng libpng-dev libjpeg jpeg-dev freetype freetype-dev libwebp libwebp-dev \
  && cd /tmp \
  && wget https://downloads.sourceforge.net/project/gnuplot/gnuplot/${GNUPLOT_VER}/gnuplot-${GNUPLOT_VER}.tar.gz \
  && tar zxf gnuplot-${GNUPLOT_VER}.tar.gz \
  && cd gnuplot-${GNUPLOT_VER} \
  && ./configure --bindir=/bin \
  && make \
  && make install \
  && : +++++++++++++++++ \
  && : delete not used packages \
  && apk del builddeps \
  && rm -rf /var/cache/apk/* \
  && cd / && rm -rf /tmp/gnuplot*

EXPOSE 4242
WORKDIR /opt/opentsdb/

COPY etc/opentsdb.conf /opt/opentsdb/

COPY entrypoint.sh /
RUN chmod a+x /entrypoint.sh

CMD ["/entrypoint.sh"]

