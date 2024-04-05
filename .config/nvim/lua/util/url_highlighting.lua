local fn = vim.fn
local g = vim.g

local M = {}

M.url_highlight = function()
    vim.cmd([[
    hi def link url Underlined
    hi def link mailTo Underlined
  ]])
    local url_matcher =
    "\\v\\c%(%(h?ttps?|ftp|file|ssh|git)://|[a-z]+[@][a-z]+[.][a-z]+:)%([&:#*@~%_\\-=?!+;/0-9a-z]+%(%([.;/?]|[.][.]+)[&:#*@~%_\\-=?!+/0-9a-z]+|:\\d+|,%(%(%(h?ttps?|ftp|file|ssh|git)://|[a-z]+[@][a-z]+[.][a-z]+:)@![0-9a-z]+))*|\\([&:#*@~%_\\-=?!+;/.0-9a-z]*\\)|\\[[&:#*@~%_\\-=?!+;/.0-9a-z]*\\]|\\{%([&:#*@~%_\\-=?!+;/.0-9a-z]*|\\{[&:#*@~%_\\-=?!+;/.0-9a-z]*})\\})+"
    --- Delete the syntax matching rules for URLs/URIs if set
    local function delete_url_match()
        for _, match in ipairs(fn.getmatches()) do
            if match.group == "HighlightURL" then
                fn.matchdelete(match.id)
            end
        end
    end
    --- Add syntax matching rules for highlighting URLs/URIs
    local function set_url_match()
        delete_url_match()
        if g.highlighturl_enabled then
            fn.matchadd("HighlightURL", url_matcher, 15)
        end
    end
    set_url_match()
end

return M
