Install notes
=============

:warning: Make sure to be in the *misp-book* repository directory for the *npm magic*.<br />

Reason for concern:
```
npm WARN deprecated gulp-header@1.8.12: Removed event-stream from gulp-header
npm WARN deprecated har-validator@5.1.5: this library is no longer supported
npm WARN deprecated har-validator@2.0.6: this library is no longer supported
npm WARN deprecated cryptiles@2.0.5: This version has been deprecated in accordance with the hapi support policy (hapi.im/support). Please upgrade to the latest version to get the best features, bug fixes, and security patches. If you are unable to upgrade at this time, paid support is available for older versions (hapi.im/commercial).
npm WARN deprecated boom@2.10.1: This version has been deprecated in accordance with the hapi support policy (hapi.im/support). Please upgrade to the latest version to get the best features, bug fixes, and security patches. If you are unable to upgrade at this time, paid support is available for older versions (hapi.im/commercial).
npm WARN deprecated sntp@1.0.9: This module moved to @hapi/sntp. Please make sure to switch over as this distribution is no longer supported and may contain bugs and critical security issues.
npm WARN deprecated uuid@3.4.0: Please upgrade  to version 7 or higher.  Older versions may use Math.random() in certain circumstances, which is known to be problematic.  See https://v8.dev/blog/math-random for details.
npm WARN deprecated tough-cookie@2.2.2: ReDoS vulnerability parsing Set-Cookie https://nodesecurity.io/advisories/130
npm WARN deprecated node-uuid@1.4.8: Use uuid module instead
npm WARN deprecated hoek@2.16.3: This version has been deprecated in accordance with the hapi support policy (hapi.im/support). Please upgrade to the latest version to get the best features, bug fixes, and security patches. If you are unable to upgrade at this time, paid support is available for older versions (hapi.im/commercial).
npm WARN deprecated request@2.88.2: request has been deprecated, see https://github.com/request/request/issues/3142
npm WARN deprecated request@2.67.0: request has been deprecated, see https://github.com/request/request/issues/3142
npm WARN deprecated coffee-script@1.12.7: CoffeeScript on NPM has moved to "coffeescript" (no hyphen)
npm WARN deprecated hawk@3.1.3: This module moved to @hapi/hawk. Please make sure to switch over as this distribution is no longer supported and may contain bugs and critical security issues.

added 492 packages, and audited 493 packages in 22s

38 packages are looking for funding
  run `npm fund` for details

21 vulnerabilities (6 moderate, 12 high, 3 critical)

To address issues that do not require attention, run:
  npm audit fix
#weHaveBeenWarned
```


Tested on: *Ubuntu 22.04 LTS* & *Debian 11.3*

```bash
git clone git@github.com:MISP/misp-book.git
cd misp-book
sudo apt install -y npm
sudo apt install -y pkg-config libcairo2-dev libgif-dev libjpeg-dev
sudo apt install -y calibre  # for generating PDFs
npm install honkit gitbook-plugin-github gitbook-plugin-atoc gitbook-plugin-anchors gitbook-plugin-alerts gitbook-plugin-search gitbook-plugin-gist gitbook-plugin-advanced-emoji gitbook-plugin-sitemap gitbook-plugin-codesnippet gitbook-plugin-image-class gitbook-plugin-last-modified gitbook-plugin-fontsettings
```

Plugins
=======

The following plugins are installed and this is how they impact the build.


+ gitbook-plugin-codesnippet@1.2.0

  You can include any code snippet from a file like follows.
  ```
  {% codesnippet "/pymisp/last.py", language="python" %}{% endcodesnippet %}
  ```


