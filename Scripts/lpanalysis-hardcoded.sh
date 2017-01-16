#!/bin/bash

exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>analysis_out.log 2>&1

PATH=$PATH:/usr/local/bin/:/Library/Frameworks/Python.framework/Versions/3.4/bin:/Library/Frameworks/Python.framework/Versions/3.4/bin:/bin:/sbin:/usr/bin:/usr/sbin:/Users/jchittum/bin:/opt/local/bin:/usr/local/bin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/libexec

echo $PATH

csound -U lpanal -h400 -p50 soundin.104 analysis/lp.initialvoice