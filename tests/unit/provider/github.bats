#!/usr/bin/env bats

load "test_helper"

@test "it must get the repository name from the given source location w/o path" {
  run provider:github:repository_from_location "${DEFAULT_SOURCE_LOCATION_WITHOUT_PATH}"
  
  assert_equal "${output}" "${DEFAULT_REPOSITORY}"
}

@test "it must get the repository name from the given source location w/ path" {
  run provider:github:repository_from_location "${DEFAULT_SOURCE_LOCATION_WITH_PATH}"
  
  assert_equal "${output}" "${DEFAULT_REPOSITORY}"
}

@test "it must download the repository source from a given location w/o destination path" {
  cd "${BATS_TEST_TMPDIR}"
  provider:github:download_from_location "${DEFAULT_SOURCE_LOCATION_WITHOUT_PATH}"

  assert_dir_exists "${DEFAULT_REPOSITORY_NAME}"
}

@test "it must download the repository source from a given location w/ destination path" {
  cd "${BATS_TEST_TMPDIR}"
  provider:github:download_from_location "${DEFAULT_SOURCE_LOCATION_WITH_PATH}"

  assert_dir_exists "${DEFAULT_SOURCE_LOCATION_PATH}"
  assert_dir_not_exists "${DEFAULT_REPOSITORY}"
}

