#
# EXPORTS
#

export BATS_HELPERS_DIR="${HOME}/.bats/test_helper"

export DEFAULT_SOURCE_LOCATION_WITHOUT_PATH="github.com:lktslionel/mock-repo"
export DEFAULT_SOURCE_LOCATION_WITH_PATH="github.com:lktslionel/mock-repo:src"
export LOCATION_WITH_UNKNOWN_PROVIDER="unknown:lktslionel/mock-repo:src"
export DEFAULT_REPOSITORY="lktslionel/mock-repo"
export DEFAULT_REPOSITORY_NAME="${DEFAULT_REPOSITORY#*/}"

#
# BATS MODULES
#

load "${BATS_HELPERS_DIR}/bats-assert/load.bash"
load "${BATS_HELPERS_DIR}/bats-support/load.bash"
load "${BATS_HELPERS_DIR}/bats-file/load.bash"
