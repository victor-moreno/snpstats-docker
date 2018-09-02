# Docker container to run locally SNPstats (https://www.snpstats.net)

**SNPStats** is a simple, ready-to-use software which has been designed to analyze genetic-epidemiology studies of association using SNPs.

You can upload your data and, for each selected SNP, you will receive:

- Allele and genotype frequencies
- Test for Hardy-Weinberg equilibrium
- Analysis of association with a response variable based on linear or logistic regression
- Multiple inheritance models: co-dominant, dominant, recessive, over-dominant and additive
- Analysis of interactions (gene-gene or gene-environment)

If multiple SNPs are selected:
- Linkage disequilibrium statistics
- Haplotype frequency estimation
- Analysis of association of haplotypes with the response
- Analysis of interactions (haplotypes-covariate)

SNPstats was developed by the Unit of Biomarkers and Susceptibility of the Cancer Prevention and Control Program of the Catalan Institute of Oncology (https://www.icoprevencio.cat)


Paper: 
SNPStats: a web tool for the analysis of association studies
Xavier Sole, Elisabet Guino, Joan Valls, Raquel Iniesta, and Victor Moreno
Bioinformatics 2006 22: 1928-1929.



## Dockerfile based on alpine-r & alpine-apache-php
[Alpine-r](https://github.com/artemklevtsov/r-alpine/blob/master/release/Dockerfile) @artemklevtsov

[Alpine-apache-php](https://github.com/wichon/alpine-apache-php/blob/master/Dockerfile) @wichon

**SNPstats** is based on [R](https://cran.r-project.org). View [R-project license](https://www.r-project.org/Licenses/) information for the software contained in this image.
The main R libraries used are [genetics](https://cran.r-project.org/web/packages/genetics/) and [haplo.stats](https://cran.r-project.org/web/packages/haplo.stats/)

## Install on your computer:

```
git clone https://github.com/victor-moreno/snpstats-docker
cd snpstats-docker
```

#### Build
From the folder where Dockerfile is located:

```
docker build --no-cache -t snpstats .
```

#### Usage
```
docker run -d -p 8083:80 --name snpstats snpstats

open http://localhost:8083
```

#### Notes
Yo can change the browser port (8083) to any of your choice.

The application keeps temporary files. To avoid that the image grows, you can expose temporary folders and clean them periodically:

```
dir=`pwd`
mkdir tmp_html
mkdir tmp_scripts

docker run -d -p 8083:80 --name snpstats -v $dir/tmp_scripts:/app/snpstats/tmp_scripts -v $dir/tmp_html:/app/snpstats/tmp_html snpstats
```

To improve and debug, extract the code and expose it: 

```
tar xzf snpstats.tar.gz
docker run -d -p 8083:80 --name snpstats -v snpstats:/app/snpstats snpstats
```
The you can easily modifiy the code inside the container.


## Problems & Bugs
The code was written in 2006 and has been minimmaly updated to support newer versions of R, but still uses an old version of haplo.stats package to reduce the dependence load. It also will work without modifications with current versions.

Some problems with data or serioulsy problematic models with undefined solutions may crash the R code.

Please report any problem or comments and we'll try to address it.
