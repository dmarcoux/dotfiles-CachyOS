##### XDG #####

set -gx XDG_AUDIO_DIR $HOME/audio
set -gx XDG_CACHE_HOME $HOME/.cache
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_DESKTOP_DIR $HOME/desktop
set -gx XDG_DOCUMENTS_DIR $HOME/documents
set -gx XDG_DOWNLOAD_DIR $HOME/downloads
set -gx XDG_EBOOKS_DIR $HOME/ebooks
set -gx XDG_MUSIC_DIR $HOME/music
set -gx XDG_PICTURES_DIR $HOME/pictures
set -gx XDG_PROJETS_DIR $HOME/projets
set -gx XDG_PUBLICSHARE_DIR $HOME/public
set -gx XDG_STATE_HOME $HOME/.local/state
set -gx XDG_TEMPLATES_DIR $HOME/templates
set -gx XDG_TEMPORARY_DIR $HOME/tmp
set -gx XDG_VIDEOS_DIR $HOME/videos

##### Clipboard #####

abbr cbc wl-copy
alias cbcf='history | fzf --header="Select command to copy to clipboard" --tiebreak=index | string trim | wl-copy'
abbr cbp wl-paste

##### Better defaults #####

# Hide the startup message
set -g fish_greeting ""

abbr chgrp "chgrp --preserve-root"
abbr chmod "chmod --preserve-root"
abbr chown "chown --preserve-root"
abbr cp "cp --interactive"
abbr ln "ln --interactive"
abbr mkdir "mkdir --parents --verbose"
abbr mv "mv --interactive"
abbr ping "ping -c 3"
abbr rm "rm --interactive=once --preserve-root"
# Prevent issues when SSHing
alias ssh='TERM=xterm-256color ssh'

##### JetBrains #####

# Add JetBrains IDEs installed via the JetBrains Tool to $PATH.
# For this to work, the `Generate shell scripts` setting must be enabled (it should be by default...)
fish_add_path $XDG_DATA_HOME/JetBrains/Toolbox/scripts

##### Ripgrep #####

set -gx RIPGREP_CONFIG_PATH $XDG_CONFIG_HOME/ripgrep/config

##### Zed #####

set -gx EDITOR zeditor
abbr zed zeditor

##### Docker / Podman #####

abbr doc docker
abbr pod podman
abbr doccom "docker compose"
abbr docker-compose 'docker compose'
abbr podcom podman-compose

# Start a Docker/Podman container for projects without a Docker/Podman setup (ports are mapped directly on the host, so anything running inside the container is accessible on the host)
abbr drunb 'docker run -v "$PWD:/app" --net="host" -it ruby:"$(cat .ruby-version)" bash'
abbr prunb 'podman run --volume "$PWD:/app" --workdir=/app --rm --network="host" -it ruby:"$(cat .ruby-version)" bash'

# Select a locally available Docker/Podman image and run a new Docker/Podman container based on it
abbr drunf 'docker image ls | fzf --header="Select a Docker image to run a Docker container based on it" --header-lines=1 | tr --squeeze-repeats " " | cut --delimiter=" " --fields=1 | xargs --no-run-if-empty docker run'
abbr prunf 'podman image ls | fzf --header="Select a Podman image to run a Podman container based on it" --header-lines=1 | tr --squeeze-repeats " " | cut --delimiter=" " --fields=1 | xargs --no-run-if-empty podman run'

# Tip: The following aliases are even better when fzf is using this as a default option: --bind ctrl-a:select-all,ctrl-d:deselect-all,ctrl-t:toggle-all
#      We can quickly select one, multiple or all option(s)

# Select Docker/Podman containers and remove them (with their volumes)
abbr drmf 'docker ps --all | fzf --header="Select Docker containers to remove (with their volumes)" --header-lines=1 --multi | tr --squeeze-repeats " " | cut --delimiter=" " --fields=1 | xargs --no-run-if-empty docker rm --volumes'
abbr prmf 'podman ps --all | fzf --header="Select Podman containers to remove (with their volumes)" --header-lines=1 --multi | tr --squeeze-repeats " " | cut --delimiter=" " --fields=1 | xargs --no-run-if-empty podman rm --volumes'

