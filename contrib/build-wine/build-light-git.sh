#!/bin/bash

# You probably need to update only this link
ELECTRUM_GIT_URL=git://github.com/capricoin/light-capricoin.git
BRANCH=master
NAME_ROOT=light-capricoin


# These settings probably don't need any change
export WINEPREFIX=/opt/light

PYHOME=c:/python27
PYTHON="wine $PYHOME/python.exe -OO -B"


# Let's begin!
cd `dirname $0`
set -e

cd tmp

if [ -d "light-capricoin-git" ]; then
    # GIT repository found, update it
    echo "Pull"
    cd light-capricoin-git
    git checkout master
    git pull
    cd ..
else
    # GIT repository not found, clone it
    echo "Clone"
    git clone -b $BRANCH $ELECTRUM_GIT_URL light-capricoin-git
fi

cd light-capricoin-git
VERSION=2.3.0
echo "Last commit: $VERSION"

cd ..

rm -rf $WINEPREFIX/drive_c/light-capricoin
cp -r light-capricoin-git $WINEPREFIX/drive_c/light-capricoin
cp light-capricoin-git/LICENCE .

# add python packages (built with make_packages)
cp -r ../../../packages $WINEPREFIX/drive_c/light-capricoin/

# Build Qt resources
wine $WINEPREFIX/drive_c/Python27/Lib/site-packages/PyQt4/pyrcc4.exe C:/light-capricoin/icons.qrc -o C:/light-capricoin/lib/icons_rc.py
wine $WINEPREFIX/drive_c/Python27/Lib/site-packages/PyQt4/pyrcc4.exe C:/light-capricoin/icons.qrc -o C:/light-capricoin/gui/qt/icons_rc.py

cd ..

rm -rf dist/

# build standalone version
$PYTHON "C:/pyinstaller/pyinstaller.py" --noconfirm --ascii -w deterministic.spec

# build NSIS installer
wine "$WINEPREFIX/drive_c/Program Files/NSIS/makensis.exe" light.nsi

cd dist
mv light-capricoin.exe $NAME_ROOT-$VERSION.exe
mv light-capricoin-setup.exe $NAME_ROOT-$VERSION-setup.exe
mv light-capricoin $NAME_ROOT-$VERSION
zip -r $NAME_ROOT-$VERSION.zip $NAME_ROOT-$VERSION
cd ..

# build portable version
#cp portable.patch $WINEPREFIX/drive_c/light-capricoin
#pushd $WINEPREFIX/drive_c/light-capricoin
#patch < portable.patch 
#popd
#$PYTHON "C:/pyinstaller/pyinstaller.py" --noconfirm --ascii -w deterministic.spec
#cd dist
#mv light-capricoin.exe $NAME_ROOT-$VERSION-portable.exe
cd ..

echo "Done."
