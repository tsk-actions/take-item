
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
  local destination="${2:-.}"
  local repository
  local repository_url
  local repository_name
  local path
  local src_path

  repository=$(provider:github:repository_from_location "${location}")
  repository_url="${GITHUB_ORIGIN_URL}/${repository}"
  repository_name="${repository_url##*/}"

  x:log "
  repository: ${repository}
  repository_url: ${repository_url}
  repository_name: ${repository_name} 
  "

  x:task "Ensuring destination [${destination}] exists"
  mkdir -p ${destination}
  x:check $?

  x:task "Getting the path[${path}] from the location[${location}]"
  path=$(provider:github:path_from_location "${location}")
  x:check $?

  x:task "Setting the source and destination dirs/paths from path[${path}]"
  src_dir="$(mktemp -d)/${repository_name}"
  src_path="${src_dir}/${path}"
  destination="${destination}/"

  x:log "
  src_dir: ${src_dir}
  src_path: ${src_path}
  destination: ${destination}
  "

  x:task "Cloning repository[${repository_url}] contents to temp dir[${src_dir}]"
  git clone "${repository_url}" "${src_dir}"
  x:check $?

  shopt -o nullglob

  x:task "Getting contents from source path[${src_path}] to destination path[${destination}]"
  mv  "${src_path}" "${destination}"
  x:check $? "Failed to get source contents"

  x:task "Deleting temp dir[${src_dir}]"
  rm -rf "${src_dir}"  

} 
