# dotfiles

Sarah's dotfiles

## Usage

After cloning, run `./setup.sh`

## Functionality

`setup.sh` will:
1. Back up any existing dotfiles to `~/backup_dotfiles` (creating this directory if it doesn't exist)
2. Install all programs in `core/` by symlinking their configs into the appropriate location (e.g. `$HOME/.config/program`)
3. Install any optional programs that are enabled in `optional/enabled` in the same way. Uncomment program names to enable them, comment them out to disable them.  (These settings are local and not tracked by github.)

Or, you can also run setups (`core/program/setup_program.sh` or `optional/program/setup_program.sh`) within individual program folders instead. These are set up to be as independent as possible, but some of them still have some dependencies (e.g. aliases).

## Programs installed:

Currently, core programs are sh (shell-agnostic PATH, etc), bash, vim, neovim, and tmux.  Optional programs are sway and vscode.

## Adding a new program

1. Create a directory under `core/` or `optional/`
2. Add a `setup_program.sh` script that symlinks config files from `~/dotfiles/` into the appropriate configuration location (e.g. `$HOME`, `$HOME/.config/program` -- this is customized on a per-program basis in `setup_program.sh`)
3. If the program is optional, either edit `optional/enabled` directly to include the program (commented out for disabled, un-commented for enabled) or it will auto-update next time `setup.sh` is run
4. Update this readme to reflect the new program
