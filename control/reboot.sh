#!/bin/bash
set -e

if [ ! -f "./reboot.sh" ]; then
   echo "This script must be run in the 'questlab/control' directory"
   exit 1
fi

./setup.sh reboot

