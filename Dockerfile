FROM alpine:latest as build

ENV BURROW_RELEASE=1.1.0 BURROW_CHECKSUM=16f803ca88d5847cd387cb12002b5ab4324fb87448d6b9aef09e2c52ae1f77be

RUN apk add curl bash

RUN cd /tmp \
  && curl -sSf -L https://github.com/linkedin/Burrow/releases/download/v${BURROW_RELEASE}/Burrow_${BURROW_RELEASE}_linux_amd64.tar.gz -o burrow.tgz \
  && printf "%s  %s\n" "${BURROW_CHECKSUM}" "burrow.tgz" > /tmp/CHECKSUM \
  && sha256sum burrow.tgz \
  && ( cd /tmp; sha256sum -c CHECKSUM; ) \
  && tar -xzf burrow.tgz

# Not static: https://github.com/linkedin/Burrow/issues/307
FROM debian:latest
COPY --from=build /tmp/burrow /burrow
EXPOSE 8000
ENTRYPOINT ["/burrow"]
