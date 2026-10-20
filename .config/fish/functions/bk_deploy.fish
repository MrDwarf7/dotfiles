#!/usr/bin/env fish
#

function __bk_deploy_help
    printf 'bk_deploy: Deploy a successful build through Buildkite

    Usage:
    bk_deploy [options] <repo> <build-number> <target>

    Options:
    -h, --help     Show this help message and exit
    -n, --dry-run  Print the command without checking the build or deploying
    -y, --yes      Skip confirmation; required for non-interactive use

    Uses the repo name as the source Buildkite pipeline.
    INFRA_DIR points to the infra checkout used to resolve target aliases.\n'
    return 0
end

function bk_deploy --description "Deploy a successful build through Buildkite"
    argparse h/help n/dry-run y/yes -- $argv
    or begin
        colorize red "Error: Invalid arguments. Use 'bk_deploy -h' for help.\n"; and __bk_deploy_help; and return 1
    end
    set -q _flag_help; and __bk_deploy_help && return 0

    if test (count $argv) -ne 3
        colorize red "Error: Expected repo, build number and target.\n"; and __bk_deploy_help; and return 1
    end
    set -l repo $argv[1]
    set -l build $argv[2]
    set -l target $argv[3]

    if not string match -qr '^[a-z][a-z0-9-]*$' -- "$repo"
        colorize red "Error: Invalid repository name '$repo'.\n"; and return 1
    end
    if not string match -qr '^[1-9][0-9]*$' -- "$build"
        colorize red "Error: Build number must be a positive integer.\n"; and return 1
    end
    if test -z "$target"
        colorize red "Error: A deployment target is required.\n"; and return 1
    end

    99-check_dependencies_names true bk jq bash || return $status

    if not test -f "$INFRA_DIR/scripts/env-groups.sh"
        colorize red "Error: INFRA_DIR must point to the infra checkout.\n"; and return 1
    end
    # env-groups.sh resolves paths relative to the infra checkout.
    set -l targets (command bash -c 'cd "$INFRA_DIR" && bash scripts/env-groups.sh "$1"' -- "$target")
    or return $status
    if test (count $targets) -eq 0
        colorize red "Error: Unknown deployment target '$target'.\n"; and return 1
    end

    set -l deploy_args build create --org loke --pipeline infra-deployment \
        --branch main --commit HEAD --message "Deploy $repo ($build) to $target" \
        --env "DEPLOY_REPO=$repo" --env "DEPLOY_REVISION=$build" \
        --env "DEPLOY_ENVIRONMENT=$target" --yes --no-input

    colorize green ">Deploy $repo build $build to $target:\n"
    printf '  %s\n' $targets
    if set -q _flag_dry_run
        printf '%s\n' (string join ' ' -- (string escape -- bk $deploy_args))
        return 0
    end

    if not set -q _flag_yes; and not status is-interactive
        colorize red "Error: Non-interactive deployment requires --yes; inspect --dry-run first.\n"; and return 1
    end

    colorize green ">Checking source build...\n"
    set -l source_build (command bk api "/pipelines/$repo/builds/$build?exclude_jobs=true&exclude_pipeline=true" --org loke --no-input)
    or return $status
    printf '%s\n' "$source_build" | command jq -er 'select(.state == "passed") | "Source: \(.web_url) (\(.branch) @ \(.commit))"'
    or begin
        colorize red "Error: A passed source build is required; refusing deployment.\n"; and return 1
    end

    if not set -q _flag_yes
        read -l -P "Type '$target' to deploy: " answer
        or return $status
        if test "$answer" != "$target"
            colorize yellow "Deployment cancelled.\n"; and return 1
        end
    end

    # Buildkite owns the infra write and Argo wait; never run deploy.sh locally.
    command bk $deploy_args
    return $status
end
