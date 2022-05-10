source "${EXTRAS_DIR}/addons.bash"

export ACTION_SOURCE_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source "${ACTION_SOURCE_DIR}/provider/github.bash"

export ACTION_DEFAULT_PROVIDER='file'
export ACTION_SUPPORTED_PROVIDERS="file:${GITHUB_PROVIDER_NAME}"


# shellcheck disable=SC1091


action:resource_from_location() {
  local resource
  
  resource=$(echo "${location}" | cut -d: -f2)

  echo "${resource}"
}

action:provider_from_location() {
  local location="$1"
  local provider
  local resource

  resource=$(action:resource_from_location "${location}")
  provider="$(echo "${location}" | cut -d: -f1)"

  x:log "resource: ${resource}
  provider: ${provider}
  "

  if [[ -z "${provider}" ]] || [[ "${provider}" == "${resource}" ]]; then 
    provider="${ACTION_DEFAULT_PROVIDER}"
  fi

  if ! action:is_provider_supported "${provider}"; then 
    x:err "Provider[${provider}] not supported. Available providers are: ${ACTION_SUPPORTED_PROVIDERS//:/, }"
  fi 

  echo "${provider}"
}

action:is_provider_supported() {
  local provider="$1"

  if [[ "${ACTION_SUPPORTED_PROVIDERS}" == *"${provider}"* ]]; then 
    return 0
  else
    return 1
  fi
}

action:download_from_location() {
  local location="$1"
  local path
  local provider
  
  provider="$(action:provider_from_location "${location}")"

  case ${provider} in
    github.com)
      provider:github:download_from_location "${location}"
      ;;
  esac

}