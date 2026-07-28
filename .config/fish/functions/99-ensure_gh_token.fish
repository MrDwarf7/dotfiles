#!/usr/bin/env fish
#

set -g GH_TOKEN_CACHE_FILE "$HOME/.secret/.gh_token_cache"

function 99-ensure_gh_token --argument-names __cached_gh_token_done
    set -q __cached_gh_token_done; and return 0 # If already done, return early

    # Priority 1: Use GH_TOKEN from environment if set and non-empty
    # If cache file missing, create it (env takes temporary precedence, but doesn't overwrite existing cache)
    if set -q GH_TOKEN && test -n "$GH_TOKEN"
        if not test -e "$GH_TOKEN_CACHE_FILE"
            printf '%s' "$GH_TOKEN" >"$GH_TOKEN_CACHE_FILE"
        end
        set -gx GITHUB_TOKEN "$GH_TOKEN"
        return 0
    end

    # Priority 1 alt: Fall back to GITHUB_TOKEN from environment if set and non-empty
    if set -q GITHUB_TOKEN && test -n "$GITHUB_TOKEN"
        set -gx GH_TOKEN "$GITHUB_TOKEN"
        if not test -e "$GH_TOKEN_CACHE_FILE"
            printf '%s' "$GH_TOKEN" >"$GH_TOKEN_CACHE_FILE"
        end
        return 0
    end

    # Priority 2: Use cached token if file exists and contains a non-empty value
    if test -e "$GH_TOKEN_CACHE_FILE"
        set -l token
        if read token <"$GH_TOKEN_CACHE_FILE"
            set token (string trim "$token")
            if test -n "$token"
                set -gx GH_TOKEN "$token"
                return 0
            end
        end
    end

    # Priority 3: Fetch fresh token via gh CLI and cache it
    set -gx GH_TOKEN (gh auth token)
    set -gx GITHUB_PERSONAL_ACCESS_TOKEN "$GH_TOKEN"
    printf '%s' "$GH_TOKEN" >"$GH_TOKEN_CACHE_FILE"
end
