#!/bin/bash
echo "1/4 html"
npx honkit build
echo "2/4 pdf"
npx honkit pdf
echo "3/4 epub"
npx honkit epub
echo "4/4 mobi"
npx honkit mobi
echo "Done"
mv book.pdf _book
mv book.epub _book
mv book.mobi _book
chmod +r _book/book.pdf _book/book.epub _book/book.mobi
cd _book
rsync -azv . circl@cpab.circl.lu:/var/www/nwww.circl.lu/doc/misp/ && rm -rf _book
