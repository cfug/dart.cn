#!/usr/bin/env bash

set -x
set -e

commitSha=$(git rev-parse --short HEAD)
commitMessage=$(git log --oneline -n 1)

rm -rf /tmp/site-dart.cn/ || true

git clone https://chenglu:${CHENGLU_DEPLOY_KEY}@github.com/chenglu/site-dart.cn.git /tmp/site-dart.cn/

# cd /tmp/site-dart.cn/

# git rm -rf .
# git add .
# git commit --allow-empty -am "empty repo first"

cp -r _site/* /tmp/site-dart.cn/

cd /tmp/site-dart.cn/

git config --global user.name "travis-ci deploy"
git config --global user.email "cfug-dev@googlegroups.com"

git add .
git commit --allow-empty -am "${commitMessage}"

git push -u -f origin master

cd -
