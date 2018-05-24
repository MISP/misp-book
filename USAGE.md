
Install notes
=============

:warning: Make sure to be in the *misp-book* repository directory for the *npm magic*.
Also: The *npm* plugin *autocover* is broken. It pulls an incompatible *canvas* module version. Thus patched repository used (forked from original)

Tested on: *Ubuntu 16.04.4 LTS*

```bash
curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo apt-get install -y build-essential
sudo apt install -y npm pkg-config libcairo2-dev
npm install gitbook git+https://github.com/SteveClement/plugin-autocover.git gitbook-plugin-github gitbook-plugin-toc gitbook-plugin-anchors gitbook-plugin-image-class
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

:warning: Make sure to be in the *misp-book* repository directory for the npm magic.

Installing gitbook and all dependencies wants to look like this (Tested on *macOS 11.13.3*):

```bash
npm install gitbook git+https://github.com/SteveClement/plugin-autocover.git gitbook-plugin-github gitbook-plugin-toc gitbook-plugin-anchors gitbook-plugin-image-class
npm install gitbook-cli -g
gitbook install
```

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
