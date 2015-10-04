-- Entrypoint for API

local path = (...):match(".*")
local common = require(path .. "common")

local mm = {}

function mm.load(major, minor, revision)
end

function mm.getPath(major, minor, revision)

end

return mm