#!/bin/bash
gitbook build
gitbook pdf
gitbook epub
gitbook mobi
mv book.pdf _book
mv book.epub _book
mv book.mobi _book
chmod +r _book/book.pdf _book/book.epub _book/book.mobi
cd _book
rsync -azv . circl@cpab:/var/www/nwww.circl.lu/doc/misp/ && rm -rf _book
