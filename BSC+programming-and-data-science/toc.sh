cat notes.md | grep '^## [Ll]ec .*$' > lecs;
python3 ../../../toc.py;
rm lecs;