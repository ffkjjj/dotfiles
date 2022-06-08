# ===============================
# Author: jessun1990@gmail.com
# Useage: fish shell config file
# Location: ~/.config/fish/config.fish
# ===============================
#
# ======== Var Definition =======
export LOCAL_SOCKS5_PROXY='socks5://127.0.0.1:1080'
export LOCAL_HTTP_PROXY='http://127.0.0.1:1087'
export HISTIGNORE='*sudo -S*'

# https://wiki.archlinux.org/title/GNOME_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)/Keyring_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)#%E8%87%AA%E5%8A%A8%E7%99%BB%E9%99%86
if test -n "$DESKTOP_SESSION"
    set (gnome-keyring-daemon --start | string split "=")
end
# ===============================
#
# ============= OS ==============

switch (uname)
    case 'Darwin'
        alias vim '/Applications/MacVim.app/Contents/bin/vim'
        if type -q 'nvm' 
            nvm use default
        end
    case 'Linux'
        if type -q 'xsel'
            alias pbcopy 'xsel --clipboard --input'
            alias pbpaste 'xsel --clipboard --output'
        end
        if type -q 'setxkbmap'
            setxkbmap -option caps:swapescape
        end
    case "*"
        echo "unknowon os"
end
# ===============================
# 
# ============ Alias ============
# emacs
if type -q 'emacs'
   alias e='emacs -nw'
end

# git
if type -q 'git'
    # alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
    alias gdelete-merged='git branch --merged | egrep -v "(^\*|master)" | xargs git branch -d'
    alias gdelete-all-branches='git branch | grep -v "master" | xargs git branch -D'
    alias gdebug='git add . && git commit -m "DEBUG" && git push'
    alias grebase='git pull --all && git rebase -i origin/master'
end
 

#alias nvim "nvim -u ~/.config/nvim/init.lua"
alias nvim_classic "nvim -u ~/.config/nvim/init-classic.vim"

if type -q 'go'
    # alias golangci="docker run --rm -v (pwd):/app -w /app golangci/golangci-lint:v1.43.0 golangci-lint run"
    alias golangcirun "golangci-lint run"
    alias govet "CGO_CFLAGS=\"-g -O2 -Wno-return-local-addr\" go vet ./..."
    alias gomod "go mod vendor;and go mod tidy -go=1.16 ;and go mod tidy -go=1.17"
end

# proxy
alias usesocks5proxy "export all_proxy='$LOCAL_SOCKS5_PROXY'; export http_proxy='$LOCAL_SOCKS5_PROXY'; export https_proxy='$LOCAL_SOCKS5_PROXY'; git config --global http.proxy '$LOCAL_SOCKS5_PROXY'; git config --global https.proxy '$LOCAL_SOCKS5_PROXY'"
alias usehttpproxy "export all_proxy='$LOCAL_HTTP_PROXY'; export http_proxy='$LOCAL_HTTP_PROXY'; export https_proxy='$LOCAL_HTTP_PROXY'; git config --global http.proxy '$LOCAL_HTTP_PROXY'; git config --global https.proxy '$LOCAL_HTTP_PROXY'"
alias cleanallproxy "export all_proxy=; export http_proxy=; export https_proxy=; git config --global http.proxy ''; git config --global https.proxy ''"

# shell proxy
alias shellusesocks5proxy "export all_proxy='$LOCAL_SOCKS5_PROXY'; export http_proxy='$LOCAL_SOCKS5_PROXY'; export https_proxy='$LOCAL_SOCKS5_PROXY'"
alias shellusehttpproxy "export all_proxy='$LOCAL_HTTP_PROXY'; export http_proxy='$LOCAL_HTTP_PROXY'; export https_proxy='$LOCAL_HTTP_PROXY'"

# git proxy
if type -q 'git'
    alias gitusehttpproxy "git config --global http.proxy '$LOCAL_HTTP_PROXY'; git config --global https.proxy '$LOCAL_HTTP_PROXY'"
    alias gitusesocks5proxy "git config --global http.proxy '$LOCAL_SOCKS5_PROXY'; git config --global https.proxy '$LOCAL_SOCKS5_PROXY'"
    alias gitcleanproxy "git config --global http.proxy ''; git config --global https.proxy ''"
    if type -q 'vim'
        alias gitfix 'git diff --name-only | uniq | xargs nvim '
    end
    if type -q 'nvim'
        alias gitfix 'git diff --name-only | uniq | xargs nvim '
    end
    if type -q 'code'
        alias codefix 'git diff --name-only | uniq | xargs code '
    end
    if type -q 'code-insiders'
        alias codefix 'git diff --name-only | uniq | xargs code-insiders '
    end
    alias gitdiff 'git difftool'
end
# ===============================
#
# ========== Env Vars ===========
export TERM="screen-256color"
export LANG=zh_CN.UTF-8

# Golang
export GO111MODULE=on
export GOPROXY=goproxy.cn,goproxy.io,direct 
if test -e "$HOME/.gvm/environments/default"
    bass source "$HOME/.gvm/environments/default"
end

# Local bin
if test -d "$HOME/.local/bin/"
    set -gx PATH "$HOME/.local/bin/" $PATH
end

if test -d "$HOME/.nix-profile/bin/"
    set -gx PATH "$HOME/.nix-profile/bin/" $PATH
end

if test -d "$HOME/.luarocks/bin/"
    set -gx PATH "$HOME/.luarocks/bin/" $PATH
end

# Home bin
if test -d "$HOME/bin/"
    set -gx PATH "$HOME/bin/" $PATH
end

# MEGAsync
if test -d "$HOME/MEGAsync/bin/"
    set -gx PATH "$HOME/MEGAsync/bin/" $PATH
end

# Rust
if test -d "$HOME/.cargo/bin/"
    set -gx PATH "$HOME/.cargo/bin/" $PATH
end
if type -q rustc
    export RUST_SRC_PATH=(rustc --print sysroot)/lib/rustlib/src/rust/library/
end

# python
if type -q pyenv
    export PYENV_ROOT="$HOME/.pyenv/shims"
    export PATH="$PYENV_ROOT:$PATH"
    export PIPENV_PYTHON="$PYENV_ROOT/python"
end

# ruby env
if test -d "$HOME/.rbenv/bin"
    set -g PATH "$HOME/.rbenv/bin" $PATH
end
if test -d "$HOME/.rbenv/shims"
    set -g PATH "$HOME/.rbenv/shims" $PATH
end
if test -d "$HOME/.local/share/gem/ruby/3.0.0/bin"
    set -g PATH "$HOME/.local/share/gem/ruby/3.0.0/bin" $PATH
end
if type -q 'rbenv'
    status --is-interactive; and rbenv init - fish | source
end

# yarn
if test -d "$HOME/.yarn/bin/"
    set -gx PATH "$HOME/.yarn/bin/" $PATH
end
# ===============================
export GOPRIVATE=actiontech.cloud
export GOINSECURE=actiontech.cloud

if type -q 'exa'
    alias ls=exa
end

if command -v pazi >/dev/null
  status --is-interactive; and pazi init fish | source
end

alias sshtomac="sshuttle -r jessun@192.168.3.31 127.0.0.1/0"

set -Ux GPG_TTY (tty)
