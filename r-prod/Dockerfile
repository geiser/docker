FROM r-base:3.6.0 AS v0.09
MAINTAINER Geiser Chalco <geiser@usp.br>

LABEL org.label-schema.license="GPL-3.0" \
      org.label-schema.vcs-url="https://github.com/geiser/docker" \
      org.label-schema.vendor="production version of R for my projects" \
      maintainer="Geiser Chalco <geiser@usp.br>"

# installing packages
RUN apt-get update -qq && apt-get -y --no-install-recommends install \
    libcurl4-openssl-dev \
    libxml2-dev \
    libssl-dev \
    && apt-get clean && apt-get autoclean && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*

# installing java
RUN apt-get update -qq && apt-get -y --no-install-recommends install \
    default-jdk \
    r-cran-rjava \
    && apt-get clean && apt-get autoclean && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/* \
    && R CMD javareconf -e

# Install R packages
RUN install2.r rJava \
    && install2.r config \
    && install2.r plotly \
    && install2.r qdap \
    && install2.r rjson
