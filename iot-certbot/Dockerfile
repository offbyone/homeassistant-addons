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
        libffi \
        musl \
        openssl \
        curl \
        python3 \
        py3-pip \
    && apk add --no-cache --virtual .build-dependencies \
        build-base \
        libffi-dev \
        musl-dev \
        openssl-dev \
        cargo \
        python3-dev \
    && pip3 install --no-cache-dir --find-links \
        "https://wheels.home-assistant.io/alpine-$(cut -d '.' -f 1-2 < /etc/alpine-release)/${BUILD_ARCH}/" \
        cryptography==${CRYPTOGRAPHY_VERSION} \
        certbot==${CERTBOT_VERSION} \
        certbot-dns-route53==${CERTBOT_VERSION} \
    && apk del .build-dependencies

# Copy data
COPY rootfs /
