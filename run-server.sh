#!/bin/bash
cd /nwn/bin/linux-x86
export LD_PRELOAD="/nwnx/NWNX_Core.so"
./nwserver-linux "$@" 2>&1
