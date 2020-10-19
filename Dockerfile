FROM openjdk:8-jre-alpine
RUN apk update

RUN apk add git

RUN apk add nodejs
RUN apk add npm

RUN apk add postgresql-client

RUN apk add bash

RUN git clone https://github.com/rederly/backend.git

RUN mkdir liquibase
WORKDIR "/liquibase"
RUN wget https://jdbc.postgresql.org/download/postgresql-42.2.16.jar
RUN wget https://github.com/liquibase/liquibase/releases/download/v4.0.0/liquibase-4.0.0.zip
RUN unzip "liquibase-4.0.0.zip"

COPY db.backup /
COPY generate-diff.sh .
COPY reset-db.sql /

CMD ["/bin/bash", "generate-diff.sh"]
