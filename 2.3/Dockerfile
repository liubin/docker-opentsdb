FROM openjdk:8-jdk-alpine

RUN cd /tmp && \
  wget http://downloads.sourceforge.net/project/gnuplot/gnuplot/5.0.3/gnuplot-5.0.3.tar.gz && \
  tar zxf gnuplot-5.0.3.tar.gz  && \
  cd gnuplot-5.0.3 && \
  apk --no-cache --update add gd gd-dev libpng libpng-dev libjpeg jpeg-dev freetype freetype-dev && \
  apk --no-cache --update add --virtual builddeps build-base autoconf automake git python && \
  ./configure --bindir=/bin && \
  make && \
  make install && \
  apk del builddeps && rm -rf /var/cache/apk/* && \
  cd / && rm -rf /tmp/gnuplot*

# set timezone
RUN apk --update add tzdata && \
  cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime  && \
  echo "Asia/Shanghai"  >  /etc/timezone && \
  apk del tzdata


ENV TSDB_VERSION 2.3.0

RUN mkdir /opt/opentsdb/
WORKDIR /opt/opentsdb/
RUN apk --no-cache --update add --virtual builddeps \
    build-base \
    autoconf \
    automake \
    git \
    python \
  && : Install OpenTSDB and scripts \
  && wget --no-check-certificate \
    -O v${TSDB_VERSION}.zip \
    https://github.com/OpenTSDB/opentsdb/archive/v${TSDB_VERSION}.zip \
  && unzip v${TSDB_VERSION}.zip \
  && rm v${TSDB_VERSION}.zip \
  && cd /opt/opentsdb/opentsdb-${TSDB_VERSION} \
  && ./build.sh \
  && : because of issue https://github.com/OpenTSDB/opentsdb/issues/707 \
  && : commented lines do not work. These can be uncommeted when version of \
  && : tsdb is bumped. Entrypoint will have to be updated too. \
  && : cd build \
  && : make install \
  && : cd / \
  && : rm -rf /opt/opentsdb/opentsdb-${TSDB_VERSION} \
  && apk del builddeps \
  && rm -rf /var/cache/apk/*

EXPOSE 4242

COPY etc/opentsdb.conf /opt/opentsdb/

COPY entrypoint.sh /
RUN chmod a+x /entrypoint.sh

CMD ["/entrypoint.sh"]

