FROM alpine:latest as build

ENV BURROW_VERSION=1.2.2 BURROW_CHECKSUM=70ef622ba565e92c1193bfad34a09f09435d6262a371f9599113f4fe9d5c4fe8

RUN set -x \
  && apk add --no-cache curl bash ca-certificates \
  && wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub \
  && wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.29-r0/glibc-2.29-r0.apk \
  && apk add glibc-2.29-r0.apk \
  && adduser -D -s /bin/bash user \
  ;

RUN set -x \
  && cd /tmp \
  && curl -sSf -L https://github.com/linkedin/Burrow/releases/download/v${BURROW_VERSION}/Burrow_${BURROW_VERSION}_linux_amd64.tar.gz -o burrow.tgz \
  && printf "%s  %s\n" "${BURROW_CHECKSUM}" "burrow.tgz" > /tmp/CHECKSUM \
  && sha256sum burrow.tgz \
  && ( cd /tmp; sha256sum -c CHECKSUM; ) \
  && tar -xzf burrow.tgz \
  && cp /tmp/burrow /burrow \
  && rm -rf /tmp/* \
  ;

EXPOSE 8000
WORKDIR /tmp
USER user
CMD ["/burrow", "--config-dir=/conf"]
