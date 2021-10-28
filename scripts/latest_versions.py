#!/usr/bin/python3
import os
import sys
import re
import urllib.request

PACKAGE = sys.argv[1]
MAX_VERSIONS = sys.argv[2] if len(sys.argv) > 2 else 10

# Load PyPI website for the package
fp = urllib.request.urlopen(f"https://pypi.org/simple/{PACKAGE}/")
html_string = fp.read().decode("utf8")
fp.close()

# Pick a regex- either include prerelease versions or not
if os.environ.get("INCLUDE_PRERELEASE", False) == 'true':
  version_regex = re.compile(r'-(\d+\.\d+\.\d+(a|b|rc)?\d?).+[\.whl|\.tar\.gz]')
  versions = [x[0] for x in version_regex.findall(html_string)]
else:
  version_regex = re.compile(r'-(\d+\.\d+\.\d+).+[\.whl|\.tar\.gz]')
  versions = version_regex.findall(html_string)

unique_versions = list(dict.fromkeys(versions))

for version in unique_versions[-(int(MAX_VERSIONS)):]:
  print(version)