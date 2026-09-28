#!/bin/bash
while true; do
  if ss -tn state established '( sport = :22 )' | tail -n +2 | grep -q .; then
    systemd-inhibit --what=sleep:idle --who=sshd --why="active ssh session" sleep 60
  else
    sleep 30
  fi
done
