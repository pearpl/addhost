# addhost.sh

Simple command-line script for managing entries in `/etc/hosts` on macOS.

## Features

- Add hostnames to 127.0.0.1
- Remove hostnames
- List existing entries
- Color-coded output
- Designed specifically for macOS

## Installation

1. Save the script to a local path:
   ```sh
   mkdir -p $HOME/bin
   cp addhost.sh $HOME/bin/
   chmod +x $HOME/bin/addhost.sh
   ```

2. Add this alias to your shell config file (`~/.bash_profile`, `~/.zshrc`, etc.):
   ```sh
   alias addhost="$HOME/bin/addhost.sh"
   ```

3. Reload your shell:
   ```sh
   source ~/.bash_profile   # or source ~/.zshrc
   ```

## Disclaimer

This script modifies your `/etc/hosts` file. Use it at your own risk.

Always back up your existing hosts file before using:

```sh
sudo cp /etc/hosts /etc/hosts.backup.$(date +%s)
```
   

## Usage

```sh
addhost add <hostname>      # Add a hostname to 127.0.0.1
addhost rm <hostname>       # Remove a hostname
addhost list                # List all hostnames
addhost help                # Show usage info
addhost ver                 # Show version
```

## Example

```sh
addhost add test.local
addhost list
addhost rm test.local
```

## Notes

- Script modifies `/etc/hosts`, so `sudo` is required for write operations.
- Only works on macOS (uses `sed -i ""` syntax).
- You should back up your hosts file if you're using this in a production-like setup.

## Author

Łukasz 'Alien' Kosma  
https://pear.pl  
https://github.com/pearpl

[Buy me a coffee](https://buymeacoffee.com/alienatedalien)

## Support

If this script saved you time, you can [buy me a coffee](https://buymeacoffee.com/alienatedalien).
