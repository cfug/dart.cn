#!/usr/bin/env bash

# set -e -o pipefail

# source ./tool/shared/env-set-check.sh // shared folder no longer exists

# while [[ "$1" == -* ]]; do
#   case "$1" in
#     --check-links) CHECK_LINKS=1; shift;
#                    # Use remaining arguments for call to check-links
#                    break;;
#     -h|--help)     echo "Usage: $(basename $0) [--help] [--check-links ...check-link-options]";
#                    exit 0;;
#     *)             echo "ERROR: Unrecognized option: $1. Use --help for details.";
#                    exit 1;;
#   esac
# done

# echo "::group::build_site"

# bundle exec jekyll --version;
# set -x;
# bundle exec jekyll build;

# echo "::endgroup::"

# [[ -z $CHECK_LINKS ]] && exit

# echo "::group::check_links"

# set -x;
# ./tool/shared/check-links.sh $*;

# echo "::endgroup::"

# echo "::group::english_chinese_toggle"

bundle exec jekyll --version;
set -x;
bundle exec jekyll build;

set -x
set -e
pwd

mkdir -p _site/assets/
cp -r tool/translator/assets/*  _site/assets/
cp tool/translator/robots.txt _site
cd tool/translator

npm i
npx gulp mark-side-toc
npx nt inject '../../_site/**/!(*_cn).html' -c /assets/translator/css/translator.css -s /assets/translator/js/translator.js -m ./url-map.json -t ./text-map.json
npx nt mark '../../_site/**/!(*_cn).html'
npx gulp remove-space
cd -

# echo "::endgroup::"
