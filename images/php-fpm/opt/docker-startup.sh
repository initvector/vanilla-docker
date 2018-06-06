#!/bin/ash

# Cleanup before shutdown.
cleanup() {
    kill -QUIT "$fpmPID" 2>/dev/null
    rm -f /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
    exit
}

trap cleanup TERM

# Reload certificates so that everything in /usr/local/share/ca-certificates is loaded.
update-ca-certificates

if [ -z "$VANILLA_DOCKER_DISABLE_XDEBUG" ] || [ "$VANILLA_DOCKER_DISABLE_XDEBUG" -eq "0" ]; then
    docker-php-ext-enable xdebug
fi

# Start the PHP FastCGI process manager. Capture its PID, so we can perform a graceful shutdown of the service.
php-fpm &
fpmPID=$!
wait "$fpmPID"
