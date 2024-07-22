MSEAp
========
[![Binder](https://mybinder.org/badge.svg)](https://mybinder.org/v2/gh/afukushima/MSEAp/master)
[![Build Status](https://travis-ci.org/afukushima/MSEAp.svg?branch=master)](https://travis-ci.org/afukushima/MSEAp)
[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/afukushima/MSEAp?branch=master&svg=true)](https://ci.appveyor.com/project/afukushima/MSEAp)

An R package to perform Metabolite Set Enrichment Analysis (MSEA) for metabolomics community.

Running MSEAp on Binder
-----------------------
No installation needed. Please click [![Binder](https://mybinder.org/badge.svg)](https://mybinder.org/v2/gh/afukushima/MSEAp/master) badge. After that, you should see the Jupyter Notebook.
In the Jupyter Notebook click on "New" > "RStudio Session". You should see RStudio next.

![Image of Binder](https://raw.githubusercontent.com/afukushima/MSEAp/master/binder.PNG)

MSEAp is already installed in the RStudio environment.
Please load MSEAp by running `library(MSEAp)` in the RStudio console.

Installation
--------------
```R
# If you are using Debian or Ubuntu, please uncomment the next two lines
#system("sudo apt-get update")
#system("sudo apt-get install -y zlib1g-dev libxml2-dev libpng-dev")

install.packages(c("devtools", "webshot", "knitr", "rmarkdown"))

source("http://bioconductor.org/biocLite.R")
biocLite(c("KEGGREST", "KEGGgraph", "BiocStyle", "paxtoolsr", "RCy3"))

devtools::install_github("kozo2/MSEApdata", build_vignettes = FALSE)
devtools::install_github("kozo2/MSEAp", build_vignettes = TRUE)
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
