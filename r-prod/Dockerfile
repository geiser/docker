FROM ubuntu:18.04 AS v0.09
MAINTAINER Geiser Chalco <geiser@usp.br>

LABEL org.label-schema.license="GPL-3.0" \
      org.label-schema.vcs-url="https://github.com/geiser/docker" \
      org.label-schema.vendor="production version of R for my projects" \
      maintainer="Geiser Chalco <geiser@usp.br>"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -qq && apt-get -y --no-install-recommends install \
    apt-utils \
    ed \
    less \
    locales \
    vim-tiny \
    wget \
    ca-certificates \
    apt-transport-https \
    gsfonts \
    gnupg2 \
    && rm -rf /var/lib/apt/lists/*

# Configure default locale, see https://github.com/rocker-org/rocker/issues/19
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
    && locale-gen en_US.utf8 \
    && /usr/sbin/update-locale LANG=en_US.UTF-8

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

RUN echo "deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/" > /etc/apt/sources.list.d/cran.list

# note the proxy for gpg
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9

# Now install R and littler, and create a link for littler in /usr/local/bin
# Also set a default CRAN repo, and make sure littler knows about it too
RUN apt-get update -qq && apt-get -y --no-install-recommends install \
    littler \
    r-cran-littler \
    r-base \
    r-base-dev \
    r-recommended \
    && echo 'options(repos = c(CRAN = "https://cloud.r-project.org/"), download.file.method = "libcurl")' >> /etc/R/Rprofile.site \
    && echo 'source("/etc/R/Rprofile.site")' >> /etc/littler.r \
    && ln -s /usr/share/doc/littler/examples/install.r /usr/local/bin/install.r \
    && ln -s /usr/share/doc/littler/examples/install2.r /usr/local/bin/install2.r \
    && ln -s /usr/share/doc/littler/examples/installGithub.r /usr/local/bin/installGithub.r \
    && ln -s /usr/share/doc/littler/examples/testInstalled.r /usr/local/bin/testInstalled.r \
    && install.r docopt \
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds \
    && rm -rf /var/lib/apt/lists/*

# Install java and rJava
RUN apt-get update -qq && apt-get -y --no-install-recommends install \
    default-jdk \
    && R CMD javareconf -e \
    && install2.r rJava \
    && apt-get clean && apt-get autoclean && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*

# Install extra basic R packages
RUN apt-get update -qq && apt-get -y --no-install-recommends install \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    && install2.r -s config \
    && install2.r -s plotly \
    && install2.r -s qdap \
    && install2.r -s rjson \
    && apt-get clean && apt-get autoclean && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*

CMD ["R"]
