#!/usr/bin/env bash

set -x
set -e

commitSha=$(git rev-parse --short HEAD)
commitMessage=$(git log --oneline -n 1)

rm -rf /tmp/dartlang.cn-prebuilt/ || true

git clone https://cfug-deploy:${CFUG_DEPLOY_KEY}@github.com/cfug-deploy/dartlang-cn-prebuilt.git /tmp/dartlang.cn-prebuilt/

cp -r _site/* /tmp/dartlang.cn-prebuilt/

cd /tmp/dartlang.cn-prebuilt

git init
git add .
git commit --allow-empty -am "${commitMessage}"

git push -u -f origin master

cd -
