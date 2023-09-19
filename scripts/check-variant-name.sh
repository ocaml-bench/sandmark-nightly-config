#!/bin/bash

set -euo pipefail

SANDMARK_DIR="${SANDMARK_DIR:-/tmp/sandmark}"

if [[ ! -d  "${SANDMARK_DIR}" ]];
then
    git clone https://github.com/ocaml-bench/sandmark.git "${SANDMARK_DIR}"
fi

num_err=0

for f in `find config/*.json`; do
    NAMES=$(jq -r 'if type=="array" then .[].name else .name end' "${f}");
    for name in ${NAMES}; do
        variant=$(grep -oP "^(\\d|\.)+(\\+(trunk|stable))*" <<< "${name}")
        variant_json="${SANDMARK_DIR}/ocaml-versions/${variant}.json"
        if [[ ! -f "${variant_json}" ]]; then
            echo "${variant} is not a valid variant. See https://github.com/ocaml-bench/sandmark/tree/main/ocaml-versions for supported versions!"
            num_err=$((num_err+1))
        fi
    done
done

if [[ $num_err -ne 0 ]]; then
    exit 1
fi
