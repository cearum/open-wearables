#!/bin/sh
set -e

# Replace the build-time placeholder with the runtime VITE_API_URL
if [ -n "$VITE_API_URL" ]; then
  find /app/dist -type f -name '*.js' -exec sed -i "s|__VITE_API_URL_PLACEHOLDER__|${VITE_API_URL}|g" {} +
fi

exec "$@"
