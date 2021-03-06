#!/bin/bash
# -*- coding: utf-8, tab-width: 2 -*-


function ci_main () {
  export LANG{,UAGE}=en_US.UTF-8  # make error messages search engine-friendly
  local REPOPATH="$(readlink -m -- "$BASH_SOURCE"/../..)"
  cd -- "$REPOPATH"/src || return $?

  source -- rebuild.sh --lib || return $?
  rebuild__core || return $?

  local PROG_NAME='xseticon-pmb'
  vdo grep_usage ../bin/"$PROG_NAME" || return $?
  vdo env SUDO=sudo make install || return $?
  vdo which "$PROG_NAME" || return $?
  vdo grep_usage "$PROG_NAME" || return $?
  vdo du --bytes -- *.elf ../bin/* || return $?

  echo '+OK CI passed.'
}


function grep_usage () { "$@" |& grep -Fe 'Usage:'; }








ci_main "$@"; exit $?
