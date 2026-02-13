set -eu

# Clear out junk
rm -f *.aux
rm -f *.toc
rm -f cpp-intro.dvi
rm -f cpp-intro.pdf
rm -f cpp-intro-view.pdf

# This document hits known compatibility warnings/errors on modern TeX Live,
# so run non-interactively and continue until DVI/PDF output is attempted.
uplatex -kanji=utf8 -interaction=nonstopmode -file-line-error cpp-intro || true

mendex -U -s indexstyle.ist -o cpp-intro.ind cpp-intro.idx
uplatex -kanji=utf8 -interaction=nonstopmode -file-line-error cpp-intro || true

uplatex -kanji=utf8 -interaction=nonstopmode -file-line-error cpp-intro || true
sleep 1
dvipdfmx cpp-intro

test -s cpp-intro.pdf

# Generate a screen-friendly variant with tighter margins while keeping pagination.
# Tune these values if a different visible margin is preferred.
VIEW_TRIM_LEFT=36
VIEW_TRIM_BOTTOM=72
VIEW_PAGE_WIDTH=600
VIEW_PAGE_HEIGHT=828

cat > /tmp/cpp-intro-view-setpagedevice.ps <<EOF
<< /BeginPage { -${VIEW_TRIM_LEFT} -${VIEW_TRIM_BOTTOM} translate } >> setpagedevice
EOF

gs -q \
  -dNOPAUSE \
  -dBATCH \
  -sDEVICE=pdfwrite \
  -dCompatibilityLevel=1.5 \
  -dFIXEDMEDIA \
  -dDEVICEWIDTHPOINTS="${VIEW_PAGE_WIDTH}" \
  -dDEVICEHEIGHTPOINTS="${VIEW_PAGE_HEIGHT}" \
  -sOutputFile=cpp-intro-view.pdf \
  -f /tmp/cpp-intro-view-setpagedevice.ps \
  cpp-intro.pdf

test -s cpp-intro-view.pdf
