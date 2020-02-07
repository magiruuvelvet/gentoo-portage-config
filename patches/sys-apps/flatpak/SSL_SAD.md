I broke something after updating something, which made `p11-kit` sad :(

The client module can't receive any certificates, and with an empty list
of certificates SSL doesn't work inside flatpak which makes applications
depending on secure connections sad :(

This patch is a workaround which uses the bundled runtime certificates
instead of the ones from the host. It's not like I have custom certificates
which are needed inside flatpak containers.
