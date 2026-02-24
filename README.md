# <a href="https://github.com/dmarcoux/dotfiles-CachyOS">dmarcoux/dotfiles-CachyOS</a>

# Installation

I only mention what isn't obvious. Same for differences from the standard setup.

- Use Limine as bootloader.
- Select keyboard layout `Canadian (CSA)` under `French (Canada)`.
- Pick the KDE desktop environment.
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
   wget https://raw.githubusercontent.com/dmarcoux/dotfiles-CachyOS/refs/heads/main/packages.txt &&
     sudo pacman -S --needed $(cat packages.txt) &&
     rm packages.txt
   ```

   [`packages.txt`](packages.txt) was created with:

   ```bash
   pacman --query --native --explicit | cut --delimiter " " --fields=1 | paste -sd " " > packages.txt
   ```

3. Install AUR packages:

   ```bash
   wget https://raw.githubusercontent.com/dmarcoux/dotfiles-CachyOS/refs/heads/main/AUR_packages.txt &&
     paru -S --needed $(cat AUR_packages.txt) &&
     rm AUR_packages
   ```

   [`AUR_packages.txt`](AUR_packages.txt) was created with:

   ```bash
   pacman --query --foreign --explicit | cut --delimiter " " --fields=1 | paste -sd " " > AUR_packages.txt
   ```

4. Enable Docker daemon (with `docker.socket`, it starts on first usage, not
   on boot), and add my user to the `docker` group to allow using Docker as non-root.

   ```bash
   sudo systemctl enable --now docker.socket &&
     sudo gpasswd -a dany docker
   ```

5. Enable MullvadVPN daemon.

   ```bash
   sudo systemctl enable --now mullvad-daemon.service
   ```

6. Clone and use dotfiles:

   ```bash
   chezmoi init git@github.com:dmarcoux/dotfiles-CachyOS.git --apply
   ```

7. Set fish as the default shell:

   ```bash
   chsh --shell /usr/bin/fish
   ```

## TODOs for Setup

- https://www.lorenzobettini.it/2025/09/managing-kde-dotfiles-with-chezmoi-and-chezmoi-modify-manager/
