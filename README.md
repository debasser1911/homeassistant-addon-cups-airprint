# CUPS AirPrint Home Assistant Add-on

A CUPS print server add-on with working Avahi in reflector mode.

## Features & Fixes
* **Avahi Hostname Conflict Fix**: Dynamically detects active network interfaces on startup and restricts Avahi to bind only to the host's physical network interfaces (e.g., `eth0`, `enp*`). It ignores all virtual interfaces (`veth*`, `docker*`, `hassio*`, `lo`, `br-*`), avoiding endless hostname collision loops and log spam.
* **Disabled IPv6**: IPv6 is disabled in the Avahi daemon configuration by default to ensure stability and compatibility.
* **Modernized Base Image**: Upgraded to the latest `ghcr.io/hassio-addons/debian-base:9.3.0` base image.

## Getting Started
* **CUPS Administrator Credentials**: Username: `print`, Password: `print` (can be changed in the `Dockerfile`).
* **Configuration Storage**: Config files are persisted in the `/addon_configs/<slug>_cups` folder.

[![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL pre-filled.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2Fdebasser1911%2Fhomeassistant-addon-cups-airprint)
