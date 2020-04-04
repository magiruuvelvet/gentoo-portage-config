# delete version control system directories
remove_vcs() {
    if [ ! -z "$S" ]; then
        rm -rf "${S}/.$1"
        rm -rf "${S}/../.$1"
    fi
}
