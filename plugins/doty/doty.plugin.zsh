#!/usr/bin/env zsh
# Standarized $0 handling, following:
# https://z-shell.github.io/zsh-plugin-assessor/Zsh-Plugin-Standard
0="${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}"
0="${${(M)0:#/*}:-$PWD/$0}"

if [[ $PMSPEC != *b* ]] {
    PATH="${0:h}/bin:${PATH}"
}

# Load the shell dotfiles, and then some:
for file in ${0:h}/{path,bash_prompt,bash_exports,aliases,bash_functions,extra}; do
	[[ -r "$file" ]] && [[ -f "$file" ]] && source "$file";
done;
unset file;

# Case-insensitive globbing (used in pathname expansion)
# shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
# shopt -s histappend;
# ZSH
# setopt APPEND_HISTORY;

# Autocorrect typos in path names when using `cd`
# shopt -s cdspell;

# Check the window size after each command and, if necessary, update the values
# of LINES and COLUMNS.
# shopt -s checkwinsize

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# shopt -s autocd 2> /dev/null;
# * Recursive globbing, e.g. `echo **/*.txt`

# Add tab completion for many Bash commands
if which brew &> /dev/null && [ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]; then
	# Ensure existing Homebrew v1 completions continue to work
	export BASH_COMPLETION_COMPAT_DIR="$(brew --prefix)/etc/bash_completion.d";
	source "$(brew --prefix)/etc/profile.d/bash_completion.sh";
elif [ -f /etc/bash_completion ]; then
	source /etc/bash_completion;
fi;
