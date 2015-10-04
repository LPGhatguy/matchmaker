# Matchmaker
*Make me a perfect match!*

The aim of Matchmaker is to implement a frontend to [LÖVE](//love2d.org) that correctly identifies the proper version of LÖVE to use for a particular game or application.

## Usage
Set up your configuration in `configuration.lua` -- eventually this will be filled in by `matchmaker --configure`. Simply put paths to your installed LÖVE binaries into this file.

After configuring, `matchmaker [game]` should launch the given game using the correct vesrion of LÖVE.

See `matchmaker --help` for more information.

## Known Issues
- Automatic version detection is shaky
- Error messages are unhelpful
- Linux `matchmaker` command is untested
- `matchmaker --configure` doesn't function yet
- API is a stub