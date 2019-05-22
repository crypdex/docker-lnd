# This here is an image appropriate for building multiarch images.
#
# The strategy here is to use a manifest at the upper level and feed
# in the image name. Running Docker on ARM is easiest to work with when
# the base images use ARM OSs.

# Base image default is x86:
# debian:stable-slim | arm64v8/debian:stable-slim
ARG IMAGE=debian:stable-slim

FROM ${IMAGE} as builder

LABEL maintainer.0="David Michael"

# Not sure why this needs to be declared after the IMAGE
# amd64 | arm64
ARG ARCH
ENV VERSION="0.6.1-beta"

RUN apt-get update -y \
  && apt-get install -y curl git build-essential \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /tmp

RUN git clone https://github.com/ncopa/su-exec.git \
  && cd su-exec && make

RUN curl -SLO https://github.com/lightningnetwork/lnd/releases/download/v${VERSION}/lnd-linux-${ARCH}-v${VERSION}.tar.gz \
  && tar --strip=1 -xzf *.tar.gz \
  && rm *.tar.gz

FROM ${IMAGE}

# Copy over the artifacts

COPY --from=builder /tmp/su-exec/su-exec /usr/local/bin/
COPY --from=builder /tmp/lncli /usr/local/bin/
COPY --from=builder /tmp/lnd /usr/local/bin/

COPY entrypoint.sh /entrypoint.sh

RUN useradd -r lightning

VOLUME ["/home/lightning/data"]

EXPOSE 44440 44444

ENTRYPOINT ["/entrypoint.sh"]

CMD ["lnd"]
