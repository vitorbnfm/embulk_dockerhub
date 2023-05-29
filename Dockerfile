FROM amazoncorretto:8

ARG EMBULK_VERSION=${EMBULK_VERSION:-"latest"}


RUN yum -y update &&\
    yum -y install unzip &&\
    amazon-linux-extras install ruby2.6 &&\
    yum -y clean metadata &&\
    yum -y install ruby ruby-devel &&\
    curl --create-dirs -o /opt/embulk/embulk -L "https://dl.embulk.org/embulk-${EMBULK_VERSION}.jar"
    
WORKDIR /opt/embulk

COPY ["install_plugins.sh", "plugins.txt", "./"]
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x ./embulk &&\
    chmod +x ./install_plugins.sh &&\
    chmod +x /usr/local/bin/entrypoint.sh &&\
    ./install_plugins.sh

CMD ["--help"]
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
