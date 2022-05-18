
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
  local destination="${2}"
  local repository
  local repository_url
  local repository_name
  local path
  local source
  local workdir
  local current_dir

  current_dir="$(pwd)"

  repository=$(provider:github:repository_from_location "${location}")
  repository_url="${GITHUB_ORIGIN_URL}/${repository}"
  repository_name="${repository_url##*/}"

  x:log "
  location: ${location}
  repository: ${repository}
  repository_url: ${repository_url}
  repository_name: ${repository_name} 
  "

  destination="${current_dir}/${destination}"

  x:task "Ensuring destination [${destination}] exists"
  mkdir -p "${destination}"

  path=$(provider:github:path_from_location "${location}")
  path=${path:-.}
  x:log "path: ${path}"

  x:task "Creating a temp workdir folder"
  workdir="$(mktemp -d)"

  x:task "Cloning repository[${repository_url}] contents to temp dir[${workdir}]"
  git clone "${repository_url}" "${workdir}"
  x:check $?

  x:task "Compurte source dir from which contents will be copied"
  source="${workdir}/${path}"
  x:log "source: ${source}"

  x:task "Copy contents from source path[${source}] to destination[${destination}]"
  [[ -d "${source}" ]] && cp -rf "${source}/." "${destination}"
  [[ -f "${source}" ]] && cp -rf "${source}" "${destination}"
  x:check $?

  x:log "current dir contents: $(tree .)"
  x:log "source contents: $(tree "${source}")"
  x:log "destination contents: $(tree "${destination}")"

  x:task "Deleting temp dir[${workdir}]"
  rm -rf "${workdir}"  

} 
