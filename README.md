# <a href="https://github.com/dmarcoux/dotfiles-CachyOS">dmarcoux/dotfiles-CachyOS</a>

# Installation

I only mention what isn't obvious. Same for differences from the standard setup.

- Use Limine as bootloader.
- Select keyboard layout `Canadian (CSA)` under `French (Canada)`.
- Pick COSMIC Desktop.
- Unselect `CachyOS shell configuration`, select `Printing Support`. Erase the whole disk (`/dev/sda` on my desktop computer)
- Use encryption with a different password as my user.
- Use a different password for the root user.

## Issues

- Wrong keyboard layout used when decrypting the LUKS partition on boot.
  Changing the keyboard settings within the GUI of the Live ISO doesn't work.
  Same with `localectl`.

# First Boot Setup

1. Install & Configure 1Password and its CLI. The 1Password signing key is imported before the installation.

   ```bash
    curl -sS https://downloads.1password.com/linux/keys/1password.asc | gpg --import

    paru -S 1password 1password-cli
   ```

2. Install official packages:

   ```bash
   sudo pacman -S --needed $(cat packages.txt)
   ```

   `packages.txt` was created with:

   ```bash
   pacman --query --native --explicit | cut --delimiter " " --fields=1 | paste -sd " " > packages.txt
   ```

3. Install AUR packages:

   ```bash
   paru -S --needed $(cat AUR_packages.txt)
   ```

   `AUR_packages.txt` was created with:

   ```bash
   pacman --query --foreign --explicit | cut --delimiter " " --fields=1 | paste -sd " " > AUR_packages.txt
   ```

4. Enable Docker daemon (with `docker.socket`, it starts on first usage, not
   on boot), and add my user to the `docker` group to allow using Docker as non-root.

   ```bash
   sudo systemctl enable --now docker.socket &&
     sudo gpasswd -a dany docker
   ```

## TODOs for Setup

- [How to assign applications to launch on a specific workspace?](https://github.com/pop-os/cosmic-epoch/discussions/1129)
- i3wm-like behavior in Cosmic
  - Go back to end when reaching start of a stacked windows group (other way around works already)
  - How to only use stacked windows group by default? At least for specific workspaces (1 and 2), it would be nice.
  - Pin workspaces to have 5 permanent workspaces
