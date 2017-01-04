import os

from setuptools import setup
from setuptools import find_packages


here = os.path.abspath(os.path.dirname(__file__))
with open(os.path.join(here, 'README.md')) as f:
    README = f.read()


requires = [
    'flake8',
    'flake8-print',
    'opbeat',
    'opbeat_pyramid',
    'pyramid',
    'pyramid_chameleon',
    'pyramid_debugtoolbar',
    'pytest',
    'pytest-cov',
    'pytest-watch',
    'waitress',
    'zope.interface',
]


setup(
    name='mk',
    version='0.0',
    description='Exposing my website, one hacker at a time.',
    long_description=README,
    classifiers=[
        "Programming Language :: Python",
        "Framework :: Pyramid",
        "Topic :: Internet :: WWW/HTTP",
        "Topic :: Internet :: WWW/HTTP :: WSGI :: Application",
    ],
    author='Bailey Stoner',
    author_email='monokrome@limpidtech.com',
    url='https://monokro.me/',
    keywords='web pyramid pylons',
    packages=find_packages(),
    include_package_data=True,
    zip_safe=False,
    install_requires=requires,
    tests_require=requires,
    test_suite="mk",
    entry_points="""\
    [paste.app_factory]
    main = mk:main
    """,
)

