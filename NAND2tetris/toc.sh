cat notes.md | grep '^\#\# .*$' > lecs;
python3 toc.py;
rm lecs;