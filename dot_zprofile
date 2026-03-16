if [ -f /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
if command -v mise &> /dev/null; then
    if POETRY_BIN_PATH="$(mise where poetry)/bin" &>/dev/null; then
        export PATH="${POETRY_BIN_PATH}:${PATH}"
    fi
    if PYTHON_BIN_PATH="$(mise where python)/bin" &>/dev/null; then
        export PATH="${PYTHON_BIN_PATH}:${PATH}"
    fi
fi
if command -v gh &> /dev/null; then
    export HOMEBREW_GITHUB_API_TOKEN=$(gh auth token)
fi
