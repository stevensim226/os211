#!/bin/bash
# Steven - 1906293322 - OS211
# Written by Cicak bin Kadal
# Tue 09 Mar 2021 08:46:00 AM WIB

FILES="my*.txt my*.sh"
SHA="SHA256SUM"

echo "rm -f $SHA $SHA.asc"
rm -f $SHA $SHA.asc

echo "sha256sum $FILES > $SHA"
sha256sum $FILES > $SHA

echo "sha256sum -c $SHA"
sha256sum -c $SHA

echo "gpg -o $SHA.asc -a -sb $SHA"
gpg -o $SHA.asc -a -sb $SHA

echo "gpg --verify $SHA.asc $SHA"
gpg --verify $SHA.asc $SHA

exit 0

# Tue Mar 09 08:46:00 WIB 2021
