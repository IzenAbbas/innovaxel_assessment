---
name: Innovaxel Finance
colors:
  surface: '#0b1326'
  surface-dim: '#0b1326'
  surface-bright: '#31394d'
  surface-container-lowest: '#060e20'
  surface-container-low: '#131b2e'
  surface-container: '#171f33'
  surface-container-high: '#222a3d'
  surface-container-highest: '#2d3449'
  on-surface: '#dae2fd'
  on-surface-variant: '#c3c5d9'
  inverse-surface: '#dae2fd'
  inverse-on-surface: '#283044'
  outline: '#8d90a2'
  outline-variant: '#434656'
  surface-tint: '#b7c4ff'
  primary: '#b7c4ff'
  on-primary: '#002682'
  primary-container: '#0052ff'
  on-primary-container: '#dfe3ff'
  inverse-primary: '#004ced'
  secondary: '#d3fbff'
  on-secondary: '#00363a'
  secondary-container: '#00eefc'
  on-secondary-container: '#00686f'
  tertiary: '#cfbdff'
  on-tertiary: '#3a0093'
  tertiary-container: '#7536f9'
  on-tertiary-container: '#ebe0ff'
  error: '#ffb4ab'
  on-error: '#690005'
  error-container: '#93000a'
  on-error-container: '#ffdad6'
  primary-fixed: '#dde1ff'
  primary-fixed-dim: '#b7c4ff'
  on-primary-fixed: '#001452'
  on-primary-fixed-variant: '#0038b6'
  secondary-fixed: '#7df4ff'
  secondary-fixed-dim: '#00dbe9'
  on-secondary-fixed: '#002022'
  on-secondary-fixed-variant: '#004f54'
  tertiary-fixed: '#e9ddff'
  tertiary-fixed-dim: '#cfbdff'
  on-tertiary-fixed: '#22005d'
  on-tertiary-fixed-variant: '#5300cc'
  background: '#0b1326'
  on-background: '#dae2fd'
  surface-variant: '#2d3449'
typography:
  headline-xl:
    fontFamily: Hanken Grotesk
    fontSize: 48px
    fontWeight: '700'
    lineHeight: 56px
    letterSpacing: -0.02em
  headline-lg:
    fontFamily: Hanken Grotesk
    fontSize: 32px
    fontWeight: '600'
    lineHeight: 40px
    letterSpacing: -0.01em
  headline-lg-mobile:
    fontFamily: Hanken Grotesk
    fontSize: 24px
    fontWeight: '600'
    lineHeight: 32px
  body-md:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  body-sm:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
  label-md:
    fontFamily: JetBrains Mono
    fontSize: 12px
    fontWeight: '500'
    lineHeight: 16px
    letterSpacing: 0.05em
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  base-unit: 4px
  gutter: 24px
  margin-mobile: 16px
  margin-desktop: 40px
  stack-sm: 8px
  stack-md: 16px
  stack-lg: 32px
---

## Brand & Style
This design system is built for a premium fintech environment where precision meets modern fluidity. The brand personality is authoritative yet innovative, aiming to evoke a sense of absolute security and forward-thinking intelligence.

The design style is **Corporate / Modern** with subtle **Glassmorphism** influences. It prioritizes a high-density information display that remains legible and calm. By combining structured grid layouts with soft translucent overlays, the interface balances the cold efficiency of finance with a human-centric, sophisticated digital experience.

## Colors
The palette is rooted in a deep, "Midnight" dark mode to reduce eye strain during long-form data analysis. 

- **Primary:** A vibrant "Electric Blue" used for primary actions and brand emphasis.
- **Secondary:** "Cyber Teal" for success states, trends, and data visualizations.
- **Tertiary:** "Deep Violet" for secondary accents and specialized interactive elements.
- **Neutral:** A range of slate grays and deep navies to provide structural depth and contrast without harsh blacks.

## Typography
The typographic scale is designed for clarity in data-heavy environments. **Hanken Grotesk** provides a sharp, contemporary edge for marketing and major headings. **Inter** is the workhorse for all body copy, ensuring maximum readability across varying screen densities. **JetBrains Mono** is reserved for tabular data, currency displays, and technical labels, providing the "developer-grade" precision expected in modern finance.

## Layout & Spacing
The layout follows a **Fixed Grid** model on desktop (1280px max-width) to maintain control over complex data tables. 

- **Desktop:** 12-column grid with 24px gutters and 40px side margins.
- **Tablet:** 8-column grid with 20px gutters.
- **Mobile:** 4-column fluid grid with 16px margins.

Spacing follows a strict 4px baseline rhythm. Components should use the `stack` variables for vertical rhythm to ensure consistent grouping of related financial data points.

## Elevation & Depth
Hierarchy is established through **Tonal Layers** and **Glassmorphism**. Instead of traditional drop shadows, this system uses:
1.  **Background (Level 0):** The base neutral hex.
2.  **Surface (Level 1):** A slightly lighter navy to define primary content areas.
3.  **Floating (Level 2):** Uses a backdrop blur (12px) and a 10% white border to simulate glass, reserved for modals and hovering navigation bars.
4.  **Interactive:** Subtle inner glows (1px primary color at 20% opacity) signal active states.

## Shapes
The shape language is **Rounded**, utilizing a 0.5rem (8px) base radius. This softens the "technical" feel of the dark mode and makes the application feel more approachable. 
- Large containers (cards) use `rounded-lg` (16px).
- Modals and primary action buttons use `rounded-xl` (24px) to stand out from the grid-based data rows.

## Components
- **Buttons:** Primary buttons use a solid primary hex with white text. Secondary buttons are "ghost" style with a 1px border and high-transparency fill.
- **Cards:** Defined by Level 1 Surface color with a subtle 1px border (`#FFFFFF` at 0.05 opacity).
- **Input Fields:** Use a dark, recessed background with a 1px slate border that glows primary blue on focus.
- **Chips/Badges:** Small, pill-shaped elements with low-opacity background tints of the secondary or tertiary colors for status categorization.
- **Data Tables:** Zebra-striping is avoided; instead, use thin 1px horizontal dividers and `label-md` for headers to emphasize the grid's precision.