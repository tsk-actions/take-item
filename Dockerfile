FROM alpine:3.15

RUN apk add --no-cache bash~=5.1 github-cli~=2.2


ENV EXTRAS_DIR ${HOME}/.extras
RUN mkdir -p ${EXTRAS_DIR}

COPY extras/addons.bash ${EXTRAS_DIR}

COPY source/rootfs/ /
RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]

