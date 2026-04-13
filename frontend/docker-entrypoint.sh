#!/bin/sh
set -e

# Generate runtime config from environment variables
# Served as a static JS file that sets window.__RUNTIME_CONFIG__ before the app loads
mkdir -p /app/.output/public
cat > /app/.output/public/runtime-config.js <<EOF
window.__RUNTIME_CONFIG__ = {
  VITE_API_URL: "${VITE_API_URL:-}"
};
EOF

exec "$@"
