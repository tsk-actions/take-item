#!/usr/bin/env bats

load "test_helper"

setup() {
  export DEFAULT_SOURCE_LOCATION_WITHOUT_PATH="github.com:lktslionel/mock-repo"
  export DEFAULT_REPOSITORY_NAME="lktslionel/mock-repo"
}

@test "it must get the repository name from the given source location w/o path" {
  run provider:github:repository_from_location "${DEFAULT_SOURCE_LOCATION_WITHOUT_PATH}"
  assert_equal "${output}" "${DEFAULT_REPOSITORY_NAME}"
}

# @test "it get the repository from github.com" {
#   cd "${BATS_TEST_TMPDIR}"
#   provider:github:get("${DEFAULT_SOURCE_LOCATION}")
# }

