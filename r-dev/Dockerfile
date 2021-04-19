FROM rocker/verse:4.0.3 AS v0.01
MAINTAINER Geiser Chalco <geiser@alumni.usp.br>

LABEL org.label-schema.license="GPL-2.0" \
      org.label-schema.vcs-url="https://github.com/geiser/docker/r-dev" \
      org.label-schema.vendor="Geiser Projects" \
      maintainer="Geiser Chalco <geiser@alumni@usp.br>"

ENV DISABLE_AUTH=true
RUN export DISABLE_AUTH=true


FROM geiser/r-dev:v0.01 AS v0.02
MAINTAINER Geiser Chalco <geiser@alumni.usp.br>

RUN apt-get update -qq
RUN apt-get -y --no-install-recommends install \
    libgsl-dev
RUN install2.r -s lavaan \
    && install2.r -s MVN \
    && install2.r -s psy \
    && install2.r -s mirt \
    && install2.r -s psych \
    && install2.r -s olsrr \
    && install2.r -s parameters \
    && install2.r -s semPlot \
    && install2.r -s semTools
RUN install2.r -s OpenMx
RUN rm -rf /var/lib/apt/lists/*


FROM geiser/r-dev:v0.02 AS v0.03
MAINTAINER Geiser Chalco <geiser@alumni.usp.br>

RUN apt-get update -qq 
RUN apt-get -y --no-install-recommends install \
    apt-utils
RUN install2.r -s shiny
RUN R -e "if (packageVersion('shiny') < '1.5.0') devtools::install_version('shiny','1.5.0');"
RUN install2.r -s shiny.i18n shinyjs shinyTree \
    && install2.r -s DT digest careless templates tools zip utils rmarkdown \
    && install2.r -s stats fBasics rcompanion emmeans rstatix car \
    && install2.r -s ggplot2 ggpubr plotly \
    && install2.r -s remotes
RUN R -e "remotes::install_github('geiser/rshinystatistics');"
RUN rm -rf /var/lib/apt/lists/*

