#!/bin/bash
SRCDIR="./src/"
OUTDIR="./out/"
BUILDSITESCRIPT="./build-scripts/build-site.sh"
SRCHASHSUMSCRIPT="./build-scripts/hashdir.sh"
SRCHASHSUM=$(sh $SRCHASHSUMSCRIPT $SRCDIR)

sh $BUILDSITESCRIPT

echo "\e[34mWill open $(realpath $OUTDIR/index.html) using default browser.\e[39m"
open $(realpath $OUTDIR/index.html) 2>/dev/null &

echo "\e[34mWatching directory $SRCDIR...\e[39m"
while true; do
    PRESRCHASHSUM=$SRCHASHSUM
    SRCHASHSUM=$(sh $SRCHASHSUMSCRIPT $SRCDIR)
    if [ "$PRESRCHASHSUM" = "$SRCHASHSUM" ]; then
        sleep 0.5
    else
        echo "\e[34mDirectory fingerptint changed...\e[39m \e[90m($SRCHASHSUM)\e[39m"
        sh "./build-site.sh"
    fi
done