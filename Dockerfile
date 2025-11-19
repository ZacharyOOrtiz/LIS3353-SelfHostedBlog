# --- Stage 1: Build the Site ---
# Use the 'exts' tag (Extended version + plugins)
FROM hugomods/hugo:exts as builder

# Set the source folder
WORKDIR /src

# Copy your project files
COPY . .

# Build the site
RUN hugo --minify --gc

# --- Stage 2: Serve the Site ---
FROM caddy:alpine

COPY Caddyfile /etc/caddy/Caddyfile
COPY --from=builder /src/public /usr/share/caddy

EXPOSE 80
