#!/usr/bin/env bash
# Regenerate QR + render both PDFs from HTML.
# Requires: python3 with qrcode (`pip3 install qrcode`), Google Chrome installed.

set -e
cd "$(dirname "$0")"

CV_SPLAT_URL="https://factsplat.com/splats/b181d1ab-31d4-48d6-a331-e6be47193a74"
CHROME='/Applications/Google Chrome.app/Contents/MacOS/Google Chrome'

# QR code
python3 -c "
import qrcode
img = qrcode.make('$CV_SPLAT_URL')
img.save('qr.png')
"

# Render PDFs
"$CHROME" --headless=new --disable-gpu --no-pdf-header-footer \
  --print-to-pdf=svenn-cv-no.pdf "file://$PWD/svenn-cv-no.html"

"$CHROME" --headless=new --disable-gpu --no-pdf-header-footer \
  --print-to-pdf=svenn-cv-en.pdf "file://$PWD/svenn-cv-en.html"

echo "Built: svenn-cv-no.pdf, svenn-cv-en.pdf"
ls -lh svenn-cv-*.pdf
