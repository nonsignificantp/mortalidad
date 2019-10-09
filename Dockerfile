FROM rocker/verse:latest

RUN apt-get update \
  && apt-get install apt-transport-https tree \
  && wget https://dvc.org/deb/dvc.list -O /etc/apt/sources.list.d/dvc.list \
  && apt-get update \
  && apt-get install dvc \
  && install2.r --error \
     --deps TRUE \
     MLmetrics
