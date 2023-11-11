ARG BUILD_FROM
FROM $BUILD_FROM AS build

# setup base
ARG \
    BUILD_ARCH \
    CRYPTOGRAPHY_VERSION \
    CERTBOT_VERSION

# py3-pip is kept in the installation because otherwise it removes some dependencies
# that we need (six)
RUN apk add --no-cache --update \
        augeas \
        curl \
        libffi \
        musl \
        openssl \
        py3-pip \
        python3
RUN apk add --no-cache --virtual .build-dependencies \
        augeas-dev \
        build-base \
        cargo \
        libffi-dev \
        musl-dev \
        openssl-dev \
        python3-dev
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
RUN python3 -mvenv /opt/certbot
RUN /opt/certbot/bin/python -mpip install --no-cache-dir --find-links \
        "https://wheels.home-assistant.io/alpine-$(cut -d '.' -f 1-2 < /etc/alpine-release)/${BUILD_ARCH}/" \
        cryptography==${CRYPTOGRAPHY_VERSION} \
        certbot==${CERTBOT_VERSION} \
        certbot-dns-route53==${CERTBOT_VERSION}

FROM $BUILD_FROM

# Install the runtime dependencies in this layer
RUN apk add --no-cache --update \
        augeas \
        curl \
        libffi \
        musl \
        openssl \
        py3-pip \
        python3

# Copy virtualenv
COPY --from=build /opt/certbot /opt/certbot

# Copy data
COPY rootfs /

# force certbot binary into the "right" place
RUN ln -s /opt/certbot/bin/certbot /usr/bin/certbot
