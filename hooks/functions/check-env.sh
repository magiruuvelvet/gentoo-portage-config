# avoid catastrophic failures due to environment variables
# not being set correctly
# source this in every hook

function die() {
    echo "$1" >&2
    exit 254
}

if [[ -z "$ED" || "$ED" != "/"* ]]; then
    die "ED is not set or a relative path"
fi

if [[ -z "$D" || "$D" != "/"* ]]; then
    die "D is not set or a relative path"
fi

if [[ -z "$S" || "$S" != "/"* ]]; then
    die "S is not set or a relative path"
fi

if [[ -z "$PN" ]]; then
    die "PN is not set"
fi
