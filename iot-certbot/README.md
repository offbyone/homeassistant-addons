# Home Assistant Add-on: IoT Thing + Certbot

_Register your Home Assistant as an IoT Thing and then use certbot + route53 to get certificates._

If you want Let's Encrypt with DNS challenge support on Route 53, but you never want to store long term AWS access keys on your Home Assistant, this addon is for you.

![Supports aarch64 Architecture][aarch64-shield]
![Supports amd64 Architecture][amd64-shield]
![Supports armhf Architecture][armhf-shield]
![Supports armv7 Architecture][armv7-shield]
![Supports i386 Architecture][i386-shield]

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
[armhf-shield]: https://img.shields.io/badge/armhf-yes-green.svg
[armv7-shield]: https://img.shields.io/badge/armv7-yes-green.svg
[i386-shield]: https://img.shields.io/badge/i386-yes-green.svg

## Why This?

There is already a very nice [letsencrypt Home Assitant addon](https://github.com/home-assistant/addons/blob/master/letsencrypt/README.md). Why not use that one, and instead this one?

Well, in my case, I _really_ don't want my HA instance exposed to the internet at all. I am using [tailscale](https://tailscale.com/) as a VPN, and my HA instance sits behind that, never directly able to handle HTTP requests. This keeps my network nice and secure, or secure-ish at any rate.

So, I need to use DNS challenges.

Now... the official Let's Encrypt addon _also_ does that. What it does, though, is require you to create a long-lived AWS credential with write access to your Route53 hosted zone, and then store it in HA configuration. That's fine, if you want, but I wanted something a bit closer to a production security model. So, what I have is based on ["Using AWS IoT to provision an IAM role for home lab devices"](https://offby1.website/posts/automating-letsencrypt-route53-using-aws-iot.html), where what I do is provide a one time device certificate to my HA instance, which allows it to get short-lived credentials for AWS that it can use consistently to renew the certificate.

If you're a bit extra paranoid and don't mind a more complex-than-usual HA certificate configuration, this addon might just be for you.
