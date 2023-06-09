#!/bin/bash

# Run with: ./prebuild.sh "53.1" "5302"

# Arguments: the patch script variables:
#  * $$VERSION$$
#  * $$VERCODE$$

version=$1
vercode=$2

appName="StreetComplete DjBpF"

# Fail on any error
set -e

# Always start from the directory this script is in

script_dir="$PWD";
#script_dir="$(dirname -- "$( readlink -f -- "$0"; )")";

echo "SCRIPT DIR: $script_dir"

pushd "$script_dir"

android_dir="$script_dir"
app_dir="$android_dir/app"
#stubs_dir="$android_dir/.patch/stubs"

# BUILD: Add enough memory for the build on FDroid
#echo -e "\norg.gradle.jvmargs=-XX:MaxHeapSize=4096m" \
#    >> "$android_dir/gradle.properties"

# BUILD: Sub in the right build information (version/appname)
sed -i \
    -r "s/versionName = \"([0-9\.]{4})\"/versionName = \"$version\"/" \
    "$app_dir/build.gradle.kts"
sed -i \
    -r "s/versionCode = ([0-9]{4})/versionCode = $vercode/" \
    "$app_dir/build.gradle.kts"
#sed -i \
#    -e "s/\"OsmAnd Nightly\"/\"$appName\"/g" \
#    "$app_dir/build.gradle"

# also rename package
sed -i \
    -e "s/applicationId = \"de.westnordost.streetcomplete\"/applicationId = \"de.westnordost.streetcomplete.djbpf\"/g" \
    "$app_dir/build.gradle.kts"

# return from whence we came (just in case)
popd
