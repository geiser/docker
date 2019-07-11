FROM geiser/r-prod:latest AS v0.09
MAINTAINER Geiser Chalco <geiser@usp.br>

LABEL org.label-schema.license="GPL-3.0" \
      org.label-schema.vcs-url="https://github.com/geiser/docker" \
      org.label-schema.vendor="R-studio for my-projects" \
      maintainer="Geiser Chalco <geiser@usp.br>"

## Install R-server
RUN apt-get update -qq && apt-get install -y --no-install-recommends \
    gdebi-core \
    supervisor \
    && wget https://download2.rstudio.org/server/bionic/amd64/rstudio-server-1.2.1335-amd64.deb \
    && gdebi -n rstudio-server-1.2.1335-amd64.deb \
    && rm rstudio-server-1.2.1335-amd64.deb \
    && apt-get clean && apt-get autoclean && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash -N -u 1001 gcc \
  && echo "gcc:qaz123456" | chpasswd \
  && addgroup gcc staff \
  && adduser gcc sudo \
  && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
  && ln -s /usr/lib/rstudio-server/bin/pandoc/pandoc /usr/local/bin/pandoc

# Download and install default shiny packages
RUN install2.r -s shiny \
    && install2.r -s rmarkdown \
    && install2.r -s shinythemes

# Making executable
EXPOSE 8787 8080
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
