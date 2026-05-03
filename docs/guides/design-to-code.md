# Design-to-Code Guide

## Workflow Overview

```
Design File (Figma) → Extract Specs → Implement Code → Verify
```

## Figma Analysis

### What to Extract

| Property | Where to Look | What to Note |
|----------|---------------|--------------|
| Colors | Fill/Stroke panels | Hex values, opacity, gradients |
| Typography | Text panel | Font family, weight, size, line-height, letter-spacing |
| Spacing | Auto-layout, Position | Padding, margin, gaps (px/rem) |
| Layout | Auto-layout, Constraints | Flex direction, alignment, wrap |
| Borders | Stroke panel | Width, color, radius |
| Shadows | Effects panel | X, Y, blur, spread, color |
| States | Component variants | Hover, focus, active, disabled |
| Breakpoints | Frame sizes | Mobile, tablet, desktop widths |

## Design Token Mapping

### Colors

```css
/* From Figma to CSS custom properties */
:root {
  /* Primary */
  --color-primary-50: #eff6ff;
  --color-primary-100: #dbeafe;
  --color-primary-500: #3b82f6;
  --color-primary-600: #2563eb;
  --color-primary-700: #1d4ed8;

  /* Semantic */
  --color-bg: #ffffff;
  --color-surface: #f8fafc;
  --color-text: #0f172a;
  --color-text-muted: #64748b;
  --color-border: #e2e8f0;
  --color-success: #22c55e;
  --color-error: #ef4444;
  --color-warning: #f59e0b;
}
```

### Spacing Scale

```css
:root {
  --space-0: 0;
  --space-1: 0.25rem;   /* 4px */
  --space-2: 0.5rem;    /* 8px */
  --space-3: 0.75rem;   /* 12px */
  --space-4: 1rem;      /* 16px */
  --space-5: 1.25rem;   /* 20px */
  --space-6: 1.5rem;    /* 24px */
  --space-8: 2rem;      /* 32px */
  --space-10: 2.5rem;   /* 40px */
  --space-12: 3rem;     /* 48px */
}
```

### Typography Scale

```css
:root {
  --font-sans: 'Inter', system-ui, sans-serif;
  --font-mono: 'JetBrains Mono', monospace;

  --text-xs: 0.75rem;    /* 12px */
  --text-sm: 0.875rem;   /* 14px */
  --text-base: 1rem;     /* 16px */
  --text-lg: 1.125rem;   /* 18px */
  --text-xl: 1.25rem;    /* 20px */
  --text-2xl: 1.5rem;    /* 24px */
  --text-3xl: 1.875rem;  /* 30px */
  --text-4xl: 2.25rem;   /* 36px */
}
```

## Component Implementation

### Button Example

**Figma Specs:**
- Height: 44px
- Padding: 0 24px
- Border radius: 8px
- Background: #2563EB
- Text: white, 16px, font-weight 600
- Hover: background #1D4ED8
- Disabled: opacity 0.5

```css
.btn {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  height: 44px;
  padding: 0 24px;
  border-radius: 8px;
  background: var(--color-primary-600);
  color: white;
  font-size: var(--text-base);
  font-weight: 600;
  cursor: pointer;
  transition: background 0.15s ease;
}

.btn:hover { background: var(--color-primary-700); }
.btn:disabled { opacity: 0.5; cursor: not-allowed; }
```

### Card Example

**Figma Specs:**
- Padding: 24px
- Border radius: 12px
- Background: #FFFFFF
- Border: 1px solid #E2E8F0
- Shadow: 0 1px 3px rgba(0,0,0,0.1)

```css
.card {
  padding: var(--space-6);
  border-radius: 12px;
  background: var(--color-bg);
  border: 1px solid var(--color-border);
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
}
```

## Responsive Strategy

### Breakpoints

| Name | Width | Usage |
|------|-------|-------|
| Mobile | < 640px | Single column, stacked |
| Tablet | 640px - 1024px | Two columns |
| Desktop | > 1024px | Full layout |

### Implementation

```css
/* Mobile first */
.grid {
  display: grid;
  grid-template-columns: 1fr;
  gap: var(--space-4);
}

@media (min-width: 640px) {
  .grid { grid-template-columns: repeat(2, 1fr); }
}

@media (min-width: 1024px) {
  .grid { grid-template-columns: repeat(3, 1fr); }
}
```

## Accessibility Checks

| Check | Standard | Tool |
|-------|----------|------|
| Color contrast | WCAG 2.1 AA (4.5:1 text) | Contrast checker |
| Touch targets | Min 44x44px | Manual |
| Focus indicators | Visible on all interactive | Keyboard tab |
| Screen reader | Alt text, ARIA labels | NVDA/VoiceOver |
| Semantic HTML | Proper heading hierarchy | Lighthouse |

## Commands

| Command | Usage | Pattern |
|---------|-------|---------|
| `/design:analyze` | Analyze design image | 2 (skill) |
| `/design:implement` | Implement design in code | 3 (full) |
| `/design:figma` | Figma integration | 2 (skill) |
| `/design:theme` | Create theme/tokens | 2 (skill) |
