FROM opensciencegrid/osgvo-ubuntu-20.04

LABEL opensciencegrid.name="Julia"
LABEL opensciencegrid.description="Ubuntu based image with Julia"
LABEL opensciencegrid.url="https://julialang.org/"
LABEL opensciencegrid.category="Languages"
LABEL opensciencegrid.definition_url="https://github.com/opensciencegrid/osgvo-julia"

ENV JULIA_MAJOR_VERSION=1.7
ENV JULIA_VERSION=${JULIA_MAJOR_VERSION}.3

WORKDIR /opt

# install julia and packages 
RUN wget -nv https://julialang-s3.julialang.org/bin/linux/x64/${JULIA_MAJOR_VERSION}/julia-${JULIA_VERSION}-linux-x86_64.tar.gz && \
    tar -xzvf julia-${JULIA_VERSION}-linux-x86_64.tar.gz && \
    rm -f julia-${JULIA_VERSION}-linux-x86_64.tar.gz && \
    ln -s /opt/julia-${JULIA_VERSION} /opt/julia && \
    ln -s /opt/julia/bin/julia /usr/local/bin/julia

# install base packages
COPY install.jl /opt
RUN /opt/julia/bin/julia /opt/install.jl && \
    rm -f /opt/install.jl && \
    chmod -R go+r /opt/julia/share/julia/

COPY .singularity.d /.singularity.d

