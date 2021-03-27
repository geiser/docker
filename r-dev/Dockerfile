
FROM geiser/r-dev:v20210225 AS v20210324
MAINTAINER Geiser Chalco <geiser@alumni.usp.br>

LABEL org.label-schema.license="GPL-2.0" \
      org.label-schema.vcs-url="https://github.com/geiser/docker/r-dev" \
      org.label-schema.vendor="Geiser Projects" \
      maintainer="Geiser Chalco <geiser@alumni@usp.br>"

RUN apt-get update -qq
 
RUN R -e "source('https://vipbg.vcu.edu/vipbg/OpenMx2/software/getOpenMx.R')"

RUN rm -rf /var/lib/apt/lists/*


FROM geiser/r-dev:v20210201 AS v20210225
MAINTAINER Geiser Chalco <geiser@alumni.usp.br>

RUN apt-get update -qq && apt-get -y --no-install-recommends install \
    libgsl-dev \
    && rm -rf /var/lib/apt/lists/*

RUN install2.r -s lavaan \
    && install2.r -s MVN \
    && install2.r -s psy \
    && install2.r -s mirt \
    && install2.r -s psych \
    && install2.r -s olsrr \
    && install2.r -s parameters \
    && install2.r -s semPlot \
    && install2.r -s semTools

CMD R -e "source('https://vipbg.vcu.edu/vipbg/OpenMx2/software/getOpenMx.R')"

FROM rocker/verse:4.0.3 AS v20210201
MAINTAINER Geiser Chalco <geiser@alumni.usp.br>

LABEL org.label-schema.license="GPL-2.0" \
      org.label-schema.vcs-url="https://github.com/geiser/docker/r-dev" \
      org.label-schema.vendor="Geiser Projects" \
      maintainer="Geiser Chalco <geiser@alumni@usp.br>"

ENV DISABLE_AUTH=true
RUN export DISABLE_AUTH=true

