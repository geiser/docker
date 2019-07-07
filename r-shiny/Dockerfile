FROM geiser/r-prod:v0.09 AS v0.09
MAINTAINER Geiser Chalco <geiser@usp.br>

LABEL org.label-schema.license="GPL-3.0" \
      org.label-schema.vcs-url="https://github.com/geiser/docker" \
      org.label-schema.vendor="R-shiny for my-projects" \
      maintainer="Geiser Chalco <geiser@usp.br>"

# installing depend on packages
RUN apt-get update -qq && apt-get -y --no-install-recommends install \
    sudo \
    gdebi-core \
    pandoc \
    pandoc-citeproc \
    libcurl4-gnutls-dev \
    libcairo2-dev \
    libxt-dev \
    xtail \
    wget \
    && apt-get clean && apt-get autoclean && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*

# download and install shiny server
RUN install2.r shiny \
    && install2.r rmarkdown \
    && install2.r shinythemes

RUN wget --no-verbose https://download3.rstudio.org/ubuntu-14.04/x86_64/VERSION -O "version.txt" \
    && VERSION=$(cat version.txt) \
    && wget --no-verbose "https://download3.rstudio.org/ubuntu-14.04/x86_64/shiny-server-$VERSION-amd64.deb" -O ss-latest.deb \
    && apt-get update -qq \
    && gdebi -n ss-latest.deb \
    && rm -f version.txt ss-latest.deb \
    && . /etc/environment \
    && cp -R /usr/local/lib/R/site-library/shiny/examples/* /srv/shiny-server \
    && chown shiny:shiny /var/lib/shiny-server \
    && apt-get clean && apt-get autoclean && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*

# Making executable
EXPOSE 3838
COPY shiny-server.sh /usr/bin/shiny-server.sh
CMD ["shiny-server"]
