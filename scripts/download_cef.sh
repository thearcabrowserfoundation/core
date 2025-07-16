#!/bin/bash

set -e

DEST_DIR="CEF"
ARCHIVE_NAME="cef_binary.tar.bz2"
DOWNLOAD_URL="https://cef-builds.spotifycdn.com/cef_binary_138.0.23%2Bg26cc530%2Bchromium-138.0.7204.101_macosarm64.tar.bz2"

# Create the destination directory if it doesn't exist
mkdir -p "$DEST_DIR"

# Check if CEF is already downloaded (directory not empty)
if [ -d "$DEST_DIR" ] && [ "$(ls -A $DEST_DIR)" ]; then
  echo "CEF binaries already exist in $DEST_DIR, skipping download."
  exit 0
fi

echo "Downloading CEF binaries from $DOWNLOAD_URL to $DEST_DIR/$ARCHIVE_NAME..."
curl -L -o "${DEST_DIR}/${ARCHIVE_NAME}" "$DOWNLOAD_URL"

echo "Extracting CEF binaries to $DEST_DIR..."
tar -xjf "${DEST_DIR}/${ARCHIVE_NAME}" -C "$DEST_DIR" --strip-components=1

echo "Cleaning up..."
rm "${DEST_DIR}/${ARCHIVE_NAME}"

echo "CEF binaries downloaded and extracted successfully."
