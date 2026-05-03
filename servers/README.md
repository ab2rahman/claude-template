# Servers

Server configuration files and templates.

## Structure

```
servers/
├── nginx/
│   ├── reverse-proxy.conf      # Reverse proxy template
│   ├── spa.conf                # Single page application config
│   └── security-headers.conf   # Security headers snippet
├── pm2/
│   └── ecosystem.config.js     # PM2 process manager template
├── docker/
│   ├── Dockerfile.node         # Node.js multi-stage build
│   ├── Dockerfile.python       # Python Dockerfile
│   └── docker-compose.yml      # Development compose file
└── ssl/
    └── certbot-setup.sh        # Let's Encrypt setup script
```

## Usage

Copy the relevant template to your project and customize:

```bash
# Nginx reverse proxy
cp servers/nginx/reverse-proxy.conf /etc/nginx/sites-available/myapp

# PM2 ecosystem
cp servers/pm2/ecosystem.config.js ~/projects/myapp/

# Docker
cp servers/docker/Dockerfile.node ~/projects/myapp/Dockerfile
```

## Adding Server Configs

When adding new server configurations:

1. Use templates with `${VARIABLE}` placeholders for environment-specific values
2. Include comments explaining each section
3. Add security best practices by default
4. Document any prerequisites in a comment at the top
5. Never include actual credentials or domain names
