#! /bin/bash

if [ -z "$PX4_DOCKER_REPO" ]; then
	PX4_DOCKER_REPO=px4io/px4-dev-nuttx:2017-01-12
fi

PWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
SRC_DIR=$PWD/../

CCACHE_DIR=${HOME}/.ccache
mkdir -p ${CCACHE_DIR}

docker run -it --rm -w ${SRC_DIR} \
	-v ${SRC_DIR}:${SRC_DIR}:rw \
	-v /tmp/.X11-unix:/tmp/.X11-unix:ro \
	-v ${CCACHE_DIR}:${CCACHE_DIR}:rw \
	-e CCACHE_DIR=${CCACHE_DIR} \
	-e AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} \
	-e AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} \
	-e TRAVIS_BRANCH=${TRAVIS_BRANCH} \
	-e TRAVIS_BUILD_ID=${TRAVIS_BUILD_ID} \
	-e LOCAL_USER_ID=`id -u` \
	${PX4_DOCKER_REPO} /bin/bash -c "$@"
