FROM geiser/r-prod:latest AS v0.09

#ARG RSTUDIO_VERSION
#ENV RSTUDIO_VERSION=${RSTUDIO_VERSION:-1.2.1335}
#ARG S6_VERSION
#ARG PANDOC_TEMPLATES_VERSION
#ENV S6_VERSION=${S6_VERSION:-v1.21.7.0}
#ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=2
#ENV PATH=/usr/lib/rstudio-server/bin:$PATH
#ENV PANDOC_TEMPLATES_VERSION=${PANDOC_TEMPLATES_VERSION:-2.6}

RUN apt-get update -qq && apt-get install -y --no-install-recommends \
    cmake 

RUN wget -O rstudio.tar.gz https://github.com/rstudio/rstudio/tarball/v1.2.1335 \
    && tar -zxvf rstudio.tar.gz \
    && mkdir -p rstudio/build && cd rstudio/build \
    && cmake .. -DRSTUDIO_TARGET=Server -DCMAKE_BUILD_TYPE=Release

#    gdebi-core \
#    && wget https://github.com/rstudio/rstudio/tarball/v1.2.1335 \
#    && gdebi rstudio-server-1.2.1335-amd64.deb \
#    && apt-get clean && apt-get autoclean && apt-get autoremove \
#    && rm -rf /var/lib/apt/lists/*
