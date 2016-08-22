FROM ubuntu:14.04
MAINTAINER Yuji Takaesu
RUN apt-get update
RUN apt-get install -y \
    nginx \
    curl
CMD ["nginx", "-g", "daemon off;"]
