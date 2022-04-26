FROM alpine:3.15

ENV BURROW_VERSION=1.5.0 BURROW_SHA256SUM=7ea58c64deb0c4681863c29cc3ee36c8556a82c58ec726152bcc7fc23a357921

RUN set -x \
  && apk add --no-cache curl bash ca-certificates \
  && wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub \
  && wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.35-r0/glibc-2.35-r0.apk \
  && apk add glibc-2.35-r0.apk \
  && rm -f glibc-2.35-r0.apk \
  && adduser -D -s /bin/bash user \
  ;

RUN set -x \
  && cd /tmp \
  && curl -sSf -L https://github.com/linkedin/Burrow/releases/download/v${BURROW_VERSION}/Burrow_${BURROW_VERSION}_linux_amd64.tar.gz -o burrow.tgz \
  && printf "%s  %s\n" "${BURROW_SHA256SUM}" "burrow.tgz" > /tmp/SHA256SUM \
  && ( cd /tmp; sha256sum -c SHA256SUM || ( echo "Expected $(sha256sum burrow.tgz)"; exit 1; )) \
  && tar -xzf burrow.tgz \
  && cp /tmp/burrow /burrow \
  && rm -rf /tmp/* \
  ;

EXPOSE 8000
WORKDIR /tmp
USER user
ENTRYPOINT ["/burrow"]
CMD ["--config-dir=/conf"]
