#!/bin/bash
set -euo pipefail
scriptdir=$(cd $(dirname $0) && pwd)

# install CDK CLI from npm, so that npx can find it later
cd $scriptdir/../java
npm install

# Find and build all Maven projects
for pomFile in $(find $scriptdir/../java -name pom.xml); do
    (
        echo "=============================="
        echo "building project: $pomFile"
        echo "=============================="

        cd $(dirname $pomFile)
        if [[ -f DO_NOT_AUTOTEST ]]; then exit 0; fi
        
        mvn compile test

        $scriptdir/synth.sh
    )
done
