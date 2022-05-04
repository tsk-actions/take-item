





FROM bats/bats:latest as test

RUN apk add curl vim git github-cli

RUN git clone https://github.com/ztombol/bats-support $HOME/.bats/test_helper/bats-support
RUN git clone https://github.com/ztombol/bats-assert $HOME/.bats/test_helper/bats-assert
RUN git clone https://github.com/bats-core/bats-file $HOME/.bats/test_helper/bats-file