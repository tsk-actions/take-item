
#
# @provider: github
#

export GITHUB_ORIGIN_URL='https://github.com'

provider:github:repository_from_location() {
  local location="$1"
  local repository

  repository=$(echo "${location}" | cut -d: -f2)
  
  echo "${repository}"
}

provider:github:download() {
  local location="$1"
  local repository

  repository=$(provider:github:repository_from_location "${location}")

  git clone "${GITHUB_ORIGIN_URL}/${repository}"
}
