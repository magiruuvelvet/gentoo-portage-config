EBUILD_PRESERVATION_ARCHIVE_ROOT="/var/db/pkg-preserved"

ebuild_preservation_archive_main() {
    local pretty_name="\e[38;2;120;120;39m[${CATEGORY}/${PN}-${PVR}]\e[0m"
    echo -e "${pretty_name} preserving into ebuild preservation archive..."

    ensure_var() {
        if [[ -z "$1" ]]; then
            echo "unexpected environment" >&2
            return 1
        else
            return 0
        fi
    }

    ensure_dir_and_empty() {
        if [ -d "$1" ]; then
            rm -r "$1"
        fi

        mkdir -p "$1"
    }

    delete_dir_if_empty() {
        if [ -d "$1" ] && [ -z "$(ls -A "$1")" ]; then
            rmdir "$1"
        fi
    }

    copy_patch_dir_if_exists() {
        if [ -d "$1" ]; then
            echo -e "${pretty_name} copying user patches '$1'..."
            cp -r "$1" "$2"
        fi
    }

    get_first_line() {
        echo "${1%%$'\n'*}"
    }

    # ensure mandatory environment variables are present
    ensure_var "$PORTAGE_REPO_NAME" || exit 1
    ensure_var "$CATEGORY"          || exit 1
    ensure_var "$P"                 || exit 1
    ensure_var "$PN"                || exit 1
    ensure_var "$PV"                || exit 1
    ensure_var "$PR"                || exit 1
    ensure_var "$PVR"               || exit 1
    ensure_var "$SLOT"              || exit 1

    # setup variables
    local current_unix_time="$(date '+%s')"
    local pkg_timestamp="$(date -d "@${current_unix_time}" '+%Y%m%d_%H%M%S')"
    local pkg_slot="${SLOT%%/*}" # remove everything after first slash
    local pkg_name="${PN}-${PVR}"
    local pkg_dir="${EBUILD_PRESERVATION_ARCHIVE_ROOT}/${CATEGORY}/${pkg_name}_${pkg_timestamp}"
    # FIXME: can be empty when merging dev-lang/python due to portageq not being executable
    local repo_root="$(/usr/bin/portageq get_repo_path / "${PORTAGE_REPO_NAME}")"
    local source_dir="${repo_root}/${CATEGORY}/${PN}"
    local user_patch_dir="/etc/portage/patches/${CATEGORY}"

    echo -e "${pretty_name} package preservation directory: ${pkg_dir}"

    # ensure the directory exists and is empty
    ensure_dir_and_empty "${pkg_dir}"
    mkdir -p "${pkg_dir}"/patches

    # copy ebuild and manifest
    echo -e "${pretty_name} copying ebuild and manifest..."
    cp "${source_dir}/${pkg_name}.ebuild" "${pkg_dir}/"
    cp "${source_dir}/Manifest" "${pkg_dir}/"

    # copy ebuild metadata
    if [ -f "${source_dir}/metadata.xml" ]; then
        echo -e "${pretty_name} copying ebuild metadata..."
        cp "${source_dir}/metadata.xml" "${pkg_dir}/"
    fi

    # copy ebuild files directory
    if [ -d "${source_dir}/files" ]; then
        echo -e "${pretty_name} copying ebuild files directory..."
        cp -r "${source_dir}/files" "${pkg_dir}/"
    fi

    # copy user patches
    # https://wiki.gentoo.org/wiki//etc/portage/patches
    copy_patch_dir_if_exists "${user_patch_dir}/${P}" "${pkg_dir}/patches/"
    copy_patch_dir_if_exists "${user_patch_dir}/${P}:${pkg_slot}" "${pkg_dir}/patches/"
    copy_patch_dir_if_exists "${user_patch_dir}/${PN}" "${pkg_dir}/patches/"
    copy_patch_dir_if_exists "${user_patch_dir}/${PN}:${pkg_slot}" "${pkg_dir}/patches/"
    copy_patch_dir_if_exists "${user_patch_dir}/${P}-${PR}" "${pkg_dir}/patches/"
    copy_patch_dir_if_exists "${user_patch_dir}/${P}-${PR}:${pkg_slot}" "${pkg_dir}/patches/"
    delete_dir_if_empty "${pkg_dir}/patches"

    # copy eclass directory
    # TODO: only copy active eclasses (possible?)
    #if [ -d "${repo_root}/eclass" ]; then
    #    echo -e "${pretty_name} copying eclass directory..."
    #    cp -r "${repo_root}/eclass" "${pkg_dir}/"
    #fi

    # create build info manifest
    echo -e "${pretty_name} creating build info manifest..."
    cat > "${pkg_dir}/build_info.manifest" << EOF
EBUILD PRESERVATION MANIFEST 1.0

[Package]
Package: =${CATEGORY}/${pkg_name}
Slot: ${pkg_slot}
Build Date: $(date -d "@${current_unix_time}" '+%Y-%m-%dT%H:%M:%S%:z')
Repository: ${PORTAGE_REPO_NAME} (${repo_root})
Build Host: $(hostname)
Portage Version: $(/usr/bin/portageq --version)
Profile: $(cat /etc/portage/profile/parent)

[Environment]
CC: ${CC}
CXX: ${CXX}
USE: ${USE}
FEATURES: ${FEATURES}
CFLAGS: ${CFLAGS}
CXXFLAGS: ${CXXFLAGS}
LDFLAGS: ${LDFLAGS}
EOF

    echo -e "${pretty_name} successfully preserved ebuild."
}
