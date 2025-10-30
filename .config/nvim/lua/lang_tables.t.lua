---@meta

------------------------------------------------------------------------------------
---@diagnostic disable-next-line: undefined-doc-name
---@alias Ft string|vim.bo.filetype

---@alias TypeOfLiteral "linters" | "formatters" | "linter" | "formatter"

---@alias CategoryLiteral "treesitter" | "mason"

---@alias Category CategoryLiteral | CategoryE

---@alias TreeSitterSubtypeLiteral "languages" | "data_formats" | "system"
---@alias TreeSitterSubtype TreeSitterSubtypeLiteral | TreeSitterSubtypeE

------------------------------------------------------------------------------------

---@alias MasonSubtypeLiteral "formatters" | "linters" | "lsps" | "daps"
---@alias MasonSubtype MasonSubtypeLiteral | MasonSubtypeE

--- We 'overwrite' the definition because we want to reference
--- the previous documentation classes fields
---@class MasonSubtypeE
---@field formatters MasonSubtypeE.formatters
---@field formatters_by_ft table<string, ListElements|function>
---@field linters MasonSubtypeE.linters
---@field linters_by_ft table<string, ListElements>
---@field lsps MasonSubtypeE.lsps
---@field daps MasonSubtypeE.daps

--- We 'overwrite' the definition because we want to reference
--- the previous documentation classes fields
---@class TreeSitterSubtypeE
---@field languages TreeSitterSubtypeE.languages
---@field data_formats TreeSitterSubtypeE.data_formats
---@field system TreeSitterSubtypeE.system

------------------------------------------------------------------------------------

---@alias SubtypeLiteral TreeSitterSubtypeLiteral | MasonSubtypeLiteral | "all"
-----@alias SubTypeInner SubtypeE.treesitter | SubtypeE.mason

---@alias Subtype SubtypeLiteral | SubtypeE.treesitter | SubtypeE.mason

------------------------------------------------------------------------------------

---@alias WantsTypeLiteral "all" | "ensure_installed" | "disabled"
---@alias WantsType WantsTypeLiteral | WantsTypeE

------------------------------------------------------------------------------------

---@alias ListElements string[]

------------------------------------------------------------------------------------

---@alias void nil

---@class LangTables
---@field treesitter TreeSitterSubtypeE ---table<string, ListElements>
---@field mason MasonSubtypeE
---@field disabled table<string, boolean>
---@field merged table<string, table<string, ListElements>>
---@field get fun(category: Category, subtype?: Subtype, wants_type?: WantsType | table<string, boolean> | boolean | ListElements): ListElements
---@field set_disabled fun(to_disable: table<string, boolean> | ListElements | boolean, category?: Category, subtype?: Subtype): void
---@field ts_all fun(removable?: table<string, boolean> | boolean | ListElements): ListElements
---@field ts_ensure_installed fun(removable?: table<string, boolean> | boolean | ListElements): ListElements
---@field ts_ensure_installed_languages fun(removable?: table<string, boolean> | boolean | ListElements): ListElements
---@field ts_ensure_installed_data_formats fun(removable?: table<string, boolean> | boolean | ListElements): ListElements
---@field ts_ensure_installed_system fun(removable?: table<string, boolean> | boolean | ListElements): ListElements
---@field ts_disabled fun(removable?: table<string, boolean> | boolean | ListElements): ListElements
---@field ts_disabled_languages fun(removable?: table<string, boolean> | boolean | ListElements): ListElements
---@field ts_disabled_data_formats fun(removable?: table<string, boolean> | boolean | ListElements): ListElements
---@field ts_disabled_system fun(removable?: table<string, boolean> | boolean | ListElements): ListElements
---@field mason_all fun(removable?: table<string, boolean> | boolean | ListElements): ListElements
---@field mason_ensure_installed fun(removable?: table<string, boolean> | boolean | ListElements): ListElements
---@field mason_ensure_installed_formatters fun(removable?: table<string, boolean> | boolean | ListElements): ListElements
---@field mason_ensure_installed_linters fun(removable?: table<string, boolean> | boolean | ListElements): ListElements
---@field mason_ensure_installed_lsps fun(removable?: table<string, boolean> | boolean | ListElements): ListElements
---@field mason_ensure_installed_daps fun(removable?: table<string, boolean> | boolean | ListElements): ListElements
---@field mason_disabled fun(removable?: table<string, boolean> | boolean | ListElements): ListElements
---@field mason_disabled_formatters fun(removable?: table<string, boolean> | boolean | ListElements): ListElements
---@field mason_disabled_linters fun(removable?: table<string, boolean> | boolean | ListElements): ListElements
---@field mason_disabled_lsps fun(removable?: table<string, boolean> | boolean | ListElements): ListElements
---@field mason_disabled_daps fun(removable?: table<string, boolean> | boolean | ListElements): ListElements
---
---@field by_ft fun(typeof: TypeOfLiteral|TypeOfE, ft?: Ft, bufnr?: integer): ListElements|nil
---
---@deprecated Use LangTables.by_ft("linters", ft) instead.
---@field linters_by_ft fun(ft?: Ft, bufnr?: integer): ListElements
---
---@deprecated Use LangTables.by_ft("formatters", ft) instead.
---@field formatters_by_ft fun(ft?: Ft, bufnr?: integer): ListElements
