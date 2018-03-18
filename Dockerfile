FROM ubuntu:16.04

RUN apt-get update && apt-get install -y \
        software-properties-common \
        python-software-properties \
        autoconf         \
        autoconf-archive \
        automake         \
        curl             \
        g++              \
        git              \
        libtool          \
        libssl-dev       \
        libz-dev         \
        make             \
        man              \
        unzip

# Install Go 1.9
ENV GOLANG_VERSION 1.9

RUN add-apt-repository ppa:gophers/archive && \
    apt update && \
    apt-get -y install golang-${GOLANG_VERSION}-go

ENV PATH /usr/lib/go-${GOLANG_VERSION}/bin:${PATH}


# Install libevent
ENV LIBEVENT_VERSION 2.1.8-stable

RUN curl -SOL https://github.com/libevent/libevent/releases/download/release-${LIBEVENT_VERSION}/libevent-${LIBEVENT_VERSION}.tar.gz && \
  tar -zxvf libevent-${LIBEVENT_VERSION}.tar.gz && \
  cd libevent-${LIBEVENT_VERSION} && \
  ./autogen.sh && \
  ./configure --prefix=/usr && \
  make && \
  make install && \
  cd .. && \
  rm -rf libevent-${LIBEVENT_VERSION}


# Install protobuf (protoc)
ENV PROTOBUF_VERSION 3.4.0

RUN curl -SOL https://github.com/google/protobuf/releases/download/v${PROTOBUF_VERSION}/protoc-${PROTOBUF_VERSION}-linux-x86_64.zip && \
  unzip protoc-${PROTOBUF_VERSION}-linux-x86_64.zip -d protoc3 && \
  mv protoc3/bin/* /usr/local/bin/ && \
  mv protoc3/include/* /usr/local/include/ && \
  rm -rf protoc3 protoc-${PROTOBUF_VERSION}-linux-x86_64.zip && \
  protoc --version


# Download miner
ENV MINER_BASE /usr/local/m_berry_miner
ENV MINER_BASE_URL https://dl.blockcdn.org/dev/
ENV MINER_FILE 2018-03-09-v0.1.1-100.amd64.tar.gz

RUN mkdir ${MINER_BASE} && \
  curl -SOL ${MINER_BASE_URL}${MINER_FILE} && \
  tar -xxvf ${MINER_FILE} -C ${MINER_BASE} && \
  rm -rf ${MINER_FILE}

# Setup miner startup script
WORKDIR ${MINER_BASE}

COPY start_bcdn .

CMD ./start_bcdn
