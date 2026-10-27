# Installation and removal

## Requirements

- Linux x86_64.
- glibc 2.34 or newer.
- HTTPS download access during installation.
- No root privileges are required.

## Install

```sh
curl -fsSL https://github.com/elitelab-dev/ADINETA-Releases/releases/download/v1.0.0/install.sh | sh
```

Then open a new shell or run:

```sh
export PATH="$HOME/.local/bin:$PATH"
adineta --help
```

The installer stages and verifies the new version before switching the `adineta` command. A previous installation is retained until the new installation is ready.

## Remove

```sh
rm -f "$HOME/.local/bin/adineta"
rm -rf "$HOME/.local/share/adineta/v1.0.0"
```

Do not remove another version unless you have confirmed it is no longer needed.

## Troubleshooting

Check architecture with `uname -m` and glibc with `getconf GNU_LIBC_VERSION`. Keep `standard_entry.dist` together; the executable depends on its bundled runtime library. The Standard CLI does not expose `--version`.