+ gitbook-plugin-advanced-emoji@0.2.2

  This plainly enables converting ```:smile:``` to :smile:
  Consult the [Emoji Cheat Sheeet](https://www.webpagefx.com/tools/emoji-cheat-sheet/) for a reference.


+ gitbook-plugin-alerts@0.2.0

  Info, warning, danger, success blockquotes for your gitbook.

  Warning styling
  ```
  > **[warning] For warning**
  >
  > Use this for warning messages.
  ```

  Danger styling
  ```
  > **[danger] For danger**
  >
  > Use this for danger messages.
  ```

  Success styling
  ```
  > **[success] For info**
  >
  > Use this for success messages.
  ```


+ gitbook-plugin-gist@1.0.0

  With this plugin you can include GitHub Gists](https://gist.github.com)
  ```
  {% gist id="https://gist.github.com/SteveClement/1ba901612a97d63938ed5cf32c2100ee" %}{% endgist %}
  
  {% gist id="SteveClement/1ba901612a97d63938ed" %}{% endgist %}
  
  {% gist id="SteveClement/1ba901612a97d63938ed",file="README.md" %}{% endgist %}
  
  {% gist id="SteveClement/1ba901612a97d63938ed",hideFooter=true %}{% endgist %}
  ```


+ gitbook-plugin-sitemap@1.2.0

  With this we include a **sitemape.xml** in the webroot directory.


+ gitbook-plugin-last-modified@1.0.0

  You will see a **Last modified: Thu Nov 01 2018 16:29:37 GMT+0100 (CET)** string on top of all the generated pages.


+ gitbook-plugin-image-class@1.0.5

  The [image-class](https://www.npmjs.com/package/gitbook-plugin-image-class) plugin allows you more flexibility in including images.
  See the above link for examples.

Usage
=====

If you want to generate the PDF output (you need to have Calibre installed):

```bash
$ time honkit pdf
info: 13 plugins are installed 
info: 13 explicitly listed 
info: plugin "atoc" is loaded
info: plugin "github" is loaded
info: plugin "codesnippet" is loaded
info: plugin "last-modified" is loaded
info: plugin "anchors" is loaded
info: plugin "sitemap" is loaded
info: plugin "advanced-emoji" is loaded
info: plugin "image-class" is loaded
info: plugin "highlight" is loaded
info: plugin "search" is loaded
info: plugin "lunr" is loaded
info: plugin "fontsettings" is loaded
info: plugin "theme-default" is loaded
info: found 37 pages 
info: found 278 asset files 
warn: "options" property is deprecated, use config.get(key) instead 
warn: "this.generator" property is deprecated, use "this.output.name" instead 
warn: "navigation" property is deprecated 
warn: "book" property is deprecated, use "this" directly instead 
info: >> generation finished with success in 156.1s ! 
info: >> 1 file(s) generated 
npx honkit pdf  115.55s user 2.26s system 74% cpu 2:37.29 total
```

on macOS (ebook-convert is not in path):

```bash
$ PATH=$PATH:/Applications/calibre.app/Contents/MacOS/ ; honkit pdf
```

and if you want to want to serve the HTML pages on 127.0.0.1:4000:

```bash
$ time npx honkit serve
Live reload server started on port: 35729
Press CTRL+C to quit ...

Starting server ...
info: 14 plugins are installed 
info: 14 explicitly listed 
info: plugin "atoc" is loaded
info: plugin "github" is loaded
info: plugin "codesnippet" is loaded
info: plugin "last-modified" is loaded
info: plugin "anchors" is loaded
info: plugin "sitemap" is loaded
info: plugin "advanced-emoji" is loaded
info: plugin "image-class" is loaded
info: plugin "livereload" is loaded
info: plugin "highlight" is loaded
info: plugin "search" is loaded
info: plugin "lunr" is loaded
info: plugin "fontsettings" is loaded
info: plugin "theme-default" is loaded
info: found 37 pages 
info: found 277 asset files 
warn: "options" property is deprecated, use config.get(key) instead 
warn: "this.generator" property is deprecated, use "this.output.name" instead 
warn: "navigation" property is deprecated 
warn: "book" property is deprecated, use "this" directly instead 

info: >> generation finished with success in 103.7s ! 
Serving book on http://localhost:4000
^C
npx honkit serve  118.09s user 1.59s system 109% cpu 1:49.14 total
```

:warning: It can take up to 120 seconds for the entire *misp-book* to be generated before the content is available on port 4000. Please be patient ;)


macOS Notes
===========

canvas needs to be compiled and needs the following dependencies:

```
xcode-select --install
# If you have homebrew not installed yet:
## /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
# For the more adventurous you can install a cask of calibre which gives you access to *ebook-convert*
## brew cask install calibre
brew install pkg-config cairo pango libpng jpeg giflib
```

:warning: Make sure to be in the *misp-book* repository directory for the npm magic to work correctly.

Installing honkit and all dependencies wants to look like this (Tested on *macOS 11.13.3*):

```bash
npm install honkit gitbook-plugin-github gitbook-plugin-atoc gitbook-plugin-anchors gitbook-plugin-alerts gitbook-plugin-search gitbook-plugin-gist gitbook-plugin-advanced-emoji gitbook-plugin-sitemap gitbook-plugin-codesnippet gitbook-plugin-image-class gitbook-plugin-last-modified gitbook-plugin-fontsettings
```

honkit rebuild on change
=========================

By default honkit has the '--watch' option enabled.
If this is broken, use the included 'serve.sh' and the 'inoticoming' package.
Start 'honkit serve &' and run the following command line:

```
inoticoming --foreground . --suffix .md bash serve.sh \;
```

If any md changes, the honkit process is killed and restarted.

npm salvage
===========

In case something with npm breaks, this brings you back to a sane default.
We still assume we are in the *misp-book* repository working directory.

```bash
rm -rf node_modules
rm package-lock.json
```
