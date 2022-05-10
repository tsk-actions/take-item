FROM alpine:3.15

RUN apk add --no-cache bash~=5.1 github-cli~=2.2

ENV ACTION_HOME_DIR=${HOME}/action
RUN mkdir -p ${ACTION_HOME_DIR}

ENV EXTRAS_DIR ${ACTION_HOME_DIR}/extras
COPY extras/addons.bash ${EXTRAS_DIR}


COPY source/rootfs/ ${ACTION_HOME_DIR}
RUN chmod +x ${ACTION_HOME_DIR}/entrypoint.sh

ENTRYPOINT [ "${ACTION_HOME_DIR}/entrypoint.sh" ]

