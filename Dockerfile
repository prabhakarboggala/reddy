# FROM alpine:latest
FROM alpine:latest

#In Alpine Linux git command is not present by default so to install git command run the following commands 
RUN apk update
RUN apk upgrade
RUN apk add --no-cache bash git openssh

#In Alpine Linux make command is not present by default so to install make command run the following command
RUN apk add --no-cache bash make

#In Alpine Linux gcc command is not present by default so to install gcc command run the following command
RUN apk add --no-cache gcc musl-dev

#In Alpine Linux musl-gcc command is not present by default so to install musl-gcc command first clone the musl using below command
RUN git clone git://git.musl-libc.org/musl
#Change the present working directory to musl
RUN cd musl
#Run the below command
RUN ./configure && make install
RUN cd ..

#In Alpine Linux c++ command is not present by default so to install c++ command run the below commands.
RUN apk add --update g++
RUN rm /var/cache/apk/*

#In Alpine Linux perl command is not present by default so to install perl command run the following commands
RUN apk update
RUN apk upgrade
RUN apk add bash wget curl perl make g++ libev-dev patch git openssl-dev openssl

#In Alpine Linux execinfo.h is not present by default so to add this header file run the following command
RUN apk add libexecinfo-dev

#change the present working directory
RUN cd home
#clone the EclipseOMR repository 
RUN git clone https://github.com/prabhakarboggala/omr.git
RUN cd omr
RUN make -f run_configure.mk SPEC=linux_x86-64 OMRGLUE=./example/glue

#To disable the numa run the following commands from the top of the source tree. The top of the Eclipse OMR source tree is the directory that contains run_configure.mk.
RUN make -f run_configure.mk SPEC=linux_x86-64 OMRGLUE=./example/glue 'EXTRA_CONFIGURE_ARGS=--disable-OMR_PORT_NUMA_SUPPORT' clean all
CMD ["make"]
