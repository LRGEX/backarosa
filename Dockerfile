FROM ubuntu 
# this is the base image for the container 

ARG DUPLICATI_RELEASE 
# ARG is same as ENV but only for build time and not for runtime, so u cant use it as variable in the container

ENV DEBIAN_FRONTEND="noninteractive" \
    PATH=$PATH:/opt/backarosa \
    BACKAROSA_SOURCE="/source" \
    KEEP_VERSIONS="3" \
    TZ="Asia/Riyadh" 
# ENV is for runtime, so u can use it as variable in the container   

# RUN is for executing commands in the container while building the image
RUN apt-get update -y && apt-get upgrade -y && apt-get install -y \
    curl \
    jq \
    ca-certificates \
    gnupg \
    cron \
    lsb-release \
    tzdata && \
    # command below is for installing docker cli in the container so it can use dockersock to communicate with the host docker
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    apt update -y && apt install -y docker-ce-cli && \  
    # command below is for installing duplicati in the container and get the latest beta release
  echo "**** install duplicati ****" && \
  if [ -z ${DUPLICATI_RELEASE+x} ]; then \
    DUPLICATI_RELEASE=$(curl -sX GET "https://api.github.com/repos/duplicati/duplicati/releases" \
    | jq -r 'first(.[] | select(.tag_name | contains("beta"))) | .tag_name'); \
  fi && \
  duplicati_url=$(curl -s https://api.github.com/repos/duplicati/duplicati/releases/tags/"${DUPLICATI_RELEASE}" |jq -r '.assets[].browser_download_url' |grep '.deb$' |grep -v signatures) && \
  curl -o \
    /tmp/duplicati.deb -L \
    "${duplicati_url}" && \
  apt install /tmp/duplicati.deb -y && \
  echo "**** cleanup ****" && \
  apt-get clean && \
  rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/* && \
    mkdir /source && \
    find /opt/backarosa -type f -exec chmod +x {} \;
  

USER root
# USER is for setting the user that will be used to run the container
WORKDIR /opt/backarosa
# WORKDIR is for setting the working directory for the container
COPY scripts/ /opt/backarosa/
# COPY is for copying script files from what inside script folder (which contain all your scripts) the docker image while building the image
RUN chmod +x /opt/backarosa/docker-entrypoint.sh
ENTRYPOINT ["/opt/backarosa/docker-entrypoint.sh"]
# ENTRYPOINT is for setting the entrypoint for the container, so when u run the container it will run the script inside the entrypoint
# Basically this is the main script that will be executed when u run the container, and will run all the other scripts inside the image with exec "$@"
