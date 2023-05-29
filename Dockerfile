FROM ibm-semeru-runtimes:open-8-jre AS stage

RUN apt update && \
    apt install -y awscli

FROM ibm-semeru-runtimes:open-8-jre AS runtime
ARG EMBULK_VERSION=${EMBULK_VERSION:-"latest"}

WORKDIR /opt/embulk

COPY plugins.txt jars/ ./
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN curl -o embulk -L "https://dl.embulk.org/embulk-${EMBULK_VERSION}.jar" && \
    chmod +x ./embulk && \
    chmod +x /usr/local/bin/entrypoint.sh && \
    ./embulk gem install -g plugins.txt --clear-sources

COPY --from=stage /usr/bin/aws /usr/local/bin/aws

CMD ["--help"]
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]