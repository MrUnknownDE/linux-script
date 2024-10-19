# Use debian:bookworm-slim as base image
FROM debian:bookworm

# Set the working directory
WORKDIR /app

# Install any necessary packages
RUN apt-get update \
&& apt-get install curl -y \
&& curl "https://raw.githubusercontent.com/MrUnknownDE/linux-script/main/sh_scripts/repos/debian-12.txt" -o /etc/apt/sources.list \
&& apt-get update && apt-get upgrade -y \ 
&& apt-get install wget lsb-release -y

# Install ATProtocol (aka. BlueskyNode)
RUN wget https://raw.githubusercontent.com/bluesky-social/pds/main/installer.sh
RUN bash installer.sh

