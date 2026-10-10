# Photo Filter Research — Reference for Flutter Photo Editor App

Researched 2026-10-10 from public reviews, guides, and Adobe's own docs.
Goal: free, clean-UI photo editor with multiple filters — no ads, no paywalls.

---

## 1. VSCO (com.vsco.cam) — Presets

VSCO's signature is film-emulation presets. 10 "classic" presets are free; the rest are VSCO X (paid).
Naming convention: letter = series, number = variant.

### Analog / Aesthetic (A1–A10) — classic analog film
- **A4** — warm, moody film look; natural tones, subtle color shifts, slight fading. Highlights browns, whites, blues. Great for interiors, portraits, food.
- **A6** — the "clean & crisp" favorite; enhances brightness and contrast with a subtle film fade. All-purpose.
- General series look: faded blacks, muted highlights, warm midtones.

### Chromatic (C1–C9) — mid-century early color photography
- **C1** — dreamy, soft tones with increased warmth; cozy, inviting atmosphere.
- **C8** — strong primary colors mixed with muted neutrals; stylized editorial look.
- General: bright and bold, saturated reds/yellows/oranges against muted neutrals.

### Essence (E1–E8) — gilded age of consumer film
- **E2** — clean, bright edit with golden highlights.
- General: golden highlights, deep shadows, warm glow.

### Mellow / Fade (F1–F3) — all-purpose faded film
- **F2** — desaturated, understated elegance; beautiful natural skin tones.
- General: low saturation, lifted blacks, quiet everyday-moment look.

### Portrait (G4–G9)
- **G4** — cool portrait: natural skin tone + strong blue tone.
- **G5** — blue-toned, desaturated; keeps skin from looking dull.
- **G6** — neutral: brighter colors without unnaturally tan skin.
- **G7** — balanced, lessened color intensity; complements complexion.
- **G8** — warm portrait: sun-kissed skin, pop of color.
- **G9** — overall warm tone, subdued colors, radiant skin.

### Polychrome (H1–H6)
- **H1–H3 (Summer)** — subtle pink, yellow, purple hues; fashion/lifestyle.
- **H4–H6 (Winter)** — understated cool tones; dreamlike winter hues.

### Minimalist (J1–J6)
- All mute colors: brights become lighter (tint), darks become darker (shade); contrast retained.

### Analog Classic (K1–K3) — Kodachrome emulation
- Bright, poppy, bold classic film colors.

### Mood (M1–M6) — underexposed pack
- **M5** — balanced exposure/saturation; makes outdoor shots pop.
- General: slightly faded, underexposed; exaggerated browns and greens; nature/still life.

### New Modern (N1–N3)
- Modern bold aesthetic for flash/direct-sunlight shots.

### Instant (P1–P9) — instant film
- **P5** — warm, creamy overtones with pop; food/fashion/everyday life.

### Alchemy (Q1–Q10) — cross-processing
- **Q1** — dramatic color shifts, high contrast, rich vibrance balanced by refined tones.
- General: experimental chemical-develop look; lifestyle/stylized portraiture.

### Clean / Bright+Clean (S1–S6)
- Bright, splendid skin tones; portraits and light backgrounds.

### Street Style (SS1–SS3)
- **SS1 Vibrant Accents** — boosts strong colors, leaves skin/mild colors alone.
- **SS2 Muted Moments** — open-toned, minimal color palette.
- **SS3 In The Shadows** — thick shadows, natural unassuming colors.

### Valence (V1–V8)
- Low-contrast, gently muted, expanded tonal range; still-life/portraits/urban.

### Urban (U1–U6), Landscape (L1–L12), Artificial Light (AL1–AL6), Walk in the Sun (SUM/AGA/IND)
- Scene-specific: U5 Sunset (rich oranges/dynamic blues), U6 Darkness (deep blue night), AL1 LED Soften (corrects yellow/orange), AGA1 sun-dazed red/green surreal, IND1 blue dusk moods.

### VSCO adjustment tools
Exposure, Contrast, Saturation, Temperature, Tint, Skin Tone, Shadows, Highlights, Sharpen, Clarity, Grain, Vignette, Fade, Split Tone, HSL, Dodge & Burn, Borders, Crop/Straighten.

---

## 2. Adobe Lightroom Mobile (com.adobe.lrmobile) — Presets

Lightroom ships built-in preset groups; free tier includes the "Basics" group.
Taxonomy: Group › Subgroup › Preset name.

### Free built-in presets (Basics)
- **Basics › Creative › Vintage Instant** — warm retro film; mutes lightest tones, crisp details, diffused lighting.
- **Basics › Creative › Aged Photo** — warms tone, fades colors; literal aged-film look.
- **Basics › Creative › Warm Contrast** — earth tones (yellow/brown/tan) glow with inner warmth.
- **Basics › Creative › Flat & Green** — softened shadows, wash of cool pastel blue/green.
- **Basics › Color › Matte** — subdued saturation + high contrast; cinematic.
- **Basics › B&W › B&W Sepia** — yellow-brown vintage sepia tone.
- **Basics › B&W › Selenium Tone** — silvery-gray vintage tone.

### Premium presets (reference for style targets)
- **Premium › Auto+: Retro** — subdued highlights, unified tones, decades-old nostalgia.
- **Premium › Style: Vintage** — gritty vintage film effects, outdoor scenes.

### Popular free third-party preset styles (widely used, good targets)
- **Bright & Airy** — high exposure, desaturated warm tones, soft shadows, dreamlike.
- **Dark & Moody** — deep shadows, crushed blacks, high contrast, cinematic.
- **Teal & Orange (cinematic)** — teal shadows, warm orange skin tones, desaturated midtones.
- **Golden Hour** — warm golden tones mimicking sunset light.
- **Vintage Film** — grain, faded colors, slight light leaks, greenish shadows/yellowish highlights.

