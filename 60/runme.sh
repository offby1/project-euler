#!/bin/sh

here="$(cd "$(dirname "$0")" && pwd)"
set -x

cd "${here}"

if ! python3 -c 'import poetry'
then
    echo "You don't have \`poetry\`, so I'll install it for you"
    python3 -m pip install --user --no-input poetry
fi

if ! [ -x $here/.venv/bin/python3 ]
then
   python3 -m poetry install
fi

set -e

./.venv/bin/python3 60.py
