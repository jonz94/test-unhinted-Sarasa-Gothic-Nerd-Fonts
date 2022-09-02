#!/bin/bash

NERD_FONTS_VERSION=${NERD_FONTS_VERSION:-v2.1.0}
upstream_src_glyphs_url="https://github.com/ryanoasis/nerd-fonts/blob/${NERD_FONTS_VERSION}/src/glyphs"
glyphs=(
  "FontAwesome.otf"
  "NerdFontsSymbols 1000 EM Nerd Font Complete Blank.sfd"
  "NerdFontsSymbols 2048 EM Nerd Font Complete Blank.sfd"
  "Pomicons.otf"
  "PowerlineExtraSymbols.otf"
  "PowerlineSymbols.otf"
  "Symbols Template 1000 em.ttf"
  "Symbols Template 2048 em.ttf"
  "Symbols-1000-em Nerd Font Complete.ttf"
  "Symbols-2048-em Nerd Font Complete.ttf"
  "Unicode_IEC_symbol_font.otf"
  "devicons.ttf"
  "font-awesome-extension.ttf"
  "font-logos.ttf"
  "materialdesignicons-webfont.ttf"
  "octicons.ttf"
  "original-source.otf"
  "weathericons-regular-webfont.ttf"
)

mkdir -p src/glyphs

for glyph in "${glyphs[@]}"; do
  # replace all `whitespace` characters with `%20`
  percent_encoded_uri="${upstream_src_glyphs_url}/${glyph//\ /%20}?raw=true"

  curl -fsSL ${percent_encoded_uri} --output "src/glyphs/${glyph}"
done
