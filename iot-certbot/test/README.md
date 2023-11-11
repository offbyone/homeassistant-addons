# Test data for the container.

This directory can be used to provide the necessary set of mounts for the container to act "home-assistant-ish".

Here's a shell invocation that runs this container:

``` shellsession
docker run --rm -it \
    -v (pwd)/test/ssl:/ssl \
    -v (pwd)/test/data:/data \
    -v (pwd)/test/cache:/tmp/.bashio/ \
    -v (pwd)/test/config:/config \
    --name iot-certbot local/iot_certbot
```

You should set up the necessary addon config in `test/cache` (there's an example in there that I have _not_ done the necessary work to correct, sorry :( )
