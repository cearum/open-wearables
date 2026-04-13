#!/bin/sh
set -e

if [ -n "$VITE_API_URL" ]; then
  # Replace placeholder in all JS/MJS files across the entire build output
  find /app/.output -type f \( -name '*.js' -o -name '*.mjs' -o -name '*.json' \) -exec sed -i "s|__VITE_API_URL_PLACEHOLDER__|${VITE_API_URL}|g" {} +
  find /usr/share/nginx/html -type f \( -name '*.js' -o -name '*.json' \) -exec sed -i "s|__VITE_API_URL_PLACEHOLDER__|${VITE_API_URL}|g" {} + 2>/dev/null || true
fi

exec "$@"
