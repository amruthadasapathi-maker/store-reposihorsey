#!/bin/sh

# Fail if any command fails
set -e

TMPDIR="/mnt/us/KFPM-Temporary"
DESTDIR="/mnt/us/documents/kanki"

# 1. Clean start: Remove old temp data if it exists
rm -rf "$TMPDIR"
mkdir -p "$TMPDIR"

# 2. Download
# Added -k for SSL flexibility and -L to follow redirects
curl -fSLk --progress-bar -o "$TMPDIR/kanki.zip" "https://github.com/crizmo/kanki/releases/latest/download/kanki.zip"

# 3. Extract
unzip -o -q "$TMPDIR/kanki.zip" -d "$TMPDIR"

# 4. Prepare Destination
# If the user deleted it, we recreate it. 
# If it exists, we ensure we can write to it.
mkdir -p "$DESTDIR"

# 5. Copy and Sync
# Using 'cp -Rf' to force overwrite any existing files
cp -Rf "$TMPDIR/kanki"/* "$DESTDIR/"
cp -f "$TMPDIR/kanki.sh" "/mnt/us/documents/"
chmod +x "/mnt/us/documents/kanki.sh"

# 6. Cleanup
rm -rf "$TMPDIR"

# Ensure changes are written to the disk (Kindles use heavy caching)
sync

exit 0
