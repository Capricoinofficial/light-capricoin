#!/bin/bash

# You probably need to update only this link
ELECTRUM_URL=http://light-capricoin.space/download/light-capricoin.tar.gz
NAME_ROOT=light-1.6.1

# These settings probably don't need any change
export WINEPREFIX=/opt/wine-light
PYHOME=c:/python26
PYTHON="wine $PYHOME/python.exe -OO -B"

# Let's begin!
cd `dirname $0`
set -e

cd tmp

# Download and unpack Light
wget -O light.tgz "$ELECTRUM_URL"
tar xf light.tgz
mv Light-* light
rm -rf $WINEPREFIX/drive_c/light
cp light/LICENCE .
mv light $WINEPREFIX/drive_c

# Copy ZBar libraries to light
#cp "$WINEPREFIX/drive_c/Program Files (x86)/ZBar/bin/"*.dll "$WINEPREFIX/drive_c/light/"

cd ..

rm -rf dist/$NAME_ROOT
rm -f dist/$NAME_ROOT.zip
rm -f dist/$NAME_ROOT.exe
rm -f dist/$NAME_ROOT-setup.exe

# For building standalone compressed EXE, run:
$PYTHON "C:/pyinstaller/pyinstaller.py" --noconfirm --ascii -w --onefile "C:/light/light"

# For building uncompressed directory of dependencies, run:
$PYTHON "C:/pyinstaller/pyinstaller.py" --noconfirm --ascii -w deterministic.spec

# For building NSIS installer, run:
wine "$WINEPREFIX/drive_c/Program Files (x86)/NSIS/makensis.exe" light.nsi
#wine $WINEPREFIX/drive_c/Program\ Files\ \(x86\)/NSIS/makensis.exe light.nsis

cd dist
mv light.exe $NAME_ROOT.exe
mv light $NAME_ROOT
mv light-setup.exe $NAME_ROOT-setup.exe
zip -r $NAME_ROOT.zip $NAME_ROOT
