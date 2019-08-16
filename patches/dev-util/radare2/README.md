the build system is not transferring CFLAGS from Portage
to their plugins, hence compilation fails due to missing
extensions; declare them explicitly using this hacky patch
