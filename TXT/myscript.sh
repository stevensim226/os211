#!/bin/bash
# Steven - 1906293322 - OS211
# Written by Cicak bin Kadal
# documented by Steven
# Tue 07 Mar 2021 08:46:00 AM WIB
# Docs: 10 Mar 2021 Mar 2021 18:45:00 AM WIB

FILES="my*.txt my*.sh"
SHA="SHA256SUM"

# Remove old SHA256 files
echo "rm -f $SHA $SHA.asc"
rm -f $SHA $SHA.asc

# Create a new SHA256SUM file from output
echo "sha256sum $FILES > $SHA"
sha256sum $FILES > $SHA

# Checksum using the SHA256SUM file before
echo "sha256sum -c $SHA"
sha256sum -c $SHA

# Make a signature w/ gpg to SHA256SUM.asc file
echo "gpg -o $SHA.asc -a -sb $SHA"
gpg -o $SHA.asc -a -sb $SHA

# Verify the file w/ existing key
echo "gpg --verify $SHA.asc $SHA"
gpg --verify $SHA.asc $SHA

exit 0

# Tue Mar 09 08:46:00 WIB 2021
