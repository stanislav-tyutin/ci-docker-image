FROM alpine:3.14.2

RUN apk --no-cache add git==2.32.0-r0 openssh==8.6_p1-r3 openssl=1.1.1l-r0 && \
    mkdir -p ~/.ssh

COPY bin /bin
