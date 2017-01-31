#!/usr/bin/python

# python setup.py sdist --format=zip,gztar

from setuptools import setup
import os
import sys
import platform
import imp


version = imp.load_source('version', 'lib/version.py')

if sys.version_info[:3] < (2, 7, 0):
    sys.exit("Error: Light requires Python version >= 2.7.0...")



data_files = []
if platform.system() in [ 'Linux', 'FreeBSD', 'DragonFly']:
    usr_share = os.path.join(sys.prefix, "share")
    data_files += [
        (os.path.join(usr_share, 'applications/'), ['light-capricoin.desktop']),
        (os.path.join(usr_share, 'pixmaps/'), ['icons/light-capricoin.png'])
    ]


setup(
    name="Light-Capricoin",
    version=version.ELECTRUM_VERSION,
    install_requires=[
        'slowaes>=0.1a1',
        'ecdsa>=0.9',
        'pbkdf2',
        'requests',
        'qrcode',
        'protobuf',
        'tlslite',
        'dnspython',
		'x11_hash',
    ],
    package_dir={
        'light_capricoin': 'lib',
        'light_capricoin_gui': 'gui',
        'light_capricoin_plugins': 'plugins',
    },
    packages=['light_capricoin','light_capricoin_gui','light_capricoin_gui.qt','light_capricoin_plugins'],
    package_data={
        'light_capricoin': [
            'wordlist/*.txt',
            'locale/*/LC_MESSAGES/light.mo',
        ],
        'light_capricoin_gui': [
            "qt/themes/cleanlook/name.cfg",
            "qt/themes/cleanlook/style.css",
            "qt/themes/sahara/name.cfg",
            "qt/themes/sahara/style.css",
            "qt/themes/dark/name.cfg",
            "qt/themes/dark/style.css",
        ]
    },
    scripts=['light-capricoin'],
    data_files=data_files,
    description="Lightweight Capricoin Wallet",
    author="capricoinDEV",
    author_email="capricoincoin@twitter",
    license="GNU GPLv3",
    url="http://www.capricoin.org",
    long_description="""Lightweight Capricoin Wallet"""
)
