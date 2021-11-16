cat $1 | grep '^# \w.*$' > lecs;
python3 toc.py;
rm lecs;