#!/bin/sh
set -eu

VERSION='1.0.1'
ASSET='ADINETA-Standard-v1.0.1-Linux-x86_64-glibc235-public.tar.gz'
EXPECTED_SHA='a7d57d1ad51ffebbf2dcd3be790ee0fdf639841b976ed14171af0fe082d8968b'
BASE_URL='https://github.com/elitelab-dev/ADINETA-Releases/releases/download/v1.0.1'
URL="${ADINETA_RELEASE_BASE_URL:-$BASE_URL}/$ASSET"
ROOT="$HOME/.local/share/adineta"
TARGET="$ROOT/$VERSION"
BIN_DIR="$HOME/.local/bin"
TMP_ROOT="$(mktemp -d "${TMPDIR:-/tmp}/adineta-install.XXXXXX")"

cleanup() { rm -rf "$TMP_ROOT"; }
trap cleanup EXIT HUP INT TERM

fail() { echo "ADINETA installer error: $*" >&2; exit 1; }

[ "$(uname -s)" = Linux ] || fail "Linux is required."
[ "$(uname -m)" = x86_64 ] || fail "Linux x86_64 is required."

glibc="$(getconf GNU_LIBC_VERSION 2>/dev/null || true)"
[ -n "$glibc" ] || fail "Could not determine glibc version."
glibc_version=${glibc#* }
[ "$(printf '%s\n' '2.34' "$glibc_version" | sort -V | head -n 1)" = '2.34' ] || \
  fail "glibc 2.34 or newer is required; found $glibc_version."

mkdir -p "$TMP_ROOT" "$BIN_DIR" "$ROOT"
archive="$TMP_ROOT/$ASSET"
case "$URL" in
  https://*) ;;
  *) fail "The release URL must use HTTPS." ;;
esac
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
payload="$stage/ADINETA-Standard-v1.0.1-Linux-x86_64-glibc235-public"
[ -x "$payload/standard_entry.dist/adineta" ] || fail "Verified executable is missing."
[ -f "$payload/standard_entry.dist/libpython3.12.so.1.0" ] || fail "Bundled runtime is missing."

new_target="$ROOT/.staging-$VERSION-$$"
[ ! -e "$new_target" ] && [ ! -L "$new_target" ] || fail "Temporary installation path already exists."
mkdir "$new_target"
cp -a "$payload/." "$new_target/"
chmod 755 "$new_target/standard_entry.dist/adineta"
env -u PYTHONPATH "$new_target/standard_entry.dist/adineta" --help >/dev/null || fail "Installed executable validation failed."

if [ -e "$TARGET" ] || [ -L "$TARGET" ]; then
  previous="$ROOT/.previous-$VERSION-$(date +%Y%m%d%H%M%S)"
  mv "$TARGET" "$previous"
fi
mv "$new_target" "$TARGET"
ln -sfn "$TARGET/standard_entry.dist/adineta" "$BIN_DIR/adineta"

echo "ADINETA $VERSION installed at $TARGET"
echo "Run: $BIN_DIR/adineta --help"
echo "If needed, add $BIN_DIR to PATH."
