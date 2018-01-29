FROM rocker/binder

USER root

RUN apt-get update && \
    apt-get install -y zlib1g-dev libxml2-dev libpng-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
    
RUN Rscript -e "source('http://bioconductor.org/biocLite.R'); biocLite(c('KEGGREST', 'KEGGgraph', 'BiocStyle'))"
RUN Rscript -e "install.packages(c('devtools', 'webshot', 'knitr', 'rmarkdown')); devtools::install_github('cytoscape/r2cytoscape'); devtools::install_github('afukushima/MSEAp', build_vignettes = TRUE)"

COPY . ${HOME}
RUN chown -R ${NB_USER} ${HOME}
USER ${NB_USER}
