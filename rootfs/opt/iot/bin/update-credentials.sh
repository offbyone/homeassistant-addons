#!/usr/bin/with-contenv bashio
set -eu -o pipefail
#set -x
#bashio::log.level all

IOT_THING_NAME=$(bashio::config 'iot.thing_name')
IOT_ROLE_ALIAS=$(bashio::config 'iot.role_alias')
IOT_ENDPOINT_URL=$(bashio::config 'iot.endpoint_url')

CERT_ROOT=/config/device-certs
CREDENTIAL_JSON=/opt/iot/credentials/latest.json
CREDENTIAL_FILE=/opt/iot/credentials/default

curl -o "$CREDENTIAL_JSON" \
    --cert "$CERT_ROOT/device.pem.crt" \
    --key "$CERT_ROOT/device.pem.key" \
    --cacert "/opt/iot/certs/AmazonRootCA1.pem" \
    -H "x-amzn-iot-thingname: $IOT_THING_NAME" \
    "$IOT_ENDPOINT_URL/role-aliases/$IOT_ROLE_ALIAS/credentials"

AWS_ACCESS_KEY_ID="$(jq -r -e '.credentials.accessKeyId' <"$CREDENTIAL_JSON")"
AWS_SECRET_ACCESS_KEY="$(jq -r -e '.credentials.secretAccessKey' <"$CREDENTIAL_JSON")"
AWS_SESSION_TOKEN="$(jq -r -e '.credentials.sessionToken' <"$CREDENTIAL_JSON")"

cat <<EOF >$CREDENTIAL_FILE.tmp
[default]
aws_access_key_id=$AWS_ACCESS_KEY_ID
aws_secret_access_key=$AWS_SECRET_ACCESS_KEY
aws_session_token=$AWS_SESSION_TOKEN
EOF

mv $CREDENTIAL_FILE.tmp $CREDENTIAL_FILE

chmod 640 "$CREDENTIAL_FILE" "$CREDENTIAL_JSON"
