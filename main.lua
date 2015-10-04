-- Entrypoint for CLI

local path = (...):match("(.-)%w*$")
local conf = require(path .. "configuration")
local common = require(path .. "common")

local flags = {
	passOn = {}
}

function love.load(args)
	local target = args[2]

	local keepArgs = true
	for i = 3, #args do
		local arg = args[i]

		if (arg == "--") then
			keepArgs = false
		elseif (keepArgs) then
			if (arg:match("^%-v")) then
				this.flags.version = arg:match("^%-v(.*)")
			else
				print("Invalid argument '" .. arg .. "'")
			end
		else
			table.insert(flags.passOn, arg)
		end
	end

	if (target:sub(1, 2) == "--") then
		local command = target:sub(3)
		local result = pcall(require, "cli." .. command)

		if (not result) then
			print("Invalid switch '" .. command .. "'")
			os.exit(-1)
		end
	else
		print("Loading game at " .. target)

		local ver, guess = flags.version, false

		if (not ver) then
			ver, guess = common.detectVersion(target)
		end

		if (not ver) then
			ver = conf.defaultVersion
		end

		local binary = common.findVersionFor(conf.loves, common.parseVersion(ver))

		if (not binary) then
			print("We couldn't find a LOVE binary to load version '" .. ver .. "'!")
			os.exit(-1)
		end

		os.execute(("%s \"%s\" %s"):format(binary.path, target, table.concat(flags.passOn, " ")))
		os.exit(0)
	end
end