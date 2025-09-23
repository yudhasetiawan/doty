#!/usr/bin/env zsh

# Standardized $0 handling, following:
# https://z-shell.github.io/zsh-plugin-assessor/Zsh-Plugin-Standard
0="${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}"
0="${${(M)0:#/*}:-$PWD/$0}"
[[ -f "${0:h}/aliases" ]] && source "${0:h}/aliases"

# Export Zellij configuration directory
export ZELLIJ_CONFIG_DIR="${DOTY_DEVELOPMENT_CONFIG_DIRECTORY}/zellij"
export ZELLIJ_CONFIG_FILE="${ZELLIJ_CONFIG_DIR}/config.kdl"
