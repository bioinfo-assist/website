#!/bin/bash

# Generate logo assets (favicon, PNG, SVG) from the master SVG source using ImageMagick.
#
# Favicon files use only the logo mark (text stripped) since text is unreadable
# at 16-48 px sizes.
#
# PNG sizes are 600 px wide (8-bit): roughly 2.4x the 256 px hero display size,
# sharp on retina screens while keeping file sizes small.
#
# Outputs:
#   static/favicon.ico                           multi-size favicon (16/32/48 px) for legacy browsers
#   static/favicon.svg                           SVG favicon (logo mark only) for modern browsers
#   static/images/BioinfoBoost-logo.svg          synced copy of the master SVG (page usage)
#   static/images/BioinfoBoost-logo.png          gradient logo, transparent background
#   static/images/BioinfoBoost-logo-solid.png    solid-color (#0083D7) logo, transparent background
#   static/images/BioinfoBoost-logo.white.png    gradient logo, white background
#   static/images/BioinfoBoost-logo-solid.white.png  solid-color logo, white background
#
# Usage: npm run generate:logo
# Override the source with: LOGO_SRC=/path/to/logo.svg npm run generate:logo

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

DEFAULT_SRC="$PROJECT_ROOT/../Trademark/BioinfoBoost-logo.svg"
LOGO_SRC="${LOGO_SRC:-$DEFAULT_SRC}"

fail() {
    echo "Error: $1" >&2
    exit 1
}

require_command() {
    command -v "$1" >/dev/null 2>&1 || fail "Missing command: $1"
}

[ -f "$LOGO_SRC" ] || fail "Logo source not found: $LOGO_SRC"
require_command magick
require_command python3

cd "$PROJECT_ROOT"

echo "== Logo asset generation =="
echo "Source: $LOGO_SRC"
echo

# Temp files for derived variants (favicon mark, solid-color logo)
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

# Favicon mark: logo without text, viewBox exactly matching the mark's
# bounding box (417x325) so the aspect ratio is preserved with no padding.
sed -e 's/viewBox="[^"]*"/viewBox="-0.25 89.85 417 325"/' -e '/<text /,/<\/text>/d' "$LOGO_SRC" > "$TMP_DIR/favicon-mark.svg"

# Solid variant: replace the gradient with the solid brand color and drop the <defs>
sed -e 's/url(#logoGrad)/#0083D7/g' -e '/<defs>/,/<\/defs>/d' "$LOGO_SRC" > "$TMP_DIR/logo-solid.svg"

# favicon.ico: multi-size ICO covering common resolutions (16/32/48/64/128/256).
# ImageMagick writes uncompressed BMP entries, so build the ICO from PNGs instead.
for size in 16 32 48 64 128 256; do
    magick -background none "$TMP_DIR/favicon-mark.svg" \
        -resize "${size}x${size}" -gravity center -background none -extent "${size}x${size}" \
        PNG32:"$TMP_DIR/favicon-${size}.png"
done
python3 "$SCRIPT_DIR/build-ico.py" static/favicon.ico \
    "$TMP_DIR/favicon-16.png" "$TMP_DIR/favicon-32.png" "$TMP_DIR/favicon-48.png" \
    "$TMP_DIR/favicon-64.png" "$TMP_DIR/favicon-128.png" "$TMP_DIR/favicon-256.png"
echo "Generated static/favicon.ico"

# favicon.svg: vector favicon for modern browsers
cp "$TMP_DIR/favicon-mark.svg" static/favicon.svg
echo "Generated static/favicon.svg"

# Master SVG synced into static/images (used by header and hero)
cp "$LOGO_SRC" static/images/BioinfoBoost-logo.svg
echo "Generated static/images/BioinfoBoost-logo.svg"

# PNG variants: 600 px wide, 8-bit depth, metadata stripped
magick -background none "$LOGO_SRC" -resize 600x -depth 8 -strip static/images/BioinfoBoost-logo.png
echo "Generated static/images/BioinfoBoost-logo.png"

magick -background none "$TMP_DIR/logo-solid.svg" -resize 600x -depth 8 -strip static/images/BioinfoBoost-logo-solid.png
echo "Generated static/images/BioinfoBoost-logo-solid.png"

magick -background white "$LOGO_SRC" -alpha remove -alpha off -resize 600x -depth 8 -strip static/images/BioinfoBoost-logo.white.png
echo "Generated static/images/BioinfoBoost-logo.white.png"

magick -background white "$TMP_DIR/logo-solid.svg" -alpha remove -alpha off -resize 600x -depth 8 -strip static/images/BioinfoBoost-logo-solid.white.png
echo "Generated static/images/BioinfoBoost-logo-solid.white.png"

echo
echo "== Generated assets =="
for f in static/favicon.ico static/favicon.svg static/images/BioinfoBoost-logo.svg static/images/BioinfoBoost-logo.png static/images/BioinfoBoost-logo-solid.png static/images/BioinfoBoost-logo.white.png static/images/BioinfoBoost-logo-solid.white.png; do
    printf "%-48s %10d bytes\n" "$f" "$(wc -c < "$f")"
done
