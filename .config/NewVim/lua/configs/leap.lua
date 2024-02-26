local leap = require("leap")

pcall(leap.setup({}), "leap")

-- pcall required to prevent popup due to apparent 'conflict' with surround, lol
pcall(leap.create_default_mappings(), "leap")
