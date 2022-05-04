FROM alpine:3.15

RUN apk add --no-cache bash~=5.1 github-cli~=2.2

ENV EXTRAS_DIR /opt/extras

COPY rootfs/ /
RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]

