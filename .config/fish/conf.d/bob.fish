if test -d "$HOME/.local/share/bob/env"
    set -gx BOB_ENV_DIR "$HOME/.local/share/bob/env"
    source "$BOB_ENV_DIR/env.fish"
end
