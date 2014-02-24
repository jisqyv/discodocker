FROM ubuntu
MAINTAINER gijs@pythonic.nl
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -y curl erlang-base git make python erlang-parsetools erlang-inets erlang-dev

ADD scripts /scripts

##RUN /scripts/discodev.sh
RUN /scripts/discostable.sh

