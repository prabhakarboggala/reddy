# FROM alpine:latest
FROM alpine:latest

RUN apk update \
    && apk upgrade \
    && apk add --no-cache bash git openssh \
    && apk add --no-cache bash make \
    && apk add bash wget curl perl make g++ libev-dev patch git openssl-dev openssl \
    && apk add libexecinfo-dev \
    && apk add --no-cache gcc musl-dev \
    && apk add --update g++ \
    && rm /var/cache/apk/* \
    && cd home

RUN git clone git://git.musl-libc.org/musl \
    && cd musl \
    && ./configure && make install \
    && cd /home

RUN git clone https://github.com/prabhakarboggala/omr.git \
    && cd omr
    && make -f run_configure.mk SPEC=linux_x86-64 OMRGLUE=./example/glue \
    && make -f run_configure.mk SPEC=linux_x86-64 OMRGLUE=./example/glue 'EXTRA_CONFIGURE_ARGS=--disable-OMR_PORT_NUMA_SUPPORT' clean all \
    && make
    
WORKDIR /home/omr
    



