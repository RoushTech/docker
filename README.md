# Base Images

- Base Image
- PHP
- Magento

# Build everything:

```bash
# Fundimentally, this is all it takes:
docker buildx bake --provenance=false --push --progress=plain

# But we have some test wrappers to automatically test and push
./test && ./bake
```

## Architecture of the Containers

[![Architecture](./.docs/pwh-container-stack.svg)](./.docs/pwh-container-stack.svg)

Based on runit. It runs multiple processes internally, and monitors them. In the `/etc/services.d/` directory you'll find the following services at time of writing:

- `alpine-*-base`: Base image
  - `/etc/services.d/logs/`: Log service, which collects logs from the other services and writes them to files.
    - Setting the envvar `LOG_PATHS` to a space-seperated list of paths will make the log service collect logs from those paths and write them to stdout.
  - `/etc/services.d/splash/`: Splash service, which is a simple web server that serves the splash page.
  - `/etc/services.d/cron/`: Cron service.
- `php-*-base`: PHP flavoured base image
  - `/etc/services.d/nginx/`: Nginx service.
  - `/etc/services.d/php/`: PHP-FPM service, which runs the PHP application itself.
- `php-*-node-base`: PHP flavoured base image with Node.js support
  - `/etc/services.d/npm-babysitter/`: Monitors permissions on the node cache directories and fixes them if they change.
  - `/etc/services.d/npm-watcher/`:
    - Similar to the logs service, setting the envvar `NPM_WATCH_PATHS` will make the npm watcher run `npm run watch` in those paths.
    - [ WARNING ]: This is currently busted.
- `magento-*-base`: Magento flavoured base image
  - `/etc/services.d/magento/`: Magento service, which runs the Magento application.
    - Fixes cache permissions, and runs any scripts loaded into `/etc/services.d/magento/tasks.d/` to get your Magento application going and touches `/etc/services.d/magento/done` upon completion.
- `java-*-base`: Java flavoured base image
- `java-war-machine-*-base`: Java War Machine flavoured base image
  - `/etc/services.d/java/`: Java service runner, which runs any `.war` files placed into `/app`

Each directory contains a `run` script that starts the service.
The `run` script is executed by runit when the container starts.
If the `run` script exits, runit will restart it, unless there is a `finish` script.
The `finish` script will get the exit code of `run` as its `$1` argument.
The `finish` script can decide to sleep forever or exit to restart the service.
More can be read in the [runit documentation](http://smarden.org/runit) particularly [runsv](https://smarden.org/runit/runsv.8) and [runsvdir](https://smarden.org/runit/runsvdir.8)

## Configurable Options

| Environment Variable   | Affected Images    | Default                                                   | Options                                                                                        | Description                                                                                                                      |
| ---------------------- | ------------------ | --------------------------------------------------------- | ---------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------- |
| `MAGENTO_MODE`         | `magento`          | `developer`                                               | `developer` or `production`                                                                    | The mode in which Magento will run.                                                                                              |
| `NPM_WATCH_PATHS`      | `php-node+`        | `""`                                                      | Space seperated paths.                                                                         | Paths to watch for changes. The paths to watch for changes using `npm run watch` in the application.                             |
| `PHP_MEMORY_LIMIT`     | `php+`             | `256M`                                                    | `256M`, `2G` etc                                                                               | The memory limit for PHP scripts.                                                                                                |
| `PHP_CLI_MEMORY_LIMIT` | `php+`             | `4G`                                                      | `256M`, `2G` etc                                                                               | The memory limit for PHP CLI scripts.                                                                                            |
| `PHP_DEBUG_MODE`       | `php+`             | `null`                                                    | `on`                                                                                           | Enable or disable debug mode.                                                                                                    |
| `PHP_ERROR_REPORTING`  | `php+`             | `E_ALL` if `PHP_DEBUG_MODE` is `on`. `E_ERROR` otherwise. | [Expressions from error_reporting](https://www.php.net/manual/en/function.error-reporting.php) | override error_reporting level.                                                                                                  |
| `PHP_DISPLAY_ERRORS`   | `php+`             | `on` when `PHP_DEBUG_MODE` is on. `off` otherwise         | `on` or `off`                                                                                  | Enable or disable display errors.                                                                                                |
| `WAR_FILE`             | `java-war-machine` | `null`                                                    | Path to a `.war` file.                                                                         | An explicit path to the `.war` file to run. Will be autodetected if not present. Only neccisary if executable name is ambiguous. |
| `NTP_SERVER`           | `base+`            | `0.pool.ntp.org`                                          | Any valid NTP server address                                                                   | The NTP server to use for time synchronization.                                                                                  |
| `LOG_PATHS`            | `base+`            | ``, overridden by `php` base image etc.                   | Space seperated paths.                                                                         | Paths to collect logs from. The paths of files to collect logs from and write them to stdout.                                    |

## Versions available

| Container        | Is `:latest` | Version     | Alpine      | Other component versions | Node Version | Tag                                          |
| ---------------- | ------------ | ----------- | ----------- | ------------------------ | ------------ | -------------------------------------------- |
| Magento          | ️            |             | Alpine 3.22 | PHP 8.4                  | Node 22      | ghcr.io/roushtech/docker/magento:8.4         |
| Magento          | ✔️           |             | Alpine 3.18 | PHP 8.1                  | Node 18      | ghcr.io/roushtech/docker/magento:8.1         |
| PHP+Node         | ️            | PHP 8.4     | Alpine 3.22 | PHP 8.4                  | Node 22      | ghcr.io/roushtech/docker/php-node:8.4        |
| PHP+Node         | ✔️           | PHP 8.1     | Alpine 3.18 | PHP 8.1                  | Node 18      | ghcr.io/roushtech/docker/php-node:8.1        |
| PHP              |              | PHP 8.4     | Alpine 3.21 | PHP 8.4                  |              | ghcr.io/roushtech/docker/php-node:8.4        |
| PHP              |              | PHP 8.1     | Alpine 3.18 | PHP 8.1                  |              | ghcr.io/roushtech/docker/php-node:8.1        |
| PHP              |              | PHP 7.4     | Alpine 3.15 | PHP 7.4                  |              | ghcr.io/roushtech/docker/php-node:7.4        |
| Java             | ✔️           | OpenJDK 21  | Alpine 3.22 |                          |              | ghcr.io/roushtech/docker/java:21             |
| Java             |              | OpenJDK 17  | Alpine 3.22 |                          |              | ghcr.io/roushtech/docker/java:17             |
| Java             |              | OpenJDK 11  | Alpine 3.22 |                          |              | ghcr.io/roushtech/docker/java:11             |
| Java             |              | OpenJDK 8   | Alpine 3.22 |                          |              | ghcr.io/roushtech/docker/java:8              |
| Java War Machine |              | OpenJDK 21  | Alpine 3.22 |                          |              | ghcr.io/roushtech/docker/java:war-machine-21 |
| Java War Machine |              | OpenJDK 17  | Alpine 3.22 |                          |              | ghcr.io/roushtech/docker/java:war-machine-17 |
| Java War Machine |              | OpenJDK 11  | Alpine 3.22 |                          |              | ghcr.io/roushtech/docker/java:war-machine-11 |
| Base             |              | Alpine 3.21 | Alpine 3.21 |                          |              | ghcr.io/roushtech/docker/base:3.21           |
| Base             |              | 3.18        | Alpine 3.18 |                          |              | ghcr.io/roushtech/docker/base:3.18           |
| Base             |              | 3.15        | Alpine 3.15 |                          |              | ghcr.io/roushtech/docker/base:3.15           |
