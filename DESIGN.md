---
name: Ethos Finance
colors:
  surface: '#f9f9ff'
  surface-dim: '#cfdaf2'
  surface-bright: '#f9f9ff'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f0f3ff'
  surface-container: '#e7eeff'
  surface-container-high: '#dee8ff'
  surface-container-highest: '#d8e3fb'
  on-surface: '#111c2d'
  on-surface-variant: '#45464d'
  inverse-surface: '#263143'
  inverse-on-surface: '#ecf1ff'
  outline: '#76777d'
  outline-variant: '#c6c6cd'
  surface-tint: '#565e74'
  primary: '#000000'
  on-primary: '#ffffff'
  primary-container: '#131b2e'
  on-primary-container: '#7c839b'
  inverse-primary: '#bec6e0'
  secondary: '#505f76'
  on-secondary: '#ffffff'
  secondary-container: '#d0e1fb'
  on-secondary-container: '#54647a'
  tertiary: '#000000'
  on-tertiary: '#ffffff'
  tertiary-container: '#191c1e'
  on-tertiary-container: '#818486'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#dae2fd'
  primary-fixed-dim: '#bec6e0'
  on-primary-fixed: '#131b2e'
  on-primary-fixed-variant: '#3f465c'
  secondary-fixed: '#d3e4fe'
  secondary-fixed-dim: '#b7c8e1'
  on-secondary-fixed: '#0b1c30'
  on-secondary-fixed-variant: '#38485d'
  tertiary-fixed: '#e0e3e5'
  tertiary-fixed-dim: '#c4c7c9'
  on-tertiary-fixed: '#191c1e'
  on-tertiary-fixed-variant: '#444749'
  background: '#f9f9ff'
  on-background: '#111c2d'
  surface-variant: '#d8e3fb'
typography:
  headline-lg:
    fontFamily: Manrope
    fontSize: 32px
    fontWeight: '700'
    lineHeight: 40px
    letterSpacing: -0.02em
  headline-lg-mobile:
    fontFamily: Manrope
    fontSize: 24px
    fontWeight: '700'
    lineHeight: 32px
    letterSpacing: -0.01em
  headline-md:
    fontFamily: Manrope
    fontSize: 20px
    fontWeight: '600'
    lineHeight: 28px
  body-lg:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  body-sm:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
  label-caps:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '600'
    lineHeight: 16px
    letterSpacing: 0.05em
  data-mono:
    fontFamily: Inter
    fontSize: 18px
    fontWeight: '500'
    lineHeight: 24px
    letterSpacing: -0.01em
rounded:
  sm: 0.125rem
  DEFAULT: 0.25rem
  md: 0.375rem
  lg: 0.5rem
  xl: 0.75rem
  full: 9999px
spacing:
  unit: 8px
  container-max: 1200px
  gutter: 24px
  margin-mobile: 16px
  margin-desktop: 40px
---

## Brand & Style

The design system is rooted in the principles of **Modern Minimalism** with a focus on high-end financial clarity. It targets professionals who value precision, calm, and an editorial aesthetic in their personal utility tools. The visual narrative is one of "Invisible Utility"—where the interface recedes to let the data speak, using generous white space and a restricted palette to reduce cognitive load. 

The emotional response should be one of quiet confidence and control. By avoiding unnecessary decoration, the design system emphasizes a sophisticated, professional atmosphere that feels more like a premium publication than a typical cluttered financial dashboard.

## Colors

The color strategy utilizes a "Deep Navy" (`#0F172A`) as the primary anchor for text and structural elements, providing a more sophisticated contrast than pure black. 

- **Primary:** Deep Navy. Used for core branding, primary headers, and active states.
- **Secondary:** Slate Gray. Used for secondary information, icons, and inactive labels.
- **Tertiary:** Ice White/Gray. Used for surface backgrounds and subtle container fills.
- **Accents:** While not in the core tokens, use a specialized "Success Green" (#10B981) for positive cash flow and "Alert Red" (#EF4444) for expenses, both desaturated to maintain the elegant aesthetic.

## Typography

This design system pairs **Manrope** for headlines and **Inter** for body text. Manrope provides a modern, geometric warmth for high-level numbers and titles, while Inter offers clinical legibility for dense transaction lists and small labels.

Use `label-caps` for section headers and category titles to create a clear structural hierarchy. For financial figures, `data-mono` (utilizing Inter's tabular lining figures) ensures that numbers align perfectly in lists, aiding quick scanning of expenses.

## Layout & Spacing

The layout follows a **Fixed-Fluid Hybrid** model. On desktop, the content is centered within a 1200px container to prevent excessive line lengths. On mobile, it transitions to a fluid single-column layout.

A strict 8px grid governs all spacing. Vertical rhythm is critical: use `spacing.gutter` (24px) between distinct modules and `spacing.unit` (8px) for internal element grouping. This "generous whitespace" approach ensures the interface never feels cramped, even when displaying complex financial data.

## Elevation & Depth

This design system utilizes **Ambient Shadows** rather than heavy borders or fills to define depth. Surfaces should feel light and lifted.

- **Level 0 (Base):** The primary background (`#F8FAFC`).
- **Level 1 (Cards):** White surfaces with a very soft, diffused shadow: `0px 4px 20px rgba(15, 23, 42, 0.05)`.
- **Level 2 (Overlays/Modals):** White surfaces with a more pronounced shadow: `0px 10px 32px rgba(15, 23, 42, 0.1)`.

Avoid inner shadows or heavy bevels. The goal is a flat, layered paper aesthetic where elevation is suggested by the softest possible penumbra.

## Shapes

The shape language is **Soft (Level 1)**. This subtle rounding (4px for small elements, 8px for cards) bridges the gap between the sharpness of traditional finance and the approachability of modern software. It feels precise without being clinical, and friendly without being "bubbly."

## Components

### Buttons
Primary buttons use the Deep Navy fill with white text. Secondary buttons use a transparent background with a 1px Slate Gray border. Padding should be vertical: 12px, horizontal: 24px to maintain a substantial, clickable feel.

### Cards
All transaction and summary containers should use the Level 1 elevation shadow and an 8px corner radius. No borders are needed on white cards against the tertiary background.

### Input Fields
Fields should be minimalist: a 1px border of Slate Gray (30% opacity) that darkens on focus. Use Inter 14px for placeholder text. Labels sit above the field in `label-caps` style.

### Lists (Transactions)
Transaction items should be separated by a hairline divider (`#E2E8F0`) or simple white-space gaps. The merchant name is primary (Manrope 16px Bold) and the amount is right-aligned in `data-mono`.

### Chips & Tags
Used for categories (e.g., "Food", "Travel"). These should have a very light gray fill (`#F1F5F9`) and Slate Gray text. No borders. They should be small, keeping the focus on the primary transaction data.