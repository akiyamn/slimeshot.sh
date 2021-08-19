# slimeshot.sh
A puu.sh like bash shell script for GNU/Linux which is a much simpler alternative to [akiyamn/slimeshot](https://github.com/akiyamn/slimeshot).

## Usage
`./slimeshot.sh [command]`

### Commands
- `u`, `upload`:	Upload the screenshot to the configured server using HTTP POST; put link on clipboard.
- `l`, `local`:	Save screenshot locally and put link on clipboard.
- `c`, `clipboard`:	Save screenshot directly to clipboard.

Default command is `upload` if no command is provided.
