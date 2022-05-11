#!/usr/bin/env bats

setup() {
  export ACTION_HOME_DIR="${ACTION_HOME_DIR}"
}


takeitem(){
  bash -c "${ACTION_HOME_DIR}/entrypoint.sh $*"
}


@test "it must take an entire github repository" {

}
