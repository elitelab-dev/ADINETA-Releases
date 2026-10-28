# ADINETA Standard v1.0.1

ADINETA is a standalone Linux x86_64 IPv4 network-reconnaissance tool by ELITE LAB Works. Use it only on systems and networks that you own or are explicitly authorized to test.

## Installation

Use the release installer from the v1.0.1 GitHub Release:

```sh
curl -fsSL https://github.com/elitelab-dev/ADINETA-Releases/releases/download/v1.0.1/install.sh | sh
```

The installer requires Linux x86_64 and glibc 2.34 or newer, downloads over HTTPS, verifies SHA-256, and installs without `sudo` under `~/.local/share/adineta/1.0.1`. Add `~/.local/bin` to `PATH` if needed.

## Usage

```sh
adineta --help
adineta 127.0.0.1 --ports 1 --transport tcp --report terminal
```

The release supports TCP, UDP and combined `both` transport scans, explicit ports and ranges, terminal/JSON/CSV reports, bounded timeouts, retries, concurrency controls, and supported service detection. Quick and Full presets are TCP-only; Custom Scan accepts `tcp`, `udp`, or `both`, with TCP as the default when Enter is pressed.

The Custom Scan prompt is:

```text
Transport (tcp/udp/both) [default: tcp]:
```

## Integrity and legal notice

Verify the archive before extraction using the SHA-256 checksum published with the release. The v1.0.1 archive SHA-256 is recorded in the release checksum file.

Use ADINETA only on owned or explicitly authorized systems. Reports can contain addresses, port states, service observations, timestamps, and probe metadata. Keep `LICENSE_BINARY.txt`, `THIRD_PARTY_NOTICES.txt`, and the `licenses/` directory with the distribution. See [README_AR.md](README_AR.md) for Arabic documentation and [INSTALL.md](INSTALL.md) for installation, update, and removal details.

ADINETA is proprietary software; source code is not included in this binary distribution.
