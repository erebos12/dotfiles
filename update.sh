#!/bin/sh

git fetch --all
git reset --hard origin/master
git submodule update --recursive --remote --init

source "`uname -s`.md"
./stowthis.sh [^_]*/
