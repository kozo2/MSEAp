MSEAp
========
[![Binder](https://mybinder.org/badge.svg)](https://mybinder.org/v2/gh/afukushima/MSEAp/master)
[![Build Status](https://travis-ci.org/afukushima/MSEAp.svg?branch=master)](https://travis-ci.org/afukushima/MSEAp)
[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/afukushima/MSEAp?branch=master&svg=true)](https://ci.appveyor.com/project/afukushima/MSEAp)

An R package to perform Metabolite Set Enrichment Analysis (MSEA) for metabolomics community.

Installation (for the users)
----------------------------
```R
# If you are using Debian or Ubuntu, please uncomment the next two lines
#system("sudo apt-get update")
#system("sudo apt-get install -y zlib1g-dev libxml2-dev libpng-dev")

install.packages("devtools")

source("http://bioconductor.org/biocLite.R")
biocLite(c("KEGGREST", "KEGGgraph"))

library(devtools)
install_github("afukushima/MSEAp")
```

Prerequisite packages for the developers
----------------------------------------
```R
# If you are using Debian or Ubuntu, please uncomment the next two lines
#system("sudo apt-get update")
#system("sudo apt-get install -y zlib1g-dev libxml2-dev libpng-dev libcairo2-dev imagemagick")

install.packages(c("devtools", "testthat", "fields", "ggplot2", "dplyr", "visNetwork", "roxygen2", "testthat", "knitr", "webshot", "rmarkdown", "exact2x2"))

source("http://bioconductor.org/biocLite.R")
biocLite(c("KEGGREST", "KEGGgraph", "BiocStyle"))
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
