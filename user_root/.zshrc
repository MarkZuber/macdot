if [ -f ~/.isatwork ]; then
  export IS_AT_WORK=true
  echo 'IsAtWork=true, setting work aliases instead...'
fi

if [ -f ~/.isworkserver ]; then
  source /usr/facebook/ops/rc/master.zshrc
fi

export ZSH=~/.oh-my-zsh

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"

export LSCOLORS="exfxcxdxbxegedabagacad"
export CLICOLOR=true

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt CORRECT
setopt EXTENDED_HISTORY # add timestamps to history
setopt APPEND_HISTORY # adds history
setopt INC_APPEND_HISTORY SHARE_HISTORY  # adds history incrementally and share it across sessions
setopt HIST_IGNORE_ALL_DUPS  # don't record dupes in history
setopt HIST_REDUCE_BLANKS


source $ZSH/oh-my-zsh.sh

# Only do this on macos, on work servers, these get added to plugins array.
if [[ "$OSTYPE" == "darwin"* ]]; then

  plugins=(
      cargo
      extract
      git
      github
      gitignore
      golang
      history
      jsontools
      last-working-dir
      osx
      rand-quote
      rsync
      rust
      sudo
      systemd
      themes
      timer
      urltools
      vscode
      web-search
      xcode
      yarn
      z
  )

  source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

if [ -f ~/.isworkserver ]; then
  plugins=(
    history
    zsh-syntax-highlighting
    zsh-autosuggestions
    z
)
fi

# User configuration
export editor='vim'

# Aliases

### Rust Aliases
alias cr="cargo run "
alias crr="cargo run --release "
alias cb="cargo build "
alias cbr="cargo build --release "

alias cls='clear'
alias srcz="source ~/.zshrc"
alias zshrc="code ~/.zshrc"

alias dotfiles="cd ~/repos/macdot"

alias dfbk="~/repos/macdot/macdot_backup.sh"
alias dfrestore="~/repos/macdot/macdot_restore.sh"
alias dfbootstrap="~/repos/macdot/macdot_bootstrap.sh"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# fallback by typo
alias cd..='cd ..'
alias cd...='cd ../..'
alias cd....='cd ../../..'
alias cd.....='cd ../../../..'

if [ $IS_AT_WORK = true ]; then
  alias c="code-fb ."
  alias ci="code-fb-insiders ."
else
  alias c="code ."
  alias ci="code-insiders ."
fi

alias mkdir="mkdir -p"
alias md="mkdir"
alias rd="rmdir"

alias d='dirs -v | head -10'

# Print each PATH entry on a separate line
alias path="echo -e ${PATH//:/\\n}"

alias repos="cd ~/repos"

alias myip="curl http://ipecho.net/plain; echo"
alias myip_dns="dig +short myip.opendns.com @resolver1.opendns.com"

alias usage="du -h -d1"
alias runp="lsof -i "
alias topten="history | commands | sort -rn | head"
alias listening="lsof -i -P | grep LISTEN "

alias glog="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --branches"

# ------------------------------------------------------------------------------
# | List Directory Contents (ls)                                               |
# ------------------------------------------------------------------------------

alias ls="ls --color "

# list all files colorized in long format
alias l="ls -lhF $COLORFLAG"
# list all files with directories
alias ldir="l -R"
# Show hidden files
alias l.="ls -dlhF .* $COLORFLAG"
alias ldot="l."
# use colors
alias ls="ls -F $COLORFLAG"
# display only files & dir in a v-aling view
alias l1="ls -1 $COLORFLAG"
# displays all files and directories in detail
alias la="ls -laFh $COLORFLAG"
# displays all files and directories in detail (without "." and without "..")
alias lA="ls -lAFh $COLORFLAG"
alias lsa="la"
# displays all files and directories in detail with newest-files at bottom
alias lr="ls -laFhtr $COLORFLAG"
# show last 10 recently changed files
alias lt="ls -altr | grep -v '^d' | tail -n 10"
# show files and directories (also in sub-dir) that was touched in the last hour
alias lf="find ./* -ctime -1 | xargs ls -ltr $COLORFLAG"
# displays files and directories in detail
alias ll="ls -lFh --group-directories-first $COLORFLAG"
# shows the most recently modified files at the bottom of
alias llr="ls -lartFh --group-directories-first $COLORFLAG"
# list only directories
alias lsd="ls -lFh $COLORFLAG | grep --color=never '^d'"
# sort by file-size
alias lS="ls -1FSshr $COLORFLAG"
# displays files and directories
alias dir="ls --format=vertical $COLORFLAG"
# displays more information about files and directories
alias vdir="ls --format=long $COLORFLAG"

# tree (with fallback)
if which tree >/dev/null 2>&1; then
  # displays a directory tree
  alias tree="tree -Csu"
  # displays a directory tree - paginated
  alias ltree="tree -Csu | less -R"
else
  alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"
  alias ltree="tree | less -R"
fi

