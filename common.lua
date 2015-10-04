local ffi = require("ffi")
local liblove = (jit.os == "Windows" and ffi.load("love")) or ffi.C

local common = {}

if (love.getVersion) then
	common.version = ("%d.%d.%d"):format(love.getVersion())
else
	common.version = ("%d.%d.%d"):format(love._version_major, love._version_minor, love._version_revision)
end

ffi.cdef([[
	int PHYSFS_mount(const char* dir, const char* mountPoint, int append);
	int PHYSFS_removeFromSearchPath(const char* dir);
]])

function common.normalizePath(path)
	path = path
		:gsub("\\", "/")
		:match("^.-/*$")

	return path
end

function common.parseVersion(ver)
	local maj, min, rev = ver:match("^(%d+)%.(%d*)%.(%d*)")

	return tonumber(maj), tonumber(min), tonumber(rev)
end

-- Finds the closest match in a list for a given LOVE version
-- [0.9.2, 0.8.0], given '0.9.0' will match '0.9.2'
-- [0.9.2, 0.8.0], given '0.8.0' will match '0.8.0'
function common.findVersionFor(loves, maj, min, rev)
	local closest, closestPath

	for path, version in pairs(loves) do
		local imaj, imin, irev = common.parseVersion(version)

		if (imaj == maj and imin == min) then
			if (irev >= rev) then
				if (closest) then
					local crev = closest[3]

					if (crev - rev > irev - rev) then
						closest = {imaj, imin, irev, path = path}
					end
				else
					closest = {imaj, imin, irev, path = path}
				end
			end
		end
	end

	return closest, closestPath
end

function common.readConfig(path)
	liblove.PHYSFS_mount(path, "__MM", 1)

	local body = love.filesystem.read("__MM/conf.lua")

	local details = {
		usedWindow = false,
		usedScreen = false
	}
	local conf = {
		window = setmetatable({}, {
			__newindex = function()
				details.usedWindow = true
			end
		}),
		screen = setmetatable({}, {
			__newindex = function()
				details.usedScreen = true
			end
		}),
		modules = {}
	}

	local method = loadstring(body)
	local fakeLove = {}

	local env = setmetatable({
		love = fakeLove
	}, {__index = _G})

	setfenv(method, env)

	local success, err = pcall(method)

	if (not success) then
		print("MALFORMED CONFIG: " .. err)
		return nil
	end

	if (not fakeLove.conf) then
		return nil
	end

	local success, err = pcall(fakeLove.conf, conf)

	if (not success) then
		print("CONFIG ERROR: " .. err)
		return nil
	end

	liblove.PHYSFS_removeFromSearchPath("__MM")

	return conf, details
end

function common.detectVersion(path)
	local conf, details = common.readConfig(path)

	if (conf) then
		if (conf.version) then
			return conf.version
		end

		if (details.usedScreen) then
			-- assume 0.8.0
			return "0.8.0", true
		elseif (details.usedWindow) then
			-- 0.9.0+
			return nil, true
		end
	end

	return nil
end

return common