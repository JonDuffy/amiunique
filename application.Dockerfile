FROM openjdk:8

EXPOSE 9000/tcp
EXPOSE 8888/tcp
EXPOSE 80/tcp
EXPOSE 443/tcp

EXPOSE 8888/udp
EXPOSE 80/udp
EXPOSE 443/udp
EXPOSE 9000/tcp

EXPOSE 3306/tcp

ENV DBADDRESS=
ENV DBNAME=
ENV DBPASS=
ENV DBUSER=


# install scala build tool (fedora)
# RUN curl https://bintray.com/sbt/rpm/rpm | tee /etc/yum.repos.d/bintray-sbt-rpm.repo
# RUN yum install -y sbt

# debian
RUN echo "deb https://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 642AC823
RUN apt-get update
RUN apt-get install sbt


# copy in code

COPY ./website /opt/temp/amiuniqe

RUN cd /opt/temp/amiuniqe

# RUN sbt clean compile
# RUN sbt assembly

# RUN  /opt/site/amiuniqe/activator play-update-secret

WORKDIR "/opt/temp/amiuniqe/"

RUN ["bash", "activator", "dist"]

RUN mkdir -p /opt/site/amiunique

RUN unzip /opt/temp/amiuniqe/target/universal/website-1.0-SNAPSHOT.zip -d /opt/site/amiunique

RUN ls -al /opt/site/amiunique/website-1.0-SNAPSHOT/bin

CMD ["bash", "/opt/site/amiunique/website-1.0-SNAPSHOT/bin/website", "-Dhttp.address=0.0.0.0", "-Dhttp.port=8888"]