# ------------------------------------------------------------------------------
# | Search and Find                                                            |
# ------------------------------------------------------------------------------

# super-grep ;)
alias sgrep='grep -R -n -H -C 5 --exclude-dir={.git,.svn,CVS} '

# search in files (with fallback)
if which ack-grep >/dev/null 2>&1; then
  alias ack=ack-grep

  alias afind="ack-grep -iH"
else
  alias afind="ack -iH"
fi

# ------------------------------------------------------------------------------
# | Network                                                                    |
# ------------------------------------------------------------------------------

# speedtest: get a 100MB file via wget
alias speedtest="wget -O /dev/null http://speedtest.wdc01.softlayer.com/downloads/test100.zip"
# displays the ports that use the applications
alias lsport='sudo lsof -i -T -n'
# shows more about the ports on which the applications use
alias llport='netstat -nape --inet --inet6'
# show only active network listeners
alias netlisteners='sudo lsof -i -P | grep LISTEN'

# ------------------------------------------------------------------------------
# | Date & Time                                                                |
# ------------------------------------------------------------------------------

# date
alias date_iso_8601='date "+%Y%m%dT%H%M%S"'
alias date_clean='date "+%Y-%m-%d"'
alias date_year='date "+%Y"'
alias date_month='date "+%m"'
alias date_week='date "+%V"'
alias date_day='date "+%d"'
alias date_hour='date "+%H"'
alias date_minute='date "+%M"'
alias date_second='date "+%S"'
alias date_time='date "+%H:%M:%S"'

# stopwatch
alias timer='echo "Timer started. Stop with Ctrl-D." && date && time cat && date'

# ------------------------------------------------------------------------------
# | Hard- & Software Infos                                                     |
# ------------------------------------------------------------------------------

# pass options to free
alias meminfo="free -m -l -t"

# get top process eating memory
alias psmem="ps -o time,ppid,pid,nice,pcpu,pmem,user,comm -A | sort -n -k 6"
alias psmem5="psmem | tail -5"
alias psmem10="psmem | tail -10"

# get top process eating cpu
alias pscpu="ps -o time,ppid,pid,nice,pcpu,pmem,user,comm -A | sort -n -k 5"
alias pscpu5="pscpu5 | tail -5"
alias pscpu10="pscpu | tail -10"

# shows the corresponding process to ...
alias psx="ps auxwf | grep "

# shows the process structure to clearly
alias pst="pstree -Alpha"

# shows all your processes
alias psmy="ps -ef | grep $USER"

# the load-avg
alias loadavg="cat /proc/loadavg"

# show all partitions
alias partitions="cat /proc/partitions"

# shows the disk usage of a directory legibly
alias du='du -kh'

# show the biggest files in a folder first
alias du_overview='du -h | grep "^[0-9,]*[MG]" | sort -hr | less'

# shows the complete disk usage to legibly
alias df='df -kTh'


# ------------------------------------------------------------------------------
# | Other                                                                      |
# ------------------------------------------------------------------------------

# decimal to hexadecimal value
alias dec2hex='printf "%x\n" $1'

# Canonical hex dump; some systems have this symlinked
command -v hd > /dev/null || alias hd="hexdump -C"

# OS X has no `md5sum`, so use `md5` as a fallback
command -v md5sum > /dev/null || alias md5sum="md5"

# OS X has no `sha1sum`, so use `shasum` as a fallback
command -v sha1sum > /dev/null || alias sha1sum="shasum"

# intuitive map function
#
# For example, to list all directories that contain a certain file:
# find . -name .gitattributes | map dirname
alias map="xargs -n1"

## Visual Studio related stuff...

do_vswhere() {
    # https://stackoverflow.com/questions/54820639/how-do-i-create-a-zsh-alias-on-wsl-that-runs-vswhere-exe-and-executes-the-path
    wherePath="$(vswhere.exe -property $1 -latest -format value $2)"
    vsPath=$(wslpath -a "$wherePath")
    # Strip the trailing carriage return, if present
    vsPath="${vsPath%$'\r'}"

    "$vsPath" &
}

devenv_path_ex() {
    do_vswhere productPath
}

devenv_path_p_ex() {
    do_vswhere productPath -prerelease
}

alias devenv=devenv_path_ex
alias devenvp=devenv_path_p_ex


test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

##### Build Commands #####

alias vscbldcln="cd ~/fbsource/xplat/vscode && yarn && yarn clean && yarn && yarn build && yarn task bundle-all-modules --daemon"
alias vscbld="cd ~/fbsource/xplat/vscode && yarn && yarn build && yarn task bundle-all-modules --daemon"
alias vscdevsvr="cd ~/fbsource/xplat/vscode && yarn task bundle-all-modules --daemon && yarn task setup-devserver --devserver devvm2800.ftw3.facebook.com"
alias vst="cd ~/fbsource/xplat/vscode && yarn jest-node "

# custom functions

commands() {
  awk '{a[$2]++}END{for(i in a){print a[i] " " i}}'
}

