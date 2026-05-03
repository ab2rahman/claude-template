# SEO Checklist Guide

## On-Page SEO

### Meta Tags (Every Page)

```html
<!-- Required -->
<title>Page Title — Brand Name (50-60 chars)</title>
<meta name="description" content="Compelling description with keywords (150-160 chars)">
<link rel="canonical" href="https://example.com/page">

<!-- Open Graph (Social Sharing) -->
<meta property="og:title" content="Page Title">
<meta property="og:description" content="Description for social">
<meta property="og:image" content="https://example.com/og-image.jpg">
<meta property="og:url" content="https://example.com/page">
<meta property="og:type" content="website">

<!-- Twitter Card -->
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:title" content="Page Title">
<meta name="twitter:description" content="Description">
<meta name="twitter:image" content="https://example.com/og-image.jpg">
```

### Heading Hierarchy

```html
<h1>Main Page Title (only one per page)</h1>
  <h2>Section Title</h2>
    <h3>Subsection</h3>
  <h2>Another Section</h2>
    <h3>Subsection</h3>
      <h4>Detail</h4>
```

**Rules:**
- Exactly one `<h1>` per page
- Never skip levels (no h1 → h3)
- Keywords in headings, naturally

### Images

```html
<img
  src="product-photo.jpg"
  alt="Red leather wallet on wooden table"
  width="800"
  height="600"
  loading="lazy"
  decoding="async"
>
```

**Checklist:**
- [ ] Descriptive `alt` text (not "image" or filename)
- [ ] Width & height attributes (prevents CLS)
- [ ] Lazy loading for below-fold images
- [ ] WebP format with JPEG fallback
- [ ] Compressed (use Squoosh or Sharp)

### Internal Linking

```html
<!-- Good: descriptive anchor text -->
<a href="/products/wallets">leather wallets</a>

<!-- Bad: generic anchor text -->
<a href="/products/wallets">click here</a>
```

**Strategy:**
- Link to related pages naturally
- Use descriptive anchor text
- 3-5 internal links per 1000 words
- Link from high-authority pages to new content

## Technical SEO

### robots.txt

```txt
User-agent: *
Allow: /
Disallow: /api/
Disallow: /admin/
Disallow: /*?sort=

Sitemap: https://example.com/sitemap.xml
```

### XML Sitemap

```xml
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  <url>
    <loc>https://example.com/</loc>
    <lastmod>2024-01-15</lastmod>
    <changefreq>weekly</changefreq>
    <priority>1.0</priority>
  </url>
  <url>
    <loc>https://example.com/products</loc>
    <lastmod>2024-01-14</lastmod>
    <changefreq>daily</changefreq>
    <priority>0.8</priority>
  </url>
</urlset>
```

### Structured Data (JSON-LD)

```html
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "Article",
  "headline": "Article Title",
  "description": "Article description",
  "image": "https://example.com/image.jpg",
  "datePublished": "2024-01-15",
  "dateModified": "2024-01-15",
  "author": {
    "@type": "Person",
    "name": "Author Name"
  },
  "publisher": {
    "@type": "Organization",
    "name": "Brand",
    "logo": {
      "@type": "ImageObject",
      "url": "https://example.com/logo.png"
    }
  }
}
</script>
```

**Common schema types:**
- `Article` — Blog posts
- `Product` — E-commerce products
- `FAQPage` — FAQ sections
- `BreadcrumbList` — Navigation breadcrumbs
- `Organization` — Company info
- `LocalBusiness` — Local SEO

### URL Structure

```
✅ Good:
/products/leather-wallet
/blog/how-to-style-wallets
/category/mens-accessories

❌ Bad:
/p/12345
/blog/post?id=123
/cat/men's accessories
```

**Rules:**
- Lowercase, hyphenated
- Include target keyword
- Short and descriptive
- No parameters or session IDs
- Consistent pattern across site

## Performance (Core Web Vitals)

### LCP (Largest Contentful Paint) < 2.5s

```typescript
// Optimize largest element (usually hero image or text block)
// - Preload hero images
<link rel="preload" as="image" href="hero.webp">

// - Use CDN for static assets
// - Compress images (WebP, AVIF)
// - Server-side render above-fold content
```

### FID/INP (Interaction) < 100ms

```typescript
// Minimize JavaScript blocking
// - Code split routes
// - Defer non-critical JS
<script src="analytics.js" defer></script>

// - Avoid heavy synchronous operations
// - Use web workers for complex calculations
```

### CLS (Cumulative Layout Shift) < 0.1

```html
<!-- Always set image dimensions -->
<img src="photo.jpg" width="800" height="600" alt="...">

<!-- Reserve space for dynamic content -->
<div style="aspect-ratio: 16/9; background: #eee;">
  <!-- Video or embed loads here -->
</div>

<!-- Use font-display: swap -->
@font-face {
  font-family: 'Inter';
  src: url('/fonts/inter.woff2') format('woff2');
  font-display: swap;
}
```

## SEO Audit Checklist

| Category | Check | Priority |
|----------|-------|----------|
| **Indexation** | robots.txt not blocking important pages | Critical |
| **Indexation** | XML sitemap submitted to Search Console | Critical |
| **Indexation** | Canonical URLs set correctly | Critical |
| **Meta** | Title tag on every page (50-60 chars) | Critical |
| **Meta** | Meta description on every page (150-160 chars) | High |
| **Meta** | Open Graph tags for social sharing | Medium |
| **Content** | Single H1 per page | High |
| **Content** | Proper heading hierarchy | High |
| **Content** | Images have alt text | High |
| **Technical** | HTTPS enforced | Critical |
| **Technical** | Page speed < 3s | High |
| **Technical** | Mobile responsive | Critical |
| **Technical** | Structured data (JSON-LD) | Medium |
| **Technical** | No broken links | Medium |
| **Performance** | LCP < 2.5s | High |
| **Performance** | CLS < 0.1 | High |
| **Performance** | INP < 200ms | Medium |

## Commands

| Command | Usage | Pattern |
|---------|-------|---------|
| `/seo:audit` | Full SEO audit | 3 (full) |
| `/seo:content` | Create SEO content | 2 (skill) |
| `/seo:meta` | Generate meta tags | 2 (skill) |
| `/seo:lighthouse` | Run Lighthouse | 1 (bash) |
