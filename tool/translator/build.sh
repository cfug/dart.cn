#!/usr/bin/bash

npm install

if [[ $JEKYLL_ENV == 'development' ]]; then
  bundle exec jekyll build --config _config.yml,_config_dev.yml
else
  bundle exec jekyll build --config _config.yml
fi

mkdir -p _site/assets/
cp -r tool/translator/assets/*  _site/assets/
cp tool/translator/robots.txt _site
cd tool/translator

npm i
npx gulp mark-side-toc
npx nt inject '../../_site/**/!(*_cn).html' -c /assets/translator/css/translator.css -s /assets/translator/js/translator.js -m ./url-map.json -t ./text-map.json
npx nt export '../../_site/**/!(*_cn).html' --mono
npx gulp remove-space
cd -

# echo "::endgroup::"
