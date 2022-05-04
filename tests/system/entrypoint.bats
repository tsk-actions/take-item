#!/usr/bin/env bats

setup() {
  export ACTION_ROOT_DIR="${BATS_TEST_DIRNAME}/../.."
}


takeitem(){
  bash -c "${ROOT_DIR}/source/rootfs/entrypoint.sh"
}


@test "it fail when \$src_dir and \$dst_tarball are unbound" {