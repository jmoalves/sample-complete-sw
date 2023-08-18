FROM jmoalves/docker-dev as buildHelper

FROM ubuntu:22.04

USER root

################################################
### TOOLS
COPY --from=buildHelper scripts /tmp/tools/
RUN echo \
    && echo === TOOLS - prereqs \
    && bash -l /tmp/tools/install-prereqs.sh

RUN echo \
    && echo === TOOLS \
    && bash -l /tmp/tools/java/install.sh -v 17.0.7.0 \
    && bash -l /tmp/tools/maven/install.sh -v 3.9.4 -r http://astronauta.biruta.net:31000/repository/maven-public/ \
    && bash -l /tmp/tools/quarkus/install.sh -v 3.2.4 \
    && bash -l /tmp/tools/node/install.sh -v 18.17.1 \
    && echo ===


################################################
### User config
RUN useradd -m -s /bin/bash developer

USER developer
RUN mkdir ~/src \
    && mkdir ~/.m2

WORKDIR /home/developer/src

ENTRYPOINT [ "/bin/bash", "-l", "-c" ]

ONBUILD RUN for file in /etc/profile.d; do . ${file}; done
# ONBUILD ADD . /home/developer/src
