#!/bin/sh
exitCode=0
for file in `ls **/*.bicep`; do
    mkdir -p ${RUNNER_TEMP}/`dirname $file`
    az bicep build --file $file --outdir ${RUNNER_TEMP}/`dirname $file` 2>&1  | tee | grep -e Error -e Warning
    if [ $? -eq 0 ]; then
        exitCode=1
    fi
    echo "$file checked"
done
exit $exitCode
