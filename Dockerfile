FROM rocker/rstudio

LABEL maintainer="Kozo Nishida <knishida@riken.jp>"

USER root

RUN apt-get update && \
    apt-get install -y zlib1g-dev libxml2-dev libpng-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
    
RUN Rscript -e "install.packages('devtools')"
RUN Rscript -e "source('http://bioconductor.org/biocLite.R')"
RUN Rscript -e "biocLite(c('KEGGREST', 'KEGGgraph'))
RUN Rscript -e "library(devtools)"
RUN Rscript -e "install_github('afukushima/MSEAp')"
