# ptero-debian-nwnx

Docker image based on [ptero-eggs/yolks:debian](https://github.com/ptero-eggs/yolks) with [NWNX:EE](https://github.com/nwnxee/unified) pre-installed for running Neverwinter Nights: Enhanced Edition servers with NWNX support on [Pterodactyl](https://pterodactyl.io/).

```
ghcr.io/marcespiard/ptero-debian-nwnx:latest
```

## What's included

Everything from the base [yolks:debian](https://github.com/ptero-eggs/yolks) image, plus:

- Pre-built [NWNX:EE](https://github.com/nwnxee/unified) binaries in `/nwnx/` (pulled from the latest release)
- NWNX runtime dependencies:
  - MySQL/MariaDB client (`default-libmysqlclient-dev`, `libmariadb3`)
  - PostgreSQL client (`libpq5`)
  - SQLite (`libsqlite3-0`)
  - Ruby 3.1 (`libruby3.1`)
  - OpenSSL (`libssl3`)
  - .NET runtimes 7.0 and 8.0 with apphost packs (for the DotNET plugin)
  - `inotify-tools`, `patch`, `unzip`

## Default environment variables

| Variable | Default | Description |
|---|---|---|
| `NWNX_CORE_LOAD_PATH` | `/nwnx/` | Path to NWNX plugin binaries |
| `NWNX_CORE_LOG_LEVEL` | `6` | Log verbosity (1-7) |
| `NWNX_SERVERLOGREDIRECTOR_SKIP` | `n` | ServerLogRedirector enabled by default |
| `NWNX_SERVERLOGREDIRECTOR_LOG_LEVEL` | `6` | ServerLogRedirector log verbosity |
| `NWN_TAIL_LOGS` | `n` | Tail native NWN log files to stdout |

## Pterodactyl usage

Use this image in your NWN:EE egg configuration. The egg startup command needs to set `LD_PRELOAD` before launching the server:

```bash
export LD_PRELOAD="/nwnx/NWNX_Core.so" && cd bin/linux-x86 && ./nwserver-linux -port ${SERVER_PORT} -userdirectory '/home/container/user' -module "${MODULE_NAME}" ...
```

### Enabling NWNX plugins

All plugins are available but not loaded unless explicitly enabled. Enable individual plugins via environment variables:

```
NWNX_SQL_SKIP=n
NWNX_CREATURE_SKIP=n
NWNX_EVENTS_SKIP=n
```

To enable all plugins at once, set `NWNX_CORE_SKIP_ALL=n` — though it's recommended to only enable what you need.

## Credits

- [Pterodactyl](https://pterodactyl.io/) and [ptero-eggs/yolks](https://github.com/ptero-eggs/yolks) for the base image
- [NWNX:EE](https://github.com/nwnxee/unified) for the server extension framework
- [Beamdog](https://www.beamdog.com/) for Neverwinter Nights: Enhanced Edition
