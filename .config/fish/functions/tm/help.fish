set -g TM_DBG 0

function __tm_help --description 'Show registry-generated tm help'
    __tm_dbg help
    __tm_print_help
end
