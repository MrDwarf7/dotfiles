local comment = require("Comment")

comment.setup({
    pre_hook = function()
        return vim.bo.commentstring
    end
})