# Select Podman pods and remove them (with their containers)
abbr pprmf 'podman pod ps | fzf --header="Select Podman pods to remove (with their containers)" --header-lines=1 --multi | tr --squeeze-repeats " " | cut --delimiter=" " --fields=1 | xargs --no-run-if-empty podman pod rm --force'

# Select Docker/Podman containers and stop them
abbr dstopf 'docker ps | fzf --header="Select Docker containers to stop" --header-lines=1 --multi | tr --squeeze-repeats " " | cut --delimiter=" " --fields=1 | xargs --no-run-if-empty docker stop'
abbr pstopf 'podman ps | fzf --header="Select Podman containers to stop" --header-lines=1 --multi | tr --squeeze-repeats " " | cut --delimiter=" " --fields=1 | xargs --no-run-if-empty podman stop'

# Select a Docker/Podman container and start shell in it
alias dexecf='docker ps | fzf --header="Select a Docker container and start shell in it" --header-lines=1 --multi | tr --squeeze-repeats " " | rev | cut --delimiter=" " --fields=1 | rev | xargs --no-run-if-empty -I % bash -c "</dev/tty docker exec --interactive --tty % bash --login"'
alias pexecf='podman ps | fzf --header="Select a Podman container and start shell in it" --header-lines=1 --multi | tr --squeeze-repeats " " | rev | cut --delimiter=" " --fields=1 | rev | xargs --no-run-if-empty -I % bash -c "</dev/tty podman exec --interactive --tty % bash --login"'

# Select Docker/Podman images and remove them
abbr drmif 'docker image ls | fzf --header="Select Docker images to remove" --header-lines=1 --multi | tr --squeeze-repeats " " | cut --delimiter=" " --fields=3 | xargs --no-run-if-empty docker rmi --force'
abbr prmif 'podman image ls | fzf --header="Select Podman images to remove" --header-lines=1 --multi | tr --squeeze-repeats " " | cut --delimiter=" " --fields=3 | xargs --no-run-if-empty podman rmi --force'

##### eza #####

abbr ls "eza --all --group-directories-first --across --color=never"
abbr ll "eza --all --group-directories-first --long --color=never"

##### mise #####

# https://geekingfrog.com/blog/post/mise-erlang
# When installing Erlang via Mise, this fixes the warning `OTP compiled without EEP48 documentation chunks`. WIP The wxWidgets also work now.
set -gx KERL_CONFIGURE_OPTIONS "--enable-wx --with-wx --enable-webview --without-javac --with-wx-config=/usr/bin/wx-config --with-odbc=/var/lib/pacman/local/unixodbc-"(pacman -Q unixodbc | cut -d' ' -f2)
set -gx KERL_BUILD_DOCS yes

if test $TERM != "dumb"
    mise activate fish | source
end

abbr mr "mise run"

##### Starship #####

if test $TERM != dumb
    starship init fish | source
end

##### 1Password #####

# Use the 1Password SSH agent for all hosts
set -gx SSH_AUTH_SOCK ~/.1password/agent.sock

##### direnv #####

if test "$TERM" != dumb
    direnv hook fish | source
end

##### fzf #####

# Set up fzf keybindings and fuzzy completion
fzf --fish | source

function cd_to_lf_g_mappings_and_project_directories
    set directory (cat $XDG_CONFIG_HOME/lf/lfrc | begin; sed -n -e 's|\s*map g[^,]* cd "\?\(.*\)"\?|\1|gp'; ls --directory $XDG_PROJETS_DIR/*; end | sort | uniq | fzf)

    if test -n $directory
        cd $directory
        commandline -f repaint
    end
end

# Press Ctrl+G to change directory to one of the lf `g` mappings or any directory under `$XDG_PROJETS_DIR`.
bind ctrl-g cd_to_lf_g_mappings_and_project_directories

set -gx FZF_ALT_C_COMMAND "command fd --hidden --type directory --exclude .git"
set -gx FZF_CTRL_T_COMMAND "command fd --hidden --type file --exclude .git"
set -gx FZF_DEFAULT_COMMAND "command fd --hidden --type file --exclude .git"
set -gx FZF_DEFAULT_OPTS_FILE $XDG_CONFIG_HOME/fzf/.fzfrc
