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
  make install


# Install protobuf (protoc)
ENV PROTOBUF_VERSION 3.4.0

RUN curl -SOL https://github.com/google/protobuf/releases/download/v${PROTOBUF_VERSION}/protoc-${PROTOBUF_VERSION}-linux-x86_64.zip && \
  unzip protoc-${PROTOBUF_VERSION}-linux-x86_64.zip -d protoc3 && \
  mv protoc3/bin/* /usr/local/bin/ && \
  mv protoc3/include/* /usr/local/include/ && \
  protoc --version


# Download miner
RUN curl -SOL https://github.com/Blockcdnteam/Minner/releases/download/v1.0/M_BerryMiner_Ubuntu.zip && \
  unzip M_BerryMiner_Ubuntu.zip && \
  mv M_BerryMiner_Ubuntu/M_BerryMiner_ubuntu_v1_0/server /usr/local/m_berry_miner

# Setup miner startup script
WORKDIR /usr/local/m_berry_miner

COPY start_bcdn .

CMD ./start_bcdn
