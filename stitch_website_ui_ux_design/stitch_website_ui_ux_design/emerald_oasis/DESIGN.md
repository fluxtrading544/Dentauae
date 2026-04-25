# Design System Document: Clean Luxury & Accessible Wellness

## 1. Overview & Creative North Star: "The Clinical Atelier"
This design system is built on the philosophy of **The Clinical Atelier**. It rejects the sterile, cold atmosphere of traditional medical interfaces in favor of a high-end, editorial experience that feels both authoritative and restorative. 

We move beyond the "template" look by embracing **The Editorial Grid**—a layout strategy that utilizes intentional asymmetry, generous oversized margins (64px+), and overlapping elements. By letting serif display type breathe and layering containers with tonal depth rather than hard lines, we create a digital environment that mirrors the experience of a luxury wellness retreat.

---

## 2. Colors: Tonal Depth over Structural Lines
The palette is rooted in the calming stability of `primary` (#005440) and the warmth of `tertiary` (#6b3f00). 

### The "No-Line" Rule
To maintain a premium feel, **1px solid borders are prohibited for sectioning.** Boundaries between content blocks must be defined through:
*   **Background Shifts:** Transitioning from `surface` (#f9f9f7) to `surface-container-low` (#f4f4f2).
*   **Tonal Transitions:** A `primary-container` section resting against a `surface` background.

### Surface Hierarchy & Nesting
Treat the UI as physical layers of fine paper.
*   **Level 0 (Base):** `surface` or `background` for the main canvas.
*   **Level 1 (Sections):** `surface-container-low` for large content areas.
*   **Level 2 (Interaction):** `surface-container-lowest` (#ffffff) for cards and interactive modules to create a "lifted" feel.

### The "Glass & Gradient" Rule
For floating navigation or hero overlays, use **Glassmorphism**: 
*   Apply `surface` at 80% opacity with a `24px` backdrop-blur. 
*   **Signature Texture:** Use a subtle linear gradient (135°) from `primary` (#005440) to `primary-container` (#0f6e56) for high-impact CTAs to provide a velvet-like depth.

---

## 3. Typography: The Authority of Serif
We pair the intellectual heritage of Noto Serif (representing Cormorant Garamond) with the modern precision of Plus Jakarta Sans (representing DM Sans).

*   **Display & Headlines (`notoSerif`):** Used for storytelling and brand-led headers. The high contrast of the serif letterforms conveys "Luxury."
    *   *Rule:* Use `display-lg` for hero sections with -2% letter spacing to feel tight and custom.
*   **Body & UI (`plusJakartaSans`):** Used for functional clarity. 
    *   *Rule:* Use `body-lg` for patient instructions to ensure "Accessible Wellness." Keep line heights generous (1.6x) to reduce cognitive load.

---

## 4. Elevation & Depth: Tonal Layering
Traditional shadows and borders create visual "noise." We use **Atmospheric Depth**.

*   **The Layering Principle:** Depth is achieved by "stacking." Place a `surface-container-lowest` card on a `surface-container-low` background. This creates a natural, soft lift without a single pixel of shadow.
*   **Ambient Shadows:** When a shadow is required (e.g., a floating appointment picker), use an extra-diffused shadow: `Y: 8px, Blur: 32px, Color: on-surface (8% opacity)`.
*   **The "Ghost Border" Fallback:** If a border is necessary for accessibility, use the `outline-variant` token at **15% opacity**. This creates a "hairline" suggestion of a container rather than a box.
*   **Asymmetric Overlaps:** Break the grid by allowing images to bleed 24px into the neighboring section or overlap container edges.

---

## 5. Components: Refined Interaction

### Buttons
*   **Primary:** `primary` background, `on-primary` text. Soft `md` (0.75rem) corner radius. Use the signature gradient on hover.
*   **Secondary:** `outline` ghost style using the "Ghost Border" rule.
*   **Tertiary (Gold Accent):** Use `tertiary` (#6b3f00) text only with a `primary-fixed` hover state.

### Input Fields
*   **Style:** Minimalist. No background fill; only a bottom "Ghost Border" using `outline-variant`.
*   **Focus State:** The border transitions to `primary` (#005440) at 100% opacity with a subtle 2px soft-glow shadow.

### Cards & Lists
*   **Constraint:** Forbid divider lines. Use `16px` or `24px` of vertical white space to separate list items.
*   **Card Style:** `12px` (0.75rem) radius, `surface-container-lowest` fill. Use a `surface-container-high` background for the "Active" state.

### Specialty Component: The "Wellness Tracker"
*   A custom progress component using `primary-fixed-dim` for the track and `tertiary` (Warm Gold) for the progress indicator, signifying a "premium" achievement.

---

## 6. Do’s and Don’ts

### Do
*   **Do** use asymmetrical margins (e.g., 10% left, 20% right) to create an editorial feel.
*   **Do** use `display-lg` typography for single, impactful words or short phrases.
*   **Do** prioritize the `background` (#f9f9f7) color for the vast majority of the screen to maintain the "Clean" brand promise.

### Don’t
*   **Don’t** use pure black (#000000). Always use `on-surface` (#1a1c1b) for text.
*   **Don’t** use standard 1px borders to separate content; it looks "off-the-shelf."
*   **Don’t** crowd the interface. If a screen feels full, increase the white space by 20% before removing content.
*   **Don’t** use heavy "Drop Shadows." If a card doesn't pop via tonal layering, its placement needs rethinking, not a darker shadow.