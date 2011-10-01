#!/bin/csh -f

if ($#argv != 2) then
    echo "Usage: $0 source dest"
    echo "copies all files of source component to destination component"
    goto done
endif
##                  save command line args in variables
set sourceComponent=$1
set destComponent=$2

if (-r "$sourceComponent.h" &&  !(-e "$destComponent.h")) then
  cp "$sourceComponent.h" "$destComponent.h"
endif
  

