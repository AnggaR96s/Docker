#!/usr/bin/env bash

exit_script()
{
echo "Build was killed!"
sendTG "Docker image build was killed!"
}

trap exit_script SIGINT SIGTERM

function sendTG() {
    curl -s "https://api.telegram.org/bot${TELEGRAM_TOKEN}/sendmessage" --data "text=${*}&chat_id=-1001492198966&parse_mode=Markdown"
}

sendTG "\`Docker image is being updated!\`"

docker build . -t dasbastard/slim-buster:dclxvi
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
docker push dasbastard/slim-buster:dclxvi

sendTG "\`I have pushed new images to docker\` %0A [Images are Here](https://hub.docker.com/r/dasbastard/slim-buster)"
