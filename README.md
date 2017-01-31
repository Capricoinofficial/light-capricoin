Light-Capricoin - lightweight capricoin client
=====================================

  Licence: GNU GPL v3
  Author: Thomas Voegtlin
  maintainer: capricoin
  Language: Python
  Homepage: https://www.capricoin.org/

  
1. GETTING STARTED
------------------

To run Light-Capricoin from this directory, just do::

    ./light-capricoin

If you install Light-Capricoin on your system, you can run it from any
directory.

If you have pip, you can do::

    python setup.py sdist
    sudo pip install --pre dist/Light-Capricoin-2.3.0.tar.gz


If you don't have pip, install with::

    python setup.py sdist
    sudo python setup.py install




2. HOW OFFICIAL PACKAGES ARE CREATED
------------------------------------

On Linux/Windows::

    pyrcc4 icons.qrc -o gui/qt/icons_rc.py
    python setup.py sdist --format=zip,gztar

On Mac OS X::

    # On port based installs
    sudo python setup-release.py py2app

    # On brew installs
    ARCHFLAGS="-arch i386 -arch x86_64" sudo python setup-release.py py2app --includes sip

    sudo hdiutil create -fs HFS+ -volname "Light-Capricoin" -srcfolder dist/Light-Capricoin.app dist/light-capricoin-VERSION-macosx.dmg
