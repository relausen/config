eval "$(/opt/homebrew/bin/brew shellenv)"
if command -v rtx &> /dev/null; then
    if POETRY_BIN_PATH="$(rtx where poetry)/bin" &>/dev/null; then
        export PATH="${POETRY_BIN_PATH}:${PATH}"
    fi
fi
