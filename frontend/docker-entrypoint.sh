#!/bin/sh
set -e

# Overwrite the runtime config that was included at build time
# Since the file existed in public/ during build, Nitro already has the route registered
cat > /app/.output/public/runtime-config.js <<EOF
window.__RUNTIME_CONFIG__ = {
  VITE_API_URL: "${VITE_API_URL:-}"
};
EOF

exec "$@"
