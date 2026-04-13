#!/bin/sh
set -e

if [ -n "$VITE_API_URL" ]; then
  find /usr/share/nginx/html -type f -name '*.js' -exec sed -i "s|__VITE_API_URL_PLACEHOLDER__|${VITE_API_URL}|g" {} + 2>/dev/null || true
  find .output -type f -name '*.mjs' -o -name '*.js' | xargs sed -i "s|__VITE_API_URL_PLACEHOLDER__|${VITE_API_URL}|g" 2>/dev/null || true
fi

exec "$@"
