# ADINETA Standard v1.0.0

ADINETA is a standalone Linux x86_64 IPv4 network-reconnaissance tool for systems and networks that you own or are explicitly authorized to test.

## Install

Run the public installer:

```sh
curl -fsSL https://github.com/elitelab-dev/ADINETA-Releases/releases/download/v1.0.0/install.sh | sh
```

The installer downloads the release asset over HTTPS, verifies its SHA-256, installs under `~/.local/share/adineta/v1.0.0`, and exposes the command at `~/.local/bin/adineta` without requiring root. Add `~/.local/bin` to `PATH` if necessary.

## Run

```sh
adineta --help
adineta 127.0.0.1 --ports 1 --transport tcp --report terminal
```

Supported release evidence includes TCP and UDP scanning, combined transport operation, explicit port lists, terminal/JSON/CSV reports, and local HTTP service detection.

## Compatibility

Linux x86_64 on glibc-based distributions with glibc 2.34 or newer. This distribution is not a musl build and does not target other architectures.

## Integrity

The release page publishes the archive SHA-256 in a separate checksum file. Verify the archive before extraction.

## Legal and privacy

Use only on owned or explicitly authorized systems. Reports may contain addresses, port states, service observations, timestamps, and probe metadata. Keep the included binary license, third-party notices, and license texts with the distribution.

See [INSTALL.md](INSTALL.md) for installation, removal, and troubleshooting details.
