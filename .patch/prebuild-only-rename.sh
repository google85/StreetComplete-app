#!/bin/bash

# Run with: ./prebuild.sh "4.2.7" "4207"

# Arguments: the patch script variables:
#  * $$VERSION$$
#  * $$VERCODE$$

version=$1
vercode=$2

appName="OsmAndDjBpF"

# Fail on any error
set -e

# Always start from the directory this script is in

script_dir="$(dirname -- "$( readlink -f -- "$0"; )")";
#script_dir="$(dirname $PWD)";

echo "SCRIPT DIR: $script_dir"

pushd "$script_dir"

android_dir="$script_dir"
app_dir="$android_dir/app"
#stubs_dir="$android_dir/.patch/stubs"

echo "APP DIR: $app_dir"
ls -al $android_dir

# BUILD: Add enough memory for the build on FDroid
#echo -e "\norg.gradle.jvmargs=-XX:MaxHeapSize=4096m" \
#    >> "$android_dir/gradle.properties"

# BUILD: Sub in the right build information (version/appname)
#sed -i \
#    -e "s/System.getenv(\"APK_VERSION\")/\"$version\"/g" \
#    "$app_dir/build.gradle"
#sed -i \
#    -e "s/System.getenv(\"APK_NUMBER_VERSION\")/\"$vercode\"/g" \
#    "$app_dir/build.gradle"
#sed -i \
#    -e "s/System.getenv(\"TARGET_APP_NAME\")/\"$appName\"/g" \
#    "$app_dir/build.gradle"
#sed -i \
#    -e "s/\"OsmAnd Nightly\"/\"$appName\"/g" \
#    "$app_dir/build.gradle"

# also rename package
sed -i \
    -e "s/\"de.westnordost.streetcomplete\"/\"de.westnordost.streetcomplete.djbpf\"/g" \
    "$app_dir/build.gradle.kts"

# return from whence we came (just in case)
popd
