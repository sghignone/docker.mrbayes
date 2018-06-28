FROM ubuntu:16.04

LABEL maintainer="Stefano Ghignone, IPSP-CNR, Turin, Italy, stefano.ghignone[at]ipsp.cnr.it"
LABEL version="3.2.6"
LABEL description="MrBayes v.3.2.6, mpi enabled, \
mpirun -np <cpu> mb <input.nex>, \
CPUs no. should coincide to nchains used for the analysis."

RUN apt update && \
    apt -y upgrade && \
    apt-get install -y apt-utils \ 
	mpich \
	wget \
	gcc \
	make \
	automake \
	autoconf \
	pkg-config \
	autoconf-archive \
	&& rm -rf /var/lib/apt/lists/*

WORKDIR /opt
RUN wget https://github.com/NBISweden/MrBayes/raw/v3.2.6/mrbayes-3.2.6.tar.gz
RUN tar -xvzf mrbayes-3.2.6.tar.gz

WORKDIR /opt/mrbayes-3.2.6/src
RUN autoconf
RUN ./configure --enable-mpi=yes --with-beagle=no
RUN make && make install

WORKDIR /root

