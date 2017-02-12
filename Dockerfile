FROM ubuntu:16.04

MAINTAINER Travis Holton <wtholton at gmail dot com>


RUN apt-get update && apt-get -y install \
      language-pack-en-base \
      libncurses5-dev \
      python3-nose2 \
      python3-pip \
      python3.5 \
      python3.5-dev

WORKDIR /usr/local/e2e-tests
COPY . /usr/local/e2e-tests
RUN pip3 install -r requirements.txt
ENV PYTHONPATH /usr/local/domain-api

ENTRYPOINT ["behave"]
