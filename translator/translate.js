const {addTranslationMark, handleHtmlFiles, injectTranslators, replaceResourceUrls} = require('@awesome-fe/translate');
const sh = require('shelljs');

sh.cp('-r', __dirname + '/assets', __dirname + '/../_site/');
handleHtmlFiles(__dirname + '/../_site/**/*.html', 'utf-8', (doc) => {
  addTranslationMark(doc);
  injectTranslators(doc, ['/assets/translator/css/translator.css'], ['/assets/translator/js/translator.js']);
  replaceResourceUrls(doc, {
    'https://fonts.googleapis.com/icon?family=Material+Icons': '/assets/translator/css/Material_Icons.css',
    'https://fonts.googleapis.com/css?family=Source+Sans+Pro:400,300,700': '/assets/translator/css/Source_Sans_Pro.css',
  });
});
