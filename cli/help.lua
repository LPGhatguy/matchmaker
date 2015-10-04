print([[
MatchMaker 0.1 for LOVE
Lucien Greathouse

Usage:
	matchmaker path [-v x.y.z] [ -- args]
		Execute the file or folder at 'path' with the correct LOVE version.
		Optionally forces the file to load with LOVE version x.y.z.

		Any arguments after -- will be passed to the LOVE file directly.

	matchmaker --help
		Display this message

	matchmaker --configure
		Run the configuration wizard
]])

os.exit(0)