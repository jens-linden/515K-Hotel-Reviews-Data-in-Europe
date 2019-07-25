# JLI: ggmap installation was a problem. Needed to add libjpeg-dev and libssl-dev to make it work.
FROM rocker/r-ver:3.6.0

RUN apt-get update && apt-get install -y \
    sudo \
    gdebi-core \
    pandoc \
    pandoc-citeproc \
    libcurl4-gnutls-dev \
    libcairo2-dev \
    libxt-dev \
    xtail \
    wget \
	libjpeg-dev \
	libssl-dev


# Download and install shiny server
RUN wget --no-verbose https://download3.rstudio.org/ubuntu-14.04/x86_64/VERSION -O "version.txt" && \
    VERSION=$(cat version.txt)  && \
    wget --no-verbose "https://download3.rstudio.org/ubuntu-14.04/x86_64/shiny-server-$VERSION-amd64.deb" -O ss-latest.deb && \
    gdebi -n ss-latest.deb && \
    rm -f version.txt ss-latest.deb && \
    . /etc/environment && \
    R -e "install.packages(c('shiny', 'rmarkdown'), repos='$MRAN')" && \
    cp -R /usr/local/lib/R/site-library/shiny/examples/* /srv/shiny-server/ && \
    chown shiny:shiny /var/lib/shiny-server

RUN R -e "install.packages('data.table', dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('rprojroot', dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('R6', dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('ggplot2', dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('knitr', dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('skimr', dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('DataExplorer', dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('leaflet', dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('sp', dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('rworldmap', dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('digest', dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('geosphere', dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('stringr', dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('tidyr', dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('tm', dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('SnowballC', dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('caret', dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('factoextra', dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('party', dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('ggmap', dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('DT', dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('ggrepel', dependencies=TRUE, repos='http://cran.rstudio.com/')"


EXPOSE 3838

COPY shiny-server.sh /usr/bin/shiny-server.sh
COPY shiny-server.conf  /etc/shiny-server/shiny-server.conf
COPY /04_shiny_app /srv/shiny-server/

CMD ["/usr/bin/shiny-server.sh"]