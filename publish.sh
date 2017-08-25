#!/bin/bash
gitbook build
gitbook pdf
gitbook epub
gitbook mobi
cp book.pdf _book
cp book.epub _book
cp book.mobi _book
cd _book
rsync -av . circl@cpab.circl.lu:/var/www/nwww.circl.lu/doc/misp/
