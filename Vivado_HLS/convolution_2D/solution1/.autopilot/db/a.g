#!/bin/sh
lli=${LLVMINTERP-lli}
exec $lli \
    /home/darkin/Workspace/Vivado_HLS/convolution_2D/solution1/.autopilot/db/a.g.bc ${1+"$@"}
