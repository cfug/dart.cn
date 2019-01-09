#!/usr/bin/env sh

set -x
set -e

commitSha=$(git rev-parse --short HEAD)
commitMessage=$(git log --oneline -n 1)

git clone https://asnowwolf:${GITHUB_ACCESS_TOKEN}@cfug/dartweb-docs-cn-prebuilt.git ./prebuilt

cd prebuilt

cp -r _site/* .

git add .
git commit -m "${commitSha} - ${commitMessage}"

git push

cd -
