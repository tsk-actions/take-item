
#
# @provider: github
#

source "${EXTRAS_DIR}/addons.bash"

export GITHUB_ORIGIN_URL='https://github.com'
export GITHUB_PROVIDER_NAME='github.com'

provider:github:repository_from_location() {
  local location="$1"
  local repository

  repository=$(echo "${location}" | cut -d: -f2)
  
  echo "${repository}"
}

provider:github:path_from_location() {
  local location="$1"
  local path

  path=$(echo "${location}" | cut -d: -f3)
  
  echo "${path}"
}

provider:github:download_from_location() {
  local location="$1"
  local repository
  local repository_url
  local repository_name
  local path
  local dest_path

  repository=$(provider:github:repository_from_location "${location}")
  repository_url="${GITHUB_ORIGIN_URL}/${repository}"


  x:task "Cloning repository[${repository_url}]"
  git clone "${repository_url}"
  
  path=$(provider:github:path_from_location "${location}")

  [[ -z "${path}" ]] && return # Skip the steps below if no given path

  repository_name="${repository_url##*/}"
  dest_path="${repository_name}/${path}"

  x:log "path: ${path}
  repository_name: ${path}
  dest_path: ${dest_path}
  "

  if [[ ! -d "${dest_path}" ]] && [[ ! -f "${dest_path}" ]]; then 
    x:err "Nothing found at path[${path}] on the given repository url[${repository_url}]" 
  fi

  x:task "Copying contents at path[${path}] to the current workdir"
  mv "${dest_path}" .

  x:task "Deleting remaining repository contents"
  rm -rf "${dest_path}"
}
