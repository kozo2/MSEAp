FROM rocker/binder

USER root

RUN apt-get update && \
    apt-get install -y zlib1g-dev libxml2-dev libpng-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
    
RUN Rscript -e "source('http://bioconductor.org/biocLite.R'); biocLite(c('KEGGREST', 'KEGGgraph'))"
RUN Rscript -e "install.packages('devtools'); devtools::install_github('afukushima/MSEAp')"

USER ${NB_USER}
