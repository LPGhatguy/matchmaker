# Matchmaker
*Make me a perfect match!*

The aim of Matchmaker is to implement a frontend to [LOVE](//love2d.org) that correctly identifies the proper version of LOVE to use for a particular game or application.

Nothing is implemented, but the goal is to replace `love app.love` with `matchmaker app.love` and to be API-compatible with LOVE's launcher. This means that `love` could be made as an alias to `matchmaker` without breaking any existing setups.

This will simplify build tooling, development, debugging, and enable users on more platforms to have convenient side-by-side installations of LOVE.
