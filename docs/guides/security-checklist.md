# Security Checklist Guide

## Application Security

### Input Validation

```typescript
// Always validate and sanitize user input
import { z } from 'zod';

const schema = z.object({
  email: z.string().email(),
  name: z.string().min(2).max(100),
  age: z.number().int().min(0).max(150),
});

// Never trust client-side validation alone
app.post('/api/users', validate(schema), handler);
```

**Rules:**
- Validate on server side (never trust client)
- Whitelist allowed characters (don't blacklist)
- Use parameterized queries (never string concatenation)
- Limit file upload size and types
- Sanitize output to prevent XSS

### SQL Injection Prevention

```typescript
// BAD — SQL injection vulnerability
db.query(`SELECT * FROM users WHERE email = '${email}'`);

// GOOD — Parameterized query
db.query('SELECT * FROM users WHERE email = $1', [email]);

// GOOD — ORM (Prisma)
prisma.user.findUnique({ where: { email } });
```

### XSS Prevention

```typescript
// BAD — dangerouslySetInnerHTML with user content
<div dangerouslySetInnerHTML={{ __html: userInput }} />

// GOOD — React auto-escapes
<div>{userInput}</div>

// GOOD — Sanitize if HTML is needed
import DOMPurify from 'dompurify';
<div dangerouslySetInnerHTML={{ __html: DOMPurify.sanitize(userInput) }} />
```

### CSRF Protection

```typescript
// Use SameSite cookies
app.use(session({
  cookie: {
    sameSite: 'strict',
    secure: true,
    httpOnly: true,
  },
}));

// Or CSRF token pattern
import csrf from 'csurf';
app.use(csrf({ cookie: true }));
```

## Authentication Security

### Password Storage

```typescript
import bcrypt from 'bcryptjs';

// Hashing (cost factor 12)
const hash = await bcrypt.hash(password, 12);

// Verification
const valid = await bcrypt.compare(inputPassword, storedHash);
```

### JWT Best Practices

```typescript
// Short-lived access token + long-lived refresh token
const accessToken = jwt.sign({ sub: userId }, SECRET, { expiresIn: '15m' });
const refreshToken = jwt.sign({ sub: userId }, REFRESH_SECRET, { expiresIn: '7d' });

// Store in httpOnly cookie (not localStorage)
res.cookie('token', accessToken, {
  httpOnly: true,
  secure: true,
  sameSite: 'strict',
  maxAge: 15 * 60 * 1000, // 15 minutes
});
```

### Session Management

- Invalidate sessions on password change
- Limit concurrent sessions
- Implement proper logout (destroy server-side)
- Use secure, httpOnly, SameSite cookies
- Rotate session IDs after login

## Server Hardening

### SSH Configuration

```bash
# /etc/ssh/sshd_config
Port 2222                          # Non-standard port
PermitRootLogin no                 # No root login
PasswordAuthentication no          # Key-based auth only
PubkeyAuthentication yes
AllowUsers deploy                  # Only specific users
MaxAuthTries 3
ClientAliveInterval 300
ClientAliveCountMax 2
```

### Firewall (UFW)

```bash
# Default deny
ufw default deny incoming
ufw default allow outgoing

# Allow only needed ports
ufw allow 2222/tcp     # SSH (non-standard)
ufw allow 80/tcp       # HTTP
ufw allow 443/tcp      # HTTPS

# Rate limit SSH
ufw limit 2222/tcp

ufw enable
```

### Fail2ban

```ini
# /etc/fail2ban/jail.local
[sshd]
enabled = true
port = 2222
filter = sshd
logpath = /var/log/auth.log
maxretry = 3
bantime = 3600
findtime = 600
```

## HTTP Security Headers

```nginx
# Nginx headers
add_header X-Frame-Options "SAMEORIGIN" always;
add_header X-Content-Type-Options "nosniff" always;
add_header X-XSS-Protection "1; mode=block" always;
add_header Referrer-Policy "strict-origin-when-cross-origin" always;
add_header Content-Security-Policy "default-src 'self'; script-src 'self'; style-src 'self' 'unsafe-inline'" always;
add_header Permissions-Policy "camera=(), microphone=(), geolocation=()" always;
add_header Strict-Transport-Security "max-age=31536000; includeSubDomains; preload" always;
```

### Header Purpose

| Header | Purpose | Recommended Value |
|--------|---------|-------------------|
| `X-Frame-Options` | Prevent clickjacking | `SAMEORIGIN` |
| `X-Content-Type-Options` | Prevent MIME sniffing | `nosniff` |
| `Strict-Transport-Security` | Force HTTPS | `max-age=31536000` |
| `Content-Security-Policy` | Control resource loading | Whitelist sources |
| `Referrer-Policy` | Control referrer info | `strict-origin-when-cross-origin` |
| `Permissions-Policy` | Control browser features | Disable unused |

## Dependency Security

```bash
# Node.js
npm audit                    # Check known vulnerabilities
npm audit fix                # Auto-fix where possible
npx npm-check-updates -u     # Update dependencies

# Python
pip audit                    # Check known vulnerabilities
safety check                 # Another vulnerability scanner
```

### Package.json Security

```json
{
  "scripts": {
    "preinstall": "npx npm-force-resolutions",
    "audit": "npm audit --audit-level=high"
  }
}
```

## Secret Management

### Rules

- **Never** hardcode secrets in source code
- **Never** commit `.env` files
- **Always** use environment variables
- **Rotate** secrets regularly
- **Restrict** API key permissions to minimum needed

### .gitignore Essentials

```gitignore
.env
.env.local
.env.production
*.pem
*.key
credentials.json
service-account.json
```

### Environment Variable Pattern

```typescript
// config/env.ts
export const env = {
  DATABASE_URL: process.env.DATABASE_URL!,           // Required
  JWT_SECRET: process.env.JWT_SECRET!,                // Required
  PORT: process.env.PORT || '3000',                   // Optional with default
  NODE_ENV: process.env.NODE_ENV || 'development',    // Optional with default
} as const;

// Validate at startup
Object.entries(env).forEach(([key, value]) => {
  if (!value && !key.endsWith('_PORT') && key !== 'NODE_ENV') {
    throw new Error(`Missing required env var: ${key}`);
  }
});
```

## SSL/TLS

```bash
# Check certificate
openssl s_client -connect example.com:443 -servername example.com

# Check expiration
echo | openssl s_client -connect example.com:443 2>/dev/null | openssl x509 -noout -dates

# Let's Encrypt renewal
certbot renew --dry-run
```

## Security Audit Checklist

| Category | Check | Severity |
|----------|-------|----------|
| **Injection** | Parameterized queries used | Critical |
| **Auth** | Passwords hashed (bcrypt) | Critical |
| **Auth** | JWT stored in httpOnly cookie | Critical |
| **Auth** | Rate limiting on auth endpoints | High |
| **Data** | HTTPS enforced everywhere | Critical |
| **Data** | Sensitive data encrypted at rest | High |
| **Headers** | All security headers present | High |
| **Headers** | HSTS enabled | High |
| **Deps** | No critical/high vulnerabilities | Critical |
| **Secrets** | No hardcoded credentials | Critical |
| **Secrets** | .env in .gitignore | Critical |
| **Server** | SSH key-based auth only | Critical |
| **Server** | Firewall configured | High |
| **Server** | Fail2ban installed | Medium |
| **Input** | All user input validated | Critical |
| **Input** | File uploads restricted | High |

## Commands

| Command | Usage | Pattern |
|---------|-------|---------|
| `/security:audit` | Full security audit | 3 (full) |
| `/security:headers` | Check security headers | 2 (skill) |
| `/security:deps` | Scan dependencies | 2 (skill) |
| `/security:secrets` | Check for exposed secrets | 2 (skill) |
