
#
# @provider: github
#


provider:github:repository_from_location() {
  local location="$1"
  local repository

  repository=$(echo "${location}" | cut -d: -f2)
  
  echo "${repository}"
}
