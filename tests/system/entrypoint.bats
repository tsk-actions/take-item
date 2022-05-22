#!/usr/bin/env bats

load "../test_helper"

load "${ACTION_HOME_DIR}/action.bash"

setup() {
  export ACTION_HOME_DIR="${ACTION_HOME_DIR}"
}


takeitem(){
  bash -c "${ACTION_HOME_DIR}/entrypoint.sh $*"
}


@test "it must take an github repository w/o specifying a path" {
  run takeitem --source "${DEFAULT_SOURCE_LOCATION_WITHOUT_PATH}"
}
