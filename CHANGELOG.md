## v1.17

- Install `iproute2` package to make the `ip` command available in the container

## v1.16

- Set `publish-addresses=no` in `avahi-daemon.conf` to avoid reverse PTR record conflicts with the host's existing mDNS records for the shared IP address
- Install `avahi-utils` and use `avahi-publish` in the S6 run script to manually register the A-record for the container hostname without the conflicting reverse PTR record (`--no-reverse`)

## v1.15

- Add `--debug` flag to `avahi-daemon` startup to print verbose conflict logs for further analysis

## v1.14

- Launch `avahi-daemon` with the `--no-drop-root` option to retain root capabilities, allowing the daemon to correctly identify and ignore its own loopback multicast packets and resolve hostname conflicts in host network mode

## v1.13

- Switch network interface detection to a whitelist approach (`eth*`, `en*`, `wl*`, `wlan*`) to automatically exclude virtual interfaces (like `supervisor`)
- Disable the Avahi daemon reflector option to prevent loopbacks
- Explicitly disable cross-family IPv4/IPv6 advertisements (`publish-aaaa-on-ipv4=no`, `publish-a-on-ipv6=no`) to avoid race conditions and false conflicts

## v1.12

- Replace obsolete `cups-pdf` package with `printer-driver-cups-pdf` for compatibility with Debian Trixie (Debian 13) base image

## v1.11

- Fix Windows carriage returns (CRLF) and execution permissions on S6 overlay daemon scripts to ensure they start and run correctly in the Docker container

## v1.10

- Disable IPv6 support in Avahi daemon configuration

## v1.9

- Update Debian base image version to 9.3.0

## v1.8

- Fix the hostname conflict log spam by whitelisting physical/main network interfaces and ignoring virtual Docker interfaces in avahi-daemon

## v1.7

- Fix the issue with "ulimit" size and permissions
  
## v1.5

- Update Debian Base to 7.6.2
- Add HP drivers (printer-driver-hpcups)
