#!/bin/sh
lli=${LLVMINTERP-lli}
exec $lli \
    /home/darkin/Workspace/Vivado_HLS/image_contrast_adj/solution1/.autopilot/db/a.g.bc ${1+"$@"}
