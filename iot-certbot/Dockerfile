ARG BUILD_FROM
FROM $BUILD_FROM

# setup base
ARG \
    BUILD_ARCH \
    CRYPTOGRAPHY_VERSION \
    CERTBOT_VERSION

# py3-pip is kept in the installation because otherwise it removes some dependencies
# that we need (six)
RUN \
    set -x \
    && apk add --no-cache --update \
        augeas \
        curl \
        libffi \
        musl \
        openssl \
        py3-pip \
        python3 \
    && apk add --no-cache --virtual .build-dependencies \
        augeas-dev \
        build-base \
        cargo \
        libffi-dev \
        musl-dev \
        openssl-dev \
        python3-dev \
    && python3 -mvenv /opt/certbot \
    && /opt/certbot/bin/python -mpip install --no-cache-dir --find-links \
        "https://wheels.home-assistant.io/alpine-$(cut -d '.' -f 1-2 < /etc/alpine-release)/${BUILD_ARCH}/" \
        cryptography==${CRYPTOGRAPHY_VERSION} \
        certbot==${CERTBOT_VERSION} \
        certbot-dns-route53==${CERTBOT_VERSION} \
    && apk del .build-dependencies

# Copy data
COPY rootfs /

# force certbot binary into the "right" place
RUN ln -s /opt/certbot/bin/certbot /usr/bin/certbot
