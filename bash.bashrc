# To the extent possible under law, the author(s) have dedicated all 
# copyright and related and neighboring rights to this software to the 
# public domain worldwide. This software is distributed without any warranty. 
# You should have received a copy of the CC0 Public Domain Dedication along 
# with this software. 
# If not, see <http://creativecommons.org/publicdomain/zero/1.0/>. 

# /etc/bash.bashrc: executed by bash(1) for interactive shells.

# System-wide bashrc file

# Check that we haven't already been sourced.
([[ -z ${CYG_SYS_BASHRC} ]] && CYG_SYS_BASHRC="1") || return

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# If started from sshd, make sure profile is sourced
if [[ -n "$SSH_CONNECTION" ]] && [[ "$PATH" != *:/usr/bin* ]]; then
    source /etc/profile
fi

# Warnings
unset _warning_found
for _warning_prefix in '' ${MINGW_PREFIX}; do
    for _warning_file in ${_warning_prefix}/etc/profile.d/*.warning{.once,}; do
        test -f "${_warning_file}" || continue
        _warning="$(command sed 's/^/\t\t/' "${_warning_file}" 2>/dev/null)"
        if test -n "${_warning}"; then
            if test -z "${_warning_found}"; then
                _warning_found='true'
                echo
            fi
            if test -t 1
                then printf "\t\e[1;33mwarning:\e[0m\n${_warning}\n\n"
                else printf "\twarning:\n${_warning}\n\n"
            fi
        fi
        [[ "${_warning_file}" = *.once ]] && rm -f "${_warning_file}"
    done
done
unset _warning_found
unset _warning_prefix
unset _warning_file
unset _warning

# If MSYS2_PS1 is set, use that as default PS1;
# if a PS1 is already set and exported, use that;
# otherwise set a default prompt
# of user@host, MSYSTEM variable, and current_directory
[[ -n "${MSYS2_PS1}" ]] && export PS1="${MSYS2_PS1}"
# if we have the "High Mandatory Level" group, it means we're elevated
#if [[ -n "$(command -v getent)" ]] && id -G | grep -q "$(getent -w group 'S-1-16-12288' | cut -d: -f2)"
#  then _ps1_symbol='\[\e[1m\]#\[\e[0m\]'
#  else _ps1_symbol='\$'
#fi
[[ $(declare -p PS1 2>/dev/null | cut -c 1-11) = 'declare -x ' ]] || \
  export PS1='\[\e]0;\w\a\]\n\[\e[32m\]\u@\h \[\e[35m\]$MSYSTEM\[\e[0m\] \[\e[33m\]\w\[\e[0m\]\n'"${_ps1_symbol}"' '
unset _ps1_symbol

# Uncomment to use the terminal colours set in DIR_COLORS
# eval "$(dircolors -b /etc/DIR_COLORS)"

# Fixup git-bash in non login env
shopt -q login_shell || . /etc/profile.d/git-prompt.sh

# scp function for getting log files
getTestLog () {
    scp brthomas@ilmocdt0dz963:/local_apps/bizflow/test/tomcat/logs/"$1" ~/Downloads/
}

getDevLog () {
    scp brthomas@ilmocdt0ad964:/local_apps/bizflow/dev/tomcat/logs/"$1" ~/Downloads/
}

applyCert() {
    keytool -import -alias $1 -keystore  "C:\Users\brthomas\tools\jdk8.48.0.53-zulu\jre\lib\security\cacerts" -file ~/Downloads/"$2"
}

raptorcli() {
    cd ~/workspaces/git/raptor/raptor-client
    ~/tools/node12/ng serve --ssl=true --sslKey=C:\tmp\raptor-config\cred-stores\localhost-key.pem --sslCert=C:\tmp\raptor-config\cred-stores\localhost-cert.pem
}

rapbuild() {
    cd ~/workspaces/git/raptor
    mvn clean install -Dmaven.wagon.http.ssl.insecure=true
}

export PATH=/c/Users/brthomas/tools/node12:$PATH

# aliases
alias la='ls -a'
alias ls='ls --show-control-chars -F --color $*'
alias ll='ls -l'
alias gl='git log --oneline --all --graph --decorate  $*'
alias buildui='C:\\Users\\brthomas\\tools\\scripts\\buildui.sh'
alias buildAndSendRaptor='C:\\Users\\brthomas\\tools\\scripts\\buildAndSendRaptor.sh'
alias sundriesxbuildui='C:\\Users\\brthomas\\tools\\scripts\\sundriesxUiBuild.sh'
alias pullall='C:\\Users\\brthomas\\tools\\scripts\\pullall.sh'
alias devgrep='git log --oneline | grep $*'
alias testgrep='git log origin/Test --oneline | grep $*'
alias sshdev='ssh brthomas@ilmocdt0ad964'
alias sshtest='ssh brthomas@ilmocdt0dz963'
alias devraptor='ssh brthomas@ilmnirm0ad623'
alias testraptor='ssh brthomas@ilmocdt0dz630'
alias jaspersoft='"\Program Files\TIBCO\Jaspersoft Studio Professional-6.1.1.final\Jaspersoft Studio Professional.exe" -configuration C:\\Users\\brthomas\\.jaspersoft\\configuration\\'
# alias raptorclient='~/tools/node12/ng serve --ssl=true --sslKey=C:\tmp\raptor-config\cred-stores\localhost-key.pem --sslCert=C:\tmp\raptor-config\cred-stores\localhost-cert.pem'
alias ng='"C:\Users\brthomas\tools\node12\ng"'
alias npm='"C:\Users\brthomas\tools\node12\npm"'
