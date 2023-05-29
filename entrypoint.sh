#!/usr/bin/env bash

CONFIG_DIR="/tmp/config.yml"

printf "%s\n" "${@}"

if [[ -z "${BASE64_CONFIG}" ]]; then
	# NOT BASE64
	printf "Running embulk without base64 config, a volume should be mapped\n"
	/opt/embulk/embulk "${@}"
else
	# BASE64
	printf "Running embulk with base64 config, decoding string to %s\n" "${CONFIG_DIR}"
	echo "${BASE64_CONFIG}" | base64 -d > "${CONFIG_DIR}"

	# NOT INCREMENTAL
	/opt/embulk/embulk run "${CONFIG_DIR}"
fi
