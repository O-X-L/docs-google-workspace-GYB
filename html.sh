#!/bin/bash

if [ -z "$1" ]
then
  DEST_DIR='build'
else
  DEST_DIR="$1"
fi

if [ -z "$2" ]
then
  DOMAIN='gyb.docs.oxl.app'
else
  DOMAIN="$2"
fi

set -euo pipefail

function log() {
  msg="$1"
  echo ''
  echo "### ${msg} ###"
  echo ''
}

cd "$(dirname "$0")"

SRC_DIR="$(pwd)"

TS="$(date +%s)"
TMP_DIR="/tmp/${TS}"
TMP_DIR2="${TMP_DIR}/build"
mkdir -p "${TMP_DIR2}"

VENV_BIN='/tmp/.oxl-sphinx-venv/bin/activate'
if [ -f "$VENV_BIN" ]
then
  source "$VENV_BIN"
fi

log 'DOWNLOADING UPSTREAM DOCS'
cd "$TMP_DIR"
rm -f "${SRC_DIR}/source/usage/"*.md "${SRC_DIR}/source/intro/"*.md
git clone --depth 1 'https://github.com/GAM-team/got-your-back.wiki.git' >/dev/null
cp got-your-back.wiki/*.md "${SRC_DIR}/source/usage/"

mv "${SRC_DIR}/source/usage/Home.md" "${SRC_DIR}/source/intro/"
rm -f "${SRC_DIR}/source/usage/_Sidebar.asciidoc"

log 'PATCHING DOCS & UPDATING SITEMAP'
FILE_SM="${TMP_DIR}/sitemap.xml"
cp "${SRC_DIR}/source/_meta/sitemap.xml" "$FILE_SM"
for file in "${SRC_DIR}/source/"*/*.md
do
  # echo " > $file"

  # full links
  sed -i -r "s|https:\/\/github\.com\/GAM-team\/got-your-back\/wiki\/([a-zA-Z0-9_\-]*?)|https://${DOMAIN}/usage/\1.html|g" "$file"
  # relative links to other docs
  sed -i -r "s|\]\(([a-zA-Z0-9_\-]*?)\)|](https://${DOMAIN}/usage/\1.html)|g" "$file"
  # change all but the first H1 to a H2
  h1="$(grep '^#' < "$file" | head -n 1 || true)"
  sed -i "s|^#\s|## |g" "$file"
  sed -i "s|^#$h1|$h1|g" "$file"

  file_rel="$(echo "$file" | sed "s|${SRC_DIR}/source/||g" | sed 's|.md||g' | sed 's|/|\/|g')"
  echo "  <url><loc>https://${DOMAIN}/${file_rel}.html</loc></url>" >> "$FILE_SM"

  echo '' >> "$file"
  echo '----' >> "$file"
  echo '' >> "$file"
  echo "[Original Documentation on GitHub](https://github.com/GAM-team/got-your-back/wiki/${file_rel})" >> "$file"
done
echo '</urlset>' >> "$FILE_SM"

log 'BUILDING DOCS'
export PYTHONWARNINGS='ignore'
sphinx-build -b html "${SRC_DIR}/source/" "${TMP_DIR2}/" >/dev/null

log 'PATCHING METADATA'
cp "${SRC_DIR}/source/_meta/"* "${TMP_DIR2}/"
cp "$FILE_SM" "${TMP_DIR2}/"

HTML_META_SRC="<meta charset=\"utf-8\" />"
HTML_META="${HTML_META_SRC}<meta http-equiv=\"Content-Security-Policy\" content=\"default-src 'self'; img-src 'self' https://files.oxl.at https://github.com; style-src 'self' https://files.oxl.at 'unsafe-inline'; script-src 'self' https://files.oxl.at 'unsafe-inline' 'unsafe-eval'; connect-src 'self';\">"
HTML_META="${HTML_META}<link rel=\"icon\" type=\"image/webp\" href=\"https://files.oxl.at/img/oxl3_sm.webp\">"
HTML_META_EN="${HTML_META}<link rel=\"alternate\" href=\"https://${DOMAIN}\" hreflang=\"en\">"
HTML_LOGO_LINK_SRC='href=".*Go to homepage"'
HTML_LOGO_LINK_EN='href="https://github.com/GAM-team/got-your-back" class="oxl-nav-logo" title="Got-Your-Back Project"'
HTML_LANG_NONE='<html'
HTML_LANG_EN='html lang="en"'

cd "${TMP_DIR2}/"

sed -i "s|$HTML_META_SRC|$HTML_META_EN|g" *.html
sed -i "s|$HTML_META_SRC|$HTML_META_EN|g" */*.html
sed -i "s|$HTML_LOGO_LINK_SRC|$HTML_LOGO_LINK_EN|g" *.html
sed -i "s|$HTML_LOGO_LINK_SRC|$HTML_LOGO_LINK_EN|g" */*.html
sed -i "s|$HTML_LANG_NONE|<$HTML_LANG_EN|g" *.html
sed -i "s|$HTML_LANG_NONE|<$HTML_LANG_EN|g" */*.html

log 'ACTIVATING'
cd "$SRC_DIR"
if [ -d "$DEST_DIR" ]
then
  rm -r "$DEST_DIR"
fi
mkdir -p "${DEST_DIR}"

mv "${TMP_DIR2}/"* "${DEST_DIR}/"

touch "${DEST_DIR}/${TS}"

rm -rf "$TMP_DIR"

log 'FINISHED'
