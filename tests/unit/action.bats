#!/usr/bin/env bats


load "../test_helper"

load "${ACTION_HOME_DIR}/action.bash"


@test "it must get the provider name from a github location w/o path" {
  run action:provider_from_location "github.com:lktslionel/mock-repo" 3>/dev/null
  
  assert_equal "${output}" "${GITHUB_PROVIDER_NAME}"
}

@test "it must get the provider name from a github location w/ path" {
  run action:provider_from_location "github.com:lktslionel/mock-repo" 3>/dev/null
  
  assert_equal "${output}" "${GITHUB_PROVIDER_NAME}"
}

@test "it must set the 'file' provider name as default if missing provider from location" {
  run action:provider_from_location "resource-name-wo-provider" 3>/dev/null
  
  assert_equal "${output}" "${ACTION_DEFAULT_PROVIDER}"
}

@test "it must fail to get the provider name if the given location has an unknown provider" {
  run action:provider_from_location "unknown:resource-name-wo-provider" 3>/dev/null
  
  assert_failure
}

@test "it must download the entire source from a given valid location w/o a path" {
  cd "${BATS_TEST_TMPDIR}"
  run action:download_from_location "github.com:lktslionel/mock-repo" 3>/dev/null

  assert_dir_exists "docs"
  assert_file_exists "docs/docs-README.md"
  assert_file_exists "README.md"
  assert_file_exists "LICENSE"
}

@test "it must download the source contents a the given path from a given valid location" {
  cd "${BATS_TEST_TMPDIR}"
  run action:download_from_location "github.com:lktslionel/mock-repo:docs" 3>/dev/null

  assert_file_exists "docs-README.md"
}

@test "it must download to a specific destination, the contents at the given path from a given valid location" {
  cd "${BATS_TEST_TMPDIR}"
  run action:download_from_location "github.com:lktslionel/mock-repo:docs" "temp/docs" 3>/dev/null

  assert_dir_exists "temp/docs"
  assert_file_exists "temp/docs/docs-README.md"
}