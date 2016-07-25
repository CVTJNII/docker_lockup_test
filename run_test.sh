#!/bin/bash

if [ -n "$1" ]; then
    count=$1
else
    count=10000
fi

if [ -n "$2" ]; then
    concurrency=$2
else
    concurrency=25
fi


# Double check kernel
if [ -z "$(uname -a | grep '4.2.0-42')" ]; then
    echo "ERROR: unexpected kernel, expected 4.2.0-42"
    exit 1
fi

# Docker access sanity
docker ps 2>&1 >/dev/null
if [ $? -ne 0 ]; then
    echo "ERROR: Failed to run 'docker ps'.  Check permissions (sudo?)"
    exit 1
fi

# Start fresh: Remove all existing containers
docker ps -a | tail -n +2 | awk '{print $1}' | xargs -r docker rm -f

# Pull the container
CONTAINER='ubuntu'
docker pull $CONTAINER || exit 1

# Run the reproduction command from https://github.com/docker/docker/issues/19758
echo "************************ Running reproduction command ************************"
echo "Count: ${count}   concurrency: ${concurrency}"
for((n=1;$n<${concurrency};n++)); do
    for((f=1;$f<=${count};f++)); do docker run --rm $CONTAINER echo "SET $n: $f"; done &
done
for((f=1;$f<=${count};f++)); do docker run --rm $CONTAINER echo "SET $n: $f"; done

echo ""
echo "************************ Complete ************************"
echo ""
echo "Running df (This should hang if 19758 reproduced)"
df -h /
echo "df returned: FAILED TO REPRODUCE"
exit 1
