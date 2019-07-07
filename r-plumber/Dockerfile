FROM geiser/r-prod:v0.09 AS v0.09
MAINTAINER Geiser Chalco <geiser@usp.br>

LABEL org.label-schema.license="GPL-3.0" \
      org.label-schema.vcs-url="https://github.com/geiser/docker" \
      org.label-schema.vendor="R-plumber for my-projects" \
      maintainer="Geiser Chalco <geiser@usp.br>"

RUN apt-get update -qq && apt-get install -y \
	git-core \
	libssl-dev \
	libcurl4-gnutls-dev \
	&& apt-get clean && apt-get autoclean && apt-get autoremove \
	&& rm -rf /var/lib/apt/lists/*

# Install R packages
RUN install2.r plumber

# Making executable
EXPOSE 8080
ENTRYPOINT ["R", "-e", "pr <- plumber::plumb(commandArgs()[4]); pr$run(host='0.0.0.0', port=8080, swagger=T)"]
CMD ["/usr/local/lib/R/site-library/plumber/examples/04-mean-sum/plumber.R"]