### Lightroom Mobile adjustment tools (free)
- **Light:** Exposure, Contrast, Highlights, Shadows, Whites, Blacks, Curves.
- **Color:** Temperature, Tint, Vibrance, Saturation, Color Mix (HSL per-channel).
- **Effects:** Texture, Clarity, Dehaze, Vignette, Grain.
- **Detail:** Sharpening, Noise Reduction.
- **Geometry:** Crop, Straighten, Rotate, Flip.
- Premium-only: Healing, Masking (selective AI), Geometry Upright.

---

## 3. Picsart (com.picsart.studio) — Filters & Effects

Picsart leans artistic/creative rather than photographic. Free tier has ads + limited tools; Gold unlocks all.

### Notable filters/effects (many free)
- **Sketch** — hand-drawn pencil look; auto-detects portrait outlines (5 variants).
- **Vintage** — nostalgic retro; mimics old film/vintage camera styles.
- **Glitch** — distorted, glitchy RGB-split; edgy futuristic.
- **Pop Art** — bold saturated colors; 1950s–60s pop-art poster look.
- **Prism** — colorful geometric prism pattern overlay; abstract.
- **Canvas** — turns portraits into painted canvas masterpieces.
- **Drip Art** — dripping-paint effect stickers with blend modes.
- **Magic effects** — cartoon/selfie stylization ("cartoon yourself").
- **Color Splash** — selective color: one area in color, rest B&W; dramatic.
- **Bokeh** — blurred out-of-focus background; dreamy romantic.
- **Motion** — motion-blur/energy effects simulating movement.
- **Lens Flare** — radiant burst of light simulating camera flare.
- **Cinematic HDR** — brightens brights, darkens darks; punchy realism.
- **Neon Glow** — neon light outlines/glow.
- **Cartoon FX** — cartoon stylization.
- **Golden Hour** — warm sunset glow filter.
- **Retro VHS / Y2K** — VHS tracking lines, Y2K digital-camera aesthetic.
- **Mirror** — symmetrical mirror effect.

### Picsart adjustment/editing tools
Crop, Stretch, Clone, Curves, HDR adjustment, Tilt-Shift (miniature/diorama), Blur, Background Remover (AI), Healing/Remove tool, Double Exposure (layers + transparency), Drawing tools, Text (100+ fonts), Stickers (60M+), Collage maker, Replay (re-apply community edit recipes).

---

## 4. Canva (com.canva.editor) — Filters

Canva's photo filters: 50+ one-tap filters with an **intensity slider** per filter. Exact proprietary names aren't published, but the filter set covers these styles:

### Filter styles (free)
- **Black & White / Mono** — clean grayscale conversion.
- **Noir** — high-contrast dramatic B&W.
- **Vintage / Sepia** — warm aged tones.
- **Warm / Summer / Golden** — warm sunny color cast.
- **Cool / Winter / Street** — cool blue/teal urban tones.
- **Cali** — bright California-style vivid look.
- **Epic** — punchy high-contrast vibrant.
- **Festive / Frente / Rosie / Lume / Candy** — stylized color-grade presets (pink, luminous, candy-bright variants).

### Effects (free)
- **Blur** — full or selective (brush) blur with intensity control.
- **Auto Focus** — blurs everything except a focus area; intensity + focus-position sliders.
- **Vignette** — darkened border to focus the subject.
- **Duotone** — two-color stylized look; customizable highlight/shadow colors.
- **Color Mix** — shifts overall color balance/grading.
- **Tint** — color overlay for mood/brand consistency.
- **Pixelate / Pixel Painting** — mosaic pixel effect.
- **Glitch / Photogenic effects** — artistic distortions (Color Pop, glitch).
- **BadTV** — Retro / Tube / Fuzz / VHS / Warp: TV-signal distortion with scanlines.
- **Blurred Glass / Fluted Glass** — frosted-glass distortion.
- **Image Dither** — retro dithered/halftone texture.
- **Colorize** — AI colorizes B&W photos.
- **Liquify** — subtle distort/exaggerate (Pro-leaning).

### Canva adjustment tools
Brightness, Contrast, Saturation, Highlights, Vibrance, Warmth, Tint, Sharpness, Curves, Fade, Blur, Vignette, Crop, Resize, Flip, Rotate, Transparency, Enhance (auto), Frames, Grids/Collage.

---

## Design takeaways for the Flutter app

1. **Filter implementation mapping** (all doable with color matrices / LUTs in Flutter):
   - B&W, Sepia, Noir → grayscale color matrix + contrast curve.
   - Vintage/Aged → warm overlay + lifted blacks (fade) + reduced saturation + grain.
   - Teal & Orange cinematic → split-tone shadows teal / highlights orange + desaturated mids.
   - Golden Hour → warm temperature shift + lifted shadows.
   - Bright & Airy → raised exposure + soft shadows + desaturated warm.
   - Dark & Moody → crushed blacks + high contrast + cool shadows.
   - Matte → subdued saturation + high contrast + lifted blacks.
   - Cross-process (Alchemy Q1) → channel curve swaps (e.g., green shadows, magenta highlights).
2. **Must-have adjustment tools** (common to all 4 apps): Exposure/Brightness, Contrast, Saturation, Temperature/Warmth, Tint, Highlights, Shadows, Sharpen, Vignette, Grain, Crop/Rotate/Straighten, Curves, HSL per-channel.
3. **Clean-UI differentiators**: intensity slider per filter (like Canva/VSCO), before/after hold-to-compare (Lightroom), no ads, all filters free.
4. **Skip for v1**: AI background removal, healing, stickers, collage, text overlays — Picsart/Canva territory, not core filter app.
