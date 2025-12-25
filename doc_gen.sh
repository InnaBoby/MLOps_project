#!/bin/bash

poetry add Sphinx --group dev

PROJECT_NAME= pwd | awk -F "/" '{ print $NF }'

# VERSION=cat "$(pwd)/pyproject.toml" | grep "version" | head -1 | awk -F "=" '{ print $NF }'
# echo $VERSION

mkdir -p docs

poetry run sphinx-apidoc -F -o docs/ "$(pwd)/src"
sed -i '1i import os\nimport sys\nsys.path.insert(0, os.path.abspath("../../"))\n' docs/source/conf.py

#import sys\nfrom pathlib import Path\nsys.path.insert(0, str(Path(__file__).resolve().parents[2]))    <- https://www.sphinx-doc.org/en/master/tutorial/describing-code.html#documenting-python-objects


cd docs

#poetry run sphinx-quickstart --quiet -p "$PROJECT_NAME" -a "Author"

#poetry run make html
poetry run sphinx-build -b html . ./_build/html
