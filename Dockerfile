FROM jmoalves/docker-dev as buildHelper

FROM jmoalves/sample-app-build as builder

USER root

RUN rm -rf /tmp/src
COPY . /tmp/src
RUN chown -R developer.developer /tmp/src

USER developer
WORKDIR /tmp/src
RUN bash -l -c "mvn clean package"



FROM ubuntu:22.04

################################################
### TOOLS
COPY --from=buildHelper scripts /tmp/tools/
RUN echo \
    && echo === TOOLS - prereqs \
    && bash -l /tmp/tools/install-prereqs.sh

RUN echo \
    && echo === TOOLS \
    && bash -l /tmp/tools/java/install.sh -v 17.0.7.0 \
    && bash -l /tmp/tools/liberty/install.sh -v 23.0.0.7 -f openliberty -b kernel \
    && echo ===

RUN mkdir -p /var/liberty/usr
ENV WLP_USER_DIR /var/liberty/usr
RUN bash -l -c "/usr/local/wlp/bin/server create defaultServer"

COPY --from=builder /tmp/src/back/target/sample-complete-sw-war-0.0.1-SNAPSHOT.war /var/liberty/usr/app.war
COPY --from=builder /tmp/src/back/src/main/liberty/server.xml /var/liberty/usr/servers/defaultServer/server.xml
RUN mv /var/liberty/usr/app.war /var/liberty/usr/servers/defaultServer/dropins/app.war
RUN bash -l /tmp/tools/liberty/features.sh defaultServer

EXPOSE 9080

ENTRYPOINT [ "/bin/bash", "-l", "-c", "/usr/local/wlp/bin/server run defaultServer" ]
