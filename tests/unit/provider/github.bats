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

@test "it must download the repository from a given location w/o destination path" {
  cd "${BATS_TEST_TMPDIR}"
  run provider:github:download_from_location "${DEFAULT_SOURCE_LOCATION_WITHOUT_PATH}" 3>/dev/null

  assert_dir_exists "${DEFAULT_REPOSITORY_NAME}"
}

@test "it must download the repository from a given location w/ path" {
  cd "${BATS_TEST_TMPDIR}"
  run provider:github:download_from_location "${DEFAULT_SOURCE_LOCATION_WITH_PATH}" 3>/dev/null

  assert_dir_exists "${DEFAULT_SOURCE_LOCATION_PATH}"
  assert_dir_not_exists "${DEFAULT_REPOSITORY}"
}

@test "it must download a file from a repository at a given location w/ path" {
  cd "${BATS_TEST_TMPDIR}"
  run provider:github:download_from_location "${DEFAULT_SOURCE_LOCATION_WITH_FILE_PATH}" 3>/dev/null

  assert_file_exists "${DEFAULT_SOURCE_LOCATION_FILE}"
  assert_dir_not_exists "${DEFAULT_REPOSITORY}"
}

@test "it must download a file from a repository at a given location w/ path to a given destination" {
  cd "${BATS_TEST_TMPDIR}"
  run provider:github:download_from_location "${DEFAULT_SOURCE_LOCATION_WITH_FILE_PATH}" "${DEFAULT_DESTINATION_DIR}" 3>/dev/null

  assert_file_exists "${DEFAULT_DESTINATION_DIR}/${DEFAULT_SOURCE_LOCATION_FILE}"
  assert_dir_not_exists "${DEFAULT_REPOSITORY}"
}

@test "it must download a directory from a repository at a given location w/ path to a given destination" {
  cd "${BATS_TEST_TMPDIR}"
  
  run provider:github:download_from_location "github.com:lktslionel/mock-repo:docs/*" "${DEFAULT_DESTINATION_DIR}"
  tree . -L 4
  assert_file_exists "${DEFAULT_DESTINATION_DIR}/${DEFAULT_SOURCE_LOCATION_FILE}"
  assert_dir_not_exists "${DEFAULT_REPOSITORY}"
}

