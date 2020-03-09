FROM ubuntu:18.04

LABEL maintainer="Stefano Ghignone, IPSP-CNR, Turin, Italy, stefano.ghignone[at]ipsp.cnr.it"
LABEL version="3.2.7a"
LABEL description="MrBayes v.3.2.7a, mpi enabled, \
mpirun -np <cpu> mb <input.nex>, \
CPUs no. should coincide to nchains used for the analysis."

RUN apt update && \
    apt -y upgrade && \
    apt-get install -y apt-utils \
    	git \
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
RUN	git clone --depth=1 https://github.com/NBISweden/MrBayes.git
RUN	cd MrBayes/ && \
	autoconf && \
	./configure --with-mpi --whitout-beagle && \
	make && make install

WORKDIR /root 
