#!/bin/bash

NERD_FONTS_VERSION=${NERD_FONTS_VERSION:-v2.2.1}
upstream_src_glyphs_url="https://github.com/ryanoasis/nerd-fonts/blob/${NERD_FONTS_VERSION}/src/glyphs"

glyphs=(
  "codicons/codicon.ttf"
  "font-awesome/FontAwesome.otf"
  "powerline-symbols/PowerlineSymbols.otf"
  "weather-icons/weathericons-regular-webfont.ttf"
  "devicons.ttf"
  "font-awesome-extension.ttf"
  "font-logos.ttf"
  "materialdesignicons-webfont.ttf"
  "NerdFontsSymbols 1000 EM Nerd Font Complete Blank.sfd"
  "NerdFontsSymbols 2048 EM Nerd Font Complete Blank.sfd"
  "octicons.ttf"
  "original-source.otf"
  "Pomicons.otf"
  "PowerlineExtraSymbols.otf"
  "Symbols-1000-em Nerd Font Complete.ttf"
  "Symbols-2048-em Nerd Font Complete.ttf"
  "Unicode_IEC_symbol_font.otf"
)

mkdir -p src/glyphs

for glyph in "${glyphs[@]}"; do
  # replace all `whitespace` characters with `%20`
  percent_encoded_uri="${upstream_src_glyphs_url}/${glyph//\ /%20}?raw=true"

  curl -fsSL ${percent_encoded_uri} --output "src/glyphs/${glyph}" --create-dirs
done
