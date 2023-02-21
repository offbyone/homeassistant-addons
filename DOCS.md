# Home Assistant Add-on: IoT + LetEncrypt

## How to use

Before enabling this addon, you need to copy two device key files to `config/device-certs/`: a device certificate stored in `config/device-certs/device.pem.crt` and a device key stored in `config/device-certs/device.pem.key`. These files need to be retrieved from the AWS IoT service.

## Automating this

https://community.home-assistant.io/t/lets-encrypt-add-on-how-to-get-automatic-renewal/171236 has a thread on this. Use the cert expiry entity, and a sensor that triggers this when the certificate is close to expired
