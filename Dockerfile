# Minimal Docker image for ViralMSA using Alpine base
FROM alpine:latest
MAINTAINER Niema Moshiri <niemamoshiri@gmail.com>

# Set up environment and install dependencies
RUN apk update && \
    apk add bash gcc g++ make musl-dev perl python3 unzip zlib-dev

# Install Bowtie2 v2.4.3
RUN wget "https://github.com/BenLangmead/bowtie2/releases/download/v2.4.3/bowtie2-2.4.3-source.zip" && \
    unzip bowtie2-2.4.3-source.zip && \
    cd bowtie2-2.4.3 && \
    make && \
    make install && \
    cd .. && \
    rm -rf bowtie2-2.4.3 bowtie2-2.4.3-source.zip

# Install HISAT2 (2.2.1) TODO NEED TO COMPILE FROM SCRATCH
#RUN wget -O hisat2.zip "https://cloud.biohpc.swmed.edu/index.php/s/oTtGWbWjaxsQ2Ho/download" && \
#    unzip hisat2.zip && mv hisat2-*/hisat2* /usr/local/bin && rm -rf hisat2*

# Install Minimap2 v2.20
RUN wget -qO- "https://github.com/lh3/minimap2/archive/refs/tags/v2.20.tar.gz" | tar -zx && \
    cd minimap2-* && \
    make && \
    chmod a+x minimap2 && \
    mv minimap2 /usr/local/bin/minimap2 && \
    cd .. && \
    rm -rf minimap2-*

# Install STAR (2.7.5c) TODO NEED TO COMPILE FROM SCRATCH
#RUN wget -qO- "https://github.com/alexdobin/STAR/archive/2.7.5c.tar.gz" | tar -zx && \
#    mv STAR-*/bin/Linux_x86_64_static/* /usr/local/bin && rm -rf STAR-*

# Install wfmash TODO NEED TO COMPILE FROM SCRATCH
#RUN git clone https://github.com/ekg/wfmash.git && \
#    cd wfmash && ./bootstrap.sh && ./configure && make && make install && cd .. && rm -rf wfmash

# Install Unimap (latest)
RUN wget "https://github.com/lh3/unimap/archive/refs/heads/master.zip" && \
    unzip master.zip && \
    cd unimap-master && \
    make && \
    mv unimap /usr/local/bin/unimap && \
    cd .. && \
    rm -rf master.zip unimap-master

# Set up ViralMSA
RUN wget -O /usr/local/bin/ViralMSA.py "https://raw.githubusercontent.com/niemasd/ViralMSA/master/ViralMSA.py" && chmod a+x /usr/local/bin/ViralMSA.py

# Clean up
RUN rm -rf /root/.cache && \
    rm -rf /tmp/*
