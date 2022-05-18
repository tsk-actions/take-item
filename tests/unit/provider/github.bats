#!/usr/bin/env bats

load "test_helper"


@test "it must get the repository name from the given source location w/o path" {
  run provider:github:repository_from_location "${DEFAULT_SOURCE_LOCATION_WITHOUT_PATH}"  3>/dev/null
  
  assert_equal "${output}" "${DEFAULT_REPOSITORY}"
}

@test "it must get the repository name from the given source location w/ path" {
  run provider:github:repository_from_location "${DEFAULT_SOURCE_LOCATION_WITH_PATH}"  3>/dev/null
  
  assert_equal "${output}" "${DEFAULT_REPOSITORY}"
}

@test "it must download the content of the entire given repository w/o path" {
  cd "${BATS_TEST_TMPDIR}"
  run provider:github:download_from_location "${DEFAULT_SOURCE_LOCATION_WITHOUT_PATH}" 3>/dev/null

  assert_file_exists "docs/docs-README.md"
  assert_file_exists "README.md"
  assert_file_exists "LICENSE"
}

@test "it must download the repository from a given location w/ path" {
  cd "${BATS_TEST_TMPDIR}"
  run provider:github:download_from_location "github.com:lktslionel/mock-repo:." 3>/dev/null

  assert_dir_exists "docs"
}

@test "it must download a file from a repository at a given location w/ path" {
  cd "${BATS_TEST_TMPDIR}"
  run provider:github:download_from_location "github.com:lktslionel/mock-repo:docs/docs-README.md" 3>/dev/null

  assert_file_exists "docs-README.md"
}

@test "it must download a file from a repository at a given location w/ path to a given destination" {
  cd "${BATS_TEST_TMPDIR}"
  run provider:github:download_from_location  "github.com:lktslionel/mock-repo:docs/docs-README.md" "dst/default/dir"  3>/dev/null

  assert_file_exists "dst/default/dir/docs-README.md"
}

@test "it must download a directory from a repository at a given location w/ path to a given destination" {
  cd "${BATS_TEST_TMPDIR}"
  
  run provider:github:download_from_location "github.com:lktslionel/mock-repo:docs" "dst/default/dir"
  assert_file_exists "dst/default/dir/docs-README.md"
}

