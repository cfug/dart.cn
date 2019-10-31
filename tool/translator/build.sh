#!/usr/bin/env bash

set -e -o pipefail

source ./tool/shared/env-set-check.sh

while [[ "$1" == -* ]]; do
  case "$1" in
    --check-links) CHECK_LINKS=1; shift;
                   # Use remaining arguments for call to check-links
                   break;;
    -h|--help)     echo "Usage: $(basename $0) [--help] [--check-links ...check-link-options]";
                   exit 0;;
    *)             echo "ERROR: Unrecognized option: $1. Use --help for details.";
                   exit 1;;
  esac
done

travis_fold start build_site
  (
    set -x;
    bundle exec jekyll build;
  )
travis_fold end build_site

[[ -z $CHECK_LINKS ]] && exit

travis_fold start check_links
  (
    set -x;
    ./tool/shared/check-links.sh $*;
  )
travis_fold end check_links

travis_fold start english_chinese_toggle
  (
  
    set -x
    
    set -e

    cp -r tool/translator/assets/*  _site/assets/
    
    cp tool/translator/robots.txt _site
    
    cd tool/translator
    
    npm i
    
    npx gulp mark-side-toc
    
    npx nt inject '../../_site/**/*.html' -c /assets/translator/css/translator.css -s /assets/translator/js/translator.js -m ./url-map.json -t ./text-map.json
    
    npx nt mark '../../_site/**/*.html'
    
    npx gulp remove-space
    
    cd -
  )
travis_fold end english_chinese_toggle

# set -x
# set -e

# bundle exec jekyll build

# cp -r tool/translator/assets/*  _site/assets/

# cp tool/translator/robots.txt _site

# cd tool/translator

# npm i

# npx gulp mark-side-toc

# npx nt inject '../../_site/**/*.html' -c /assets/translator/css/translator.css -s /assets/translator/js/translator.js -m ./url-map.json -t ./text-map.json

# npx nt mark '../../_site/**/*.html'

# npx gulp remove-space

# cd -
