ARG version=latest
FROM theiaide/theia:$version

# We need to add openssl to be able to create the certificates on demand
USER root
RUN apk update && apk add openssl
RUN npm install -g gen-http-proxy
USER theia

# RUN mkdir /home/theia/ssl && chown theia /home/theia/ssl 
ADD ssl_theia.sh /home/theia/ssl/
WORKDIR /home/theia/ssl

ARG LISTEN_PORT=10443

# Run theia and accept theia parameters
ENV staticfolder /usr/local/lib/node_modules/gen-http-proxy/static 
ENV server :$LISTEN_PORT
ENV secure 1 
ENTRYPOINT [ "/home/theia/ssl/ssl_theia.sh" ]
