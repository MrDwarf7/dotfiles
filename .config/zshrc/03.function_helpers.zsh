#!/sbin/zsh

function valid_pacman {
  local value=$1

  if command -sq "$value" &> /dev/null; then
    return 0
  fi

  if pacman -Qi "$value" &> /dev/null; then
    return 0
  fi
  return 1
}

function valid_which {
    local value=$1
    if which $value &> /dev/null; then
        return 0
    else
        return 1
    fi
}

function eval_if_pacman {
    local value=$1
    local expr=$2
    # echo "Value is: $1"
    # echo "Expr is: $2"

    if (valid_pacman $value); then
        source <(eval $expr)
        return 0
    fi

    # if command -sq "$value" &> /dev/null; then
    #     source <(eval $expr)
    #     return 0
    # fi
    # if pacman -Qi "$value" &> /dev/null; then
    #     source <(eval $expr)
    #     return 0
    # fi

    return 1
}


### Setting up the PATH
### This allows passing in multiple paths to add to the PATH
### if the value is valid it will be exported as an ENV variable
function export_if_pacman {
    # If program_one {
    #       env = program_one
    # } else {
    #       env = program_two
    # }
    local program_one="$1"
    local env_var="$2"
    local fallback_prog="$3"
    local pacman_check=""

    pacman_check=valid_pacman($program_one)
    if [ "$pacman_check" ]; then
        export $env_var="$program_one"
    elif [ -n "$or_value" ]; then
        export "$env_var"="$fallback_prog"
    fi
}

function export_path_if_pacman {
    local program_one="$1"
    local env_var="$2"
    local path_value="$3"

    local pacman_check=valid_pacman($program_one)

    if [ -n "$pacman_check" ]; then
        export $env_var="$path_value"
    fi

}

function export_onto_path_if_pacman {
    local value="$1"
    local env_var="$2"

    local pacman_check=valid_pacman($value)

    if [ -n "$pacman_check" ]; then
        export PATH="$PATH:$env_var"
    fi
}

function alias_if_pacman {
    local program_one=$1
    local alias_name=$2
    local alias_value=$3



    # local pacman_check=valid_pacman($program_one)

    # use the fater valid_pacman function

    if (valid_pacman $program_one); then
        alias $alias_name=$alias_value
        return 0
    fi
}

function source_if_pacman {
    local program_one=$1
    local file=$2

    if (valid_pacman $value); then
      source $file
      return 0
    fi
    return 1
}
