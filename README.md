# dotfiles

Sarah's dotfiles.

## Usage

After setting up git keys

```bash
git clone git@github.com:sarahscheffler/dotfiles.git ~/dotfiles
cd ~/dotfiles
./setup.sh
```

`setup.sh` will:
1. Back up any existing dotfiles to `~/backup_dotfiles` (creating this directory if it doesn't exist)
2. Install all programs in `core/` by symlinking their configs into the appropriate location (e.g. `$HOME/.config/program`)
3. Install any optional programs that are enabled in `optional/enabled` in the same way. Uncomment program names to enable them, comment them out to disable them.

Or, you can also run setups within individual program folders instead. These are set up to be as independent as possible, but some of them still have some dependencies (e.g. aliases).

## Structure

```
dotfiles/
├── setup.sh           # Main script -- run this to install or update
├── core/              # Always-installed programs
└── optional/          # Conditionally-installed programs
```

## Adding a new program

1. Create a directory under `core/` or `optional/`
2. Add a `setup_<program>.sh` script that symlinks config files from `~/dotfiles/` into the appropriate configuration location (e.g. `$HOME`, `$HOME/.config/program`)
3. If the program is optional, either edit `optional/enabled` directly to include the program (commented out for disabled, un-commented for enabled) or it will auto-update next time `setup.sh` is run
