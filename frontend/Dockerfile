# Build stage
FROM node:22-alpine AS builder

# Install pnpm
RUN corepack enable && corepack prepare pnpm@10.13.1 --activate

WORKDIR /app

# Use a placeholder that docker-entrypoint.sh will replace at runtime
ENV VITE_API_URL=__VITE_API_URL_PLACEHOLDER__

# Copy package files
COPY package.json pnpm-lock.yaml ./

# Install dependencies
RUN pnpm install --frozen-lockfile

# Copy source files
COPY . .

# Build the application in production mode
ENV NODE_ENV=production
RUN pnpm run build

# Determine build output directory and prepare it for copying
# Nitro outputs to .output/public, Vite outputs to dist
RUN if [ -d /app/.output/public ]; then \
      echo "Using Nitro output: .output/public"; \
      cp -r /app/.output/public /app/build-output; \
    elif [ -d /app/dist ]; then \
      echo "Using Vite output: dist"; \
      cp -r /app/dist /app/build-output; \
    else \
      echo "ERROR: No build output found!"; \
      ls -la /app/; \
      exit 1; \
    fi

# Production stage
FROM node:22-alpine

WORKDIR /app
# Copy built assets from builder
COPY --from=builder /app/build-output /usr/share/nginx/html

# Copy built output from builder
COPY --from=builder /app/.output ./.output

# Expose port
EXPOSE 3000

# Set the port for Nitro
ENV NODE_ENV=production
ENV PORT=3000
ENV HOST=0.0.0.0

# Copy in the docker-entrypoint to replace env placeholders at runtime
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

# Run the Nitro server
CMD ["node", ".output/server/index.mjs"]
