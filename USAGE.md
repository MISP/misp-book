
Install notes
=============

:warning: Make sure to be in the *misp-book* repository directory for the *npm magic*.
Also: The *npm* plugin *autocover* is broken. It pulls an incompatible *canvas* module version. Thus patched repository used (forked from original)
Finally: You will get a few errors on Ubuntu 18.04 which you can ignore for now. In the rather near future we need to think about an alternative as gitbook glides towards obsoletion and security risk.
Reason for concern:
```
npm WARN deprecated ignore@3.1.2: several bugs fixed in v3.2.1
npm WARN deprecated tough-cookie@2.2.2: ReDoS vulnerability parsing Set-Cookie https://nodesecurity.io/advisories/130
npm WARN deprecated node-uuid@1.4.8: Use uuid module instead
npm WARN deprecated hoek@2.16.3: The major version is no longer supported. Please update to 4.x or newer
npm WARN deprecated datauri@0.2.1: Potential REDOS vulnerability removed in v1.1.0
npm WARN deprecated coffee-script@1.12.7: CoffeeScript on NPM has moved to "coffeescript" (no hyphen)
```


Tested on: *Ubuntu 18.04 LTS* *Debian 9.5/sid/testing*
[Terminal Recording of npm install lines on Ubuntu 18.04](https://asciinema.org/a/84JZMuGu2QlFH59q6mK8jbdQS)

```bash
git clone git@github.com:MISP/misp-book.git
cd misp-book
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo apt-get install -y build-essential
sudo apt install -y pkg-config libcairo2-dev libgif-dev libjpeg-dev
npm install gitbook git+https://github.com/SteveClement/plugin-autocover.git gitbook-plugin-github gitbook-plugin-toc gitbook-plugin-anchors gitbook-plugin-image-class gitbook-plugin-last-modified gitbook-plugin-last-modified

sudo npm install gitbook-cli -g
gitbook install
```

Usage
=====

If you want to generate the PDF output (you need to have Calibre installed):

```bash
$ time gitbook pdf
info: 13 plugins are installed
info: 12 explicitly listed
info: loading plugin "autocover"... OK
info: loading plugin "github"... OK
info: loading plugin "toc"... OK
info: loading plugin "anchors"... OK
info: loading plugin "alerts"... OK
info: loading plugin "advanced-emoji"... OK
info: loading plugin "highlight"... OK
info: loading plugin "search"... OK
info: loading plugin "lunr"... OK
info: loading plugin "sharing"... OK
info: loading plugin "fontsettings"... OK
info: loading plugin "theme-default"... OK
info: found 23 pages
info: found 201 asset files
warn: "options" property is deprecated, use config.get(key) instead
info: >> generation finished with success in 58.8s !
info: >> 1 file(s) generated
gitbook pdf  47.51s user 2.51s system 81% cpu 1:01.21 total
```

on macOS (ebook-convert is not in path):

```bash
$ PATH=$PATH:/Applications/calibre.app/Contents/MacOS/ ; gitbook pdf
```

and if you want to want to serve the HTML pages on 127.0.0.1:4000:

```bash
$ time gitbook serve
Live reload server started on port: 35729
Press CTRL+C to quit ...

info: 13 plugins are installed
info: loading plugin "autocover"... OK
info: loading plugin "github"... OK
info: loading plugin "toc"... OK
info: loading plugin "anchors"... OK
info: loading plugin "alerts"... OK
info: loading plugin "advanced-emoji"... OK
info: loading plugin "livereload"... OK
info: loading plugin "highlight"... OK
info: loading plugin "search"... OK
info: loading plugin "lunr"... OK
info: loading plugin "sharing"... OK
info: loading plugin "fontsettings"... OK
info: loading plugin "theme-default"... OK
info: found 23 pages
info: found 201 asset files
warn: "options" property is deprecated, use config.get(key) instead
info: >> generation finished with success in 42.1s !

Starting server ...
Serving book on http://localhost:4000
^C
gitbook serve  37.61s user 3.75s system 52% cpu 1:19.15 total
```

:warning: It can take up to 60 seconds for the entire *misp-book* to be generated before the content is available on port 4000. Please be patient ;)


macOS Notes
===========

canvas needs to be compiled and needs the following dependencies:

```
xcode-select --install
# If you have homebrew not installed yet:
## /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
# For the more adventureous you can install a cask of calibre which gives you access to *ebook-convert*
## brew cask install calibre
brew install pkg-config cairo pango libpng jpeg giflib
```

:warning: Make sure to be in the *misp-book* repository directory for the npm magic to work correctly.

Installing gitbook and all dependencies wants to look like this (Tested on *macOS 11.13.3*):

```bash
npm install gitbook git+https://github.com/SteveClement/plugin-autocover.git gitbook-plugin-github gitbook-plugin-toc gitbook-plugin-anchors gitbook-plugin-image-class
npm install gitbook-cli -g
gitbook install
```

gitbook rebuild on change
=========================

By default gitbook has the '--watch' option enabled.
If this is broken, use the included 'serve.sh' and the 'inoticoming' package.
Start 'gitbook serve &' and run the following command line:

```
inoticoming --foreground . --suffix .md bash serve.sh \;
```

If any md changes, the gitbook process is killed and restarted.

npm salvage
===========

In case something with npm breaks, this brings you back to a sane default.
We still assume we are in the *misp-book* repository working directory.

```bash
rm -rf node_modules
rm package-lock.json
rm -rf ~/.gitbook
sudo rm -rf /usr/local/lib/node_modules/gitbook-cli
```
