FROM opensciencegrid/osgvo-ubuntu-xenial

# install julia and packages 
RUN cd /opt && \
    wget -nv https://julialang-s3.julialang.org/bin/linux/x64/1.0/julia-1.0.3-linux-x86_64.tar.gz && \
    tar -xzvf julia-1.0.3-linux-x86_64.tar.gz && \
    rm -f julia-1.0.3-linux-x86_64.tar.gz

# install base packages
COPY install.jl /opt
RUN /opt/julia-1.0.3/bin/julia /opt/install.jl && \
    rm -f /opt/install.jl && \
    find /opt/julia-1.0.3/share/julia/compiled/ -perm 600 -exec chmod 644 {} \;

