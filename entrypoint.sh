# #!/bin/sh
 
CONFIG_DIR="/tmp/config.yml"

printf "%s\n" "${@}"
	# BASE64
printf "Running embulk with base64 config, decoding string to %s\n" "${CONFIG_DIR}"
echo "${BASE64_CONFIG}" | base64 -d > "${CONFIG_DIR}"

/opt/embulk/embulk run "${CONFIG_DIR}"
