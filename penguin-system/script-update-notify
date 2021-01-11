#!/usr/bin/env bash

# Display notification for software updates
# pacman + aurutils

# check for commands
declare -a deps=(pacman aur notify-send)

for cmd in "${deps[@]}"; do
  if ! command -v "${cmd}" >/dev/null 2>&1
  then
    echo >&2 "Unable to locate '${cmd}' command!"
    exit 1
  fi
done

# prevent multiple instances from running
declare -i pid="$$"
declare pidfile="/var/run/user/${UID}/${0##*/}.pid"

if [ -f "${pidfile}" ]
then
  oldpid=$(head -n 1 "${pidfile}")
  if [ ! "${pid}" == "${oldpid}" ]
  then
    kill -9 "${oldpid}" 2>/dev/null
  fi
fi
echo "${pid}" > "${pidfile}"

# main loop
declare -i interval=600
declare repo_pkgs aur_pkgs
declare -i repo_cnt aur_cnt
declare -i repo_last aur_last
declare repo_msg aur_msg notify_msg

while true
do
  # check for repo updates
  repo_pkgs=($(checkupdates 2> /dev/null | cut -d ' ' -f 1))
  repo_cnt="${#repo_pkgs[@]}"

  # build repo message
  if [[ ${repo_cnt} -gt 0 ]]
  then
    repo_msg+="Repo: ${repo_cnt}"
    for p in "${repo_pkgs[@]}"
    do
      repo_msg+="\n- ${p}"
    done
  fi

  # add repo message
  if [[ -n "${repo_msg}" ]]
  then
    notify_msg+="${repo_msg}"
  fi

  # check for aur updates
  aur_pkgs=($(pacman -Q | aur vercmp -q))
  aur_cnt="${#aur_pkgs[@]}"

  # build aur message
  if [[ ${aur_cnt} -gt 0 ]]
  then
    aur_msg+="AUR: ${aur_cnt}"
    for p in "${aur_pkgs[@]}"
    do
      aur_msg+="\n- ${p}"
    done
  fi

  # add aur message
  if [[ -n "${aur_msg}" ]]
  then
    # prepend newline if there were also repo updates
    if [[ -n "${repo_msg}" ]]
    then
      notify_msg+="\n"
    fi
    notify_msg+="${aur_msg}"
  fi

  # display notification if updates found
  if [[ "${repo_cnt}" -ne "${repo_last}" ]] || [[ "${aur_cnt}" -ne "${aur_last}" ]]
  then
    if [[ "${repo_cnt}" -gt 0 ]] || [[ "${aur_cnt}" -gt 0 ]]
    then
      title="Software Updates Avaiable"
      body="${notify_msg}"
      notify-send -a updates -u low "${title}" "${body}"
    fi
  fi
  unset repo_msg aur_msg notify_msg

  # update last counts
  repo_last=${repo_cnt}
  aur_last=${aur_cnt}
  unset repo_cnt aur_cnt

  # wait
  sleep ${interval}
done

exit 0

# vim: ft=sh ts=2 sw=0 et:
