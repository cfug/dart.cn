#!/usr/bin/env sh

set -x
set -e

./translator/translate.sh

commitSha=$(git rev-parse --short HEAD)
commitMessage=$(git log --oneline -n 1)

git clone https://cfug-deploy:${CFUG_DEPLOY_KEY}@github.com/cfug-deploy/dartlang-cn-prebuilt.git ./prebuilt

cp -r _site/* prebuilt

cd prebuilt

git add .
git commit -m "${commitSha} - ${commitMessage}"

git push

cd -
