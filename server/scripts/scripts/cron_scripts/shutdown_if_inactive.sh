#!/bin/bash
#
# Reference: https://serverfault.com/a/1061792, https://dev.to/kpldvnpne/how-to-auto-shutdown-when-you-are-not-using-the-ec2-instance-5g5e
# Shuts down the host on inactivity.
#
# Designed to be executed as root from a cron job.
# It will power off on the 2nd consecutive run without an active ssh session.
# That prevents an undesirable shutdown when the machine was just started, or on a brief disconnect.
#
# To enable, add this entry to /etc/crontab + make exec:
# */10 *   * * *   root    /home/ubuntu/server-config/scripts/shutdown_if_inactive.sh
# sudo chmod +x ~/server-config/scripts/shutdown_if_inactive.sh
#
set -o nounset -o errexit -o pipefail

MARKER_FILE="/tmp/ssh-inactivity-flag"

STATUS=$(netstat | grep ssh | grep ESTABLISHED &>/dev/null && echo active || echo inactive)

if [ "$STATUS" == "inactive" ]; then
  if [ -f "$MARKER_FILE" ]; then
    echo "Powering off due to ssh inactivity."
    rm "$MARKER_FILE"
    /sbin/shutdown -h now
  else
    # Create a marker file so that it will shut down if still inactive on the next time this script runs.
    touch "$MARKER_FILE"
  fi
else
  # Delete marker file if it exists
  rm --force "$MARKER_FILE"
fi