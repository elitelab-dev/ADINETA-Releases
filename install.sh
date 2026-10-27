#!/bin/sh
set -eu

VERSION='1.0.0'
ASSET='ADINETA-Standard-v1.0.0-Linux-x86_64-glibc235.tar.gz'
EXPECTED_SHA='dda58c1f915e91e89687b1881557a60b507875c9b42577e7cb2c2644e1245a1d'
BASE_URL='https://github.com/elitelab-dev/ADINETA-Releases/releases/download/v1.0.0'
URL="${ADINETA_RELEASE_BASE_URL:-$BASE_URL}/$ASSET"
ROOT="$HOME/.local/share/adineta"
TARGET="$ROOT/$VERSION"
BIN_DIR="$HOME/.local/bin"
TMP_ROOT="${TMPDIR:-/tmp}/adineta-install.$$.${RANDOM:-0}"

cleanup() { rm -rf "$TMP_ROOT"; }
trap cleanup EXIT HUP INT TERM

fail() { echo "ADINETA installer error: $*" >&2; exit 1; }

[ "$(uname -s)" = Linux ] || fail "Linux is required."
[ "$(uname -m)" = x86_64 ] || fail "Linux x86_64 is required."

glibc="$(getconf GNU_LIBC_VERSION 2>/dev/null || true)"
[ -n "$glibc" ] || fail "Could not determine glibc version."
glibc_version=${glibc#* }
if [ "$(printf '%s\n' '2.34' "$glibc_version" | sort -V | head -n 1)" != '2.34' ]; then
  fail "glibc 2.34 or newer is required; found $glibc_version."
fi

mkdir -p "$TMP_ROOT" "$BIN_DIR" "$ROOT"
archive="$TMP_ROOT/$ASSET"
if command -v curl >/dev/null 2>&1; then
  curl --fail --location --proto '=https' --tlsv1.2 --output "$archive" "$URL" || fail "Download failed."
elif command -v wget >/dev/null 2>&1; then
  wget --https-only -O "$archive" "$URL" || fail "Download failed."
else
  fail "curl or wget is required."
fi

actual_sha="$(sha256sum "$archive" | awk '{print $1}')"
[ "$actual_sha" = "$EXPECTED_SHA" ] || fail "SHA-256 mismatch."

stage="$TMP_ROOT/stage"
mkdir "$stage"
tar -xzf "$archive" -C "$stage"
payload="$stage/ADINETA-Standard-v1.0.0-Public-Distribution"
[ -x "$payload/standard_entry.dist/adineta" ] || fail "Verified executable is missing."
[ -f "$payload/standard_entry.dist/libpython3.12.so.1.0" ] || fail "Bundled runtime is missing."

rm -rf "$TARGET.new"
mkdir "$TARGET.new"
cp -a "$payload/." "$TARGET.new/"
chmod 755 "$TARGET.new/standard_entry.dist/adineta"
env -u PYTHONPATH "$TARGET.new/standard_entry.dist/adineta" --help >/dev/null || fail "Installed executable validation failed."

if [ -e "$TARGET" ]; then
  previous="$ROOT/.previous-$VERSION-$(date +%Y%m%d%H%M%S)"
  mv "$TARGET" "$previous"
fi
mv "$TARGET.new" "$TARGET"
ln -sfn "$TARGET/standard_entry.dist/adineta" "$BIN_DIR/adineta"

echo "ADINETA $VERSION installed at $TARGET"
echo "Run: $BIN_DIR/adineta --help"
echo "If needed, add $BIN_DIR to PATH."
