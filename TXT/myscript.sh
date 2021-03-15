#!/bin/bash
# Copyright (C) 2020-2021 Cicak Bin Kadal
# https://www.youtube.com/watch?v=KAXK07ni9gU

# This free document is distributed in the hope that it will be 
# useful, but WITHOUT ANY WARRANTY; without even the implied 
# warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

# REV03 Sun 14 Mar 18:21:27 WIB 2021
# REV02 Fri 12 Mar 13:40:58 WIB 2021
# REV01 Tue 13 Oct 10:37:14 WIB 2020
# START Mon 28 Sep 21:05:04 WIB 2020

REC1="operatingsystems@vlsm.org"
REC2="stevensim226@gmail.com"
FILES="my*.asc my*.txt my*.sh"
SHA="SHA256SUM"

[ -d $HOME/RESULT ] || mkdir -p $HOME/RESULT
pushd $HOME/RESULT
for II in W?? ; do
    [ -d $II ] || continue
    TARFILE=my$II.tar.bz2
    TARFASC=$TARFILE.asc
    rm -f $TARFILE $TARFASC
    echo "tar cfj $TARFILE $II/"
    tar cfj $TARFILE $II/
    echo "gpg --armor --output $TARFASC --encrypt --recipient $REC1 --recipient $REC2 $TARFILE"
    gpg --armor --output $TARFASC --encrypt --recipient $REC1 --recipient $REC2 $TARFILE
done
popd

rm -f $HOME/RESULT/fakeDODOL
for II in $HOME/RESULT/myW*.tar.bz2.asc $HOME/RESULT/fakeDODOL ; do
   echo "Check and move $II..."
   [ -f $II ] && mv -f $II .
done

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


