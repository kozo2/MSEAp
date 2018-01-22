MSEAp
========
[![Binder](https://mybinder.org/badge.svg)](https://mybinder.org/v2/gh/afukushima/MSEAp/master)
[![Build Status](https://travis-ci.org/afukushima/MSEAp.svg?branch=master)](https://travis-ci.org/afukushima/MSEAp)
[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/afukushima/MSEAp?branch=master&svg=true)](https://ci.appveyor.com/project/afukushima/MSEAp)

An R package to perform Metabolite Set Enrichment Analysis (MSEA) for metabolomics community.

Installation
--------------
```R
# If you are using Debian or Ubuntu, please uncomment the next two lines
#system("sudo apt-get update")
#system("sudo apt-get install -y zlib1g-dev libxml2-dev libpng-dev")

install.packages(c("devtools", "webshot", "knitr", "rmarkdown"))

source("http://bioconductor.org/biocLite.R")
biocLite(c("KEGGREST", "KEGGgraph", "BiocStyle"))

devtools::install_github("cytoscape/r2cytoscape")
devtools::install_github("afukushima/MSEAp", build_vignettes = TRUE)
```

Documents
------------
```{R}
browseVignettes("MSEAp")
```

Updates
------------
#### version 0.0.9000 (Oct 17, 2017)

License
------------
The MSEAp package is free software; a copy of the GNU General Public License, version 3, is available at [http://www.r-project.org/Licenses/GPL-3](http://www.r-project.org/Licenses/GPL-3)
