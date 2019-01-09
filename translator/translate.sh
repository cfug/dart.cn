#!/usr/bin/env sh

set -x
set -e

cd `dirname $0`

npm install
npm start

cd -
