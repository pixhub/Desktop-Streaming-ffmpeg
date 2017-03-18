FROM ubuntu:16.04
        ENV DEBIAN_FRONTEND noninteractive
        ENV PATH $PATH:/usr/local/nginx/sbin

        EXPOSE 1935
        EXPOSE 80

        RUN apt-get update && apt-get upgrade -y --no-install-recommends && apt-get install -y --no-install-recommends zlib1g-dev build-essential libpcre3 libpcre3-dev libssl-dev gcc wget git
        WORKDIR /tmp
        RUN git clone git://github.com/arut/nginx-rtmp-module.git
        RUN wget http://nginx.org/download/nginx-1.10.2.tar.gz
        RUN tar xzvf nginx-1.10.2.tar.gz
        WORKDIR /tmp/nginx-1.10.2
        RUN ./configure --with-http_ssl_module --add-module=/tmp/nginx-rtmp-module && make && make install
        CMD "nginx"
