#!/bin/bash

# 
# INITIALIZE
# 

# Panic on error
set -eo pipefail

__PROGRAM__=$(basename "$0")
__DEBUG_MODE_ENABLED__=true


# 
# IMPORTS
# 

# shellcheck disable=SC1091
source "${EXTRAS_DIR}/addons.bash"

# shellcheck disable=SC1091
source "${ACTION_HOME_DIR}/action.bash"

# 
# VARS
#


# 
# HELPERS
#


# 
# LOGIC
# 

x:task "entrypoint"

x:done