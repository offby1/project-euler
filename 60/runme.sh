#!/bin/sh

here="$(cd "$(dirname "$0")" && pwd)"
set -x

cd "${here}"

if ! [ -x $here/.venv/bin/python3 ]
then
   poetry install
fi

set -e

./.venv/bin/python3 -m pytest .
./.venv/bin/python3 60.py
