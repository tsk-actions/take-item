#!/usr/bin/env bats

setup() {
  export ACTION_HOME_DIR="${ACTION_HOME_DIR}"
}


takeitem(){
  bash -c "${ACTION_HOME_DIR}/entrypoint.sh $*"
}


@test "it must take an entire github repository" {

}

@test "it must take a specific folder from a given github repository" {

}
