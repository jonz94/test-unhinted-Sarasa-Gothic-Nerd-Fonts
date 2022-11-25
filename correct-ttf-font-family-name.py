#! /usr/bin/python

# usage:
#   python correct-ttf-font-family-name.py filename.ttf

import sys

from fontTools.ttLib import TTFont


def main():
    filename = sys.argv[1]

    font = TTFont(filename, recalcBBoxes=False)
    fontName = font["name"]

    originalFontUniqueID = fontName.getName(3, 1, 0, 0).toUnicode()
    originalFontFullname = fontName.getName(4, 1, 0, 0).toUnicode()
    originalFontPreferredStyle = fontName.getName(17, 1, 0, 0).toUnicode()

    for entry in fontName.names:
        nameID = entry.nameID
        platformID = entry.platformID
        platEncID = entry.platEncID
        langID = entry.langID

        if langID in [1028, 1041, 2052, 3076]:
            newName = (
                entry.toUnicode()
                .replace(" CL", " CL unhinted Nerd Font")
                .replace(" TC", " TC unhinted Nerd Font")
                .replace(" J", " J unhinted Nerd Font")
                .replace(" SC", " SC unhinted Nerd Font")
                .replace(" HC", " HC unhinted Nerd Font")
            )
            fontName.setName(newName, nameID, platformID, platEncID, langID)

        elif nameID in [1, 16]:
            newName = originalFontUniqueID.replace(
                f" {originalFontPreferredStyle}", " unhinted Nerd Font"
            )
            fontName.setName(newName, nameID, platformID, platEncID, langID)

        elif nameID == 3:
            newName = originalFontUniqueID.replace(
                f" {originalFontPreferredStyle}",
                f" unhinted Nerd Font {originalFontPreferredStyle}",
            )
            fontName.setName(newName, nameID, platformID, platEncID, langID)

        elif nameID in [4, 6, 18]:
            newName = originalFontFullname.replace(
                " Nerd Font Complete",
                " unhinted Nerd Font Complete",
            )
            fontName.setName(
                newName, nameID, platformID, platEncID, langID
            )

    font.save(filename)
    font.close()


if __name__ == "__main__":
    main()
