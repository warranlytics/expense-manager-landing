#!/bin/sh
# ==============================================================================
# Docker Entrypoint Script for Nginx Container
# ==============================================================================
# Purpose: Inject runtime environment variables into the built static export
# 
# How it works:
# 1. Next.js build-time env vars are baked into static HTML/JS at build time
# 2. This script can optionally replace placeholders at runtime if needed
# ==============================================================================

set -e

echo "=== Expenser Landing - Starting ==="
echo "Environment: ${NODE_ENV:-production}"

# Optional: Log environment variables (sanitize sensitive data)
if [ "${NEXT_PUBLIC_ENABLE_DEBUG}" = "true" ]; then
    echo "Debug mode enabled"
    echo "Site URL: ${NEXT_PUBLIC_SITE_URL}"
    echo "App URL: ${NEXT_PUBLIC_EXPENSE_MANAGER_APP_URL}"
fi

# Create nginx PID directory
mkdir -p /var/run

echo "=== Starting Nginx ==="
exec "$@"
