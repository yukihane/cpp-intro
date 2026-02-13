set -eu

# Clear out junk
rm -f *.aux
rm -f *.toc
rm -f cpp-intro.dvi
rm -f cpp-intro.pdf

# This document hits known compatibility warnings/errors on modern TeX Live,
# so run non-interactively and continue until DVI/PDF output is attempted.
uplatex -kanji=utf8 -interaction=nonstopmode -file-line-error cpp-intro || true

mendex -U -s indexstyle.ist -o cpp-intro.ind cpp-intro.idx
uplatex -kanji=utf8 -interaction=nonstopmode -file-line-error cpp-intro || true

uplatex -kanji=utf8 -interaction=nonstopmode -file-line-error cpp-intro || true
sleep 1
dvipdfmx cpp-intro

test -s cpp-intro.pdf
