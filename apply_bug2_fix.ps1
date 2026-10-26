# apply_bug2_fix.ps1
$ErrorActionPreference = "Stop"
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$dot = "&nbsp;$([char]0x00B7)&nbsp;"

$allFiles = @(
    "build_templates\topbar.html",
    "build_templates\footer.html",
    "build_templates\hero_slideshow.html",
    "build_templates\shared_drawers.html",
    "index.html",
    "products.html",
    "collections.html",
    "bridal.html",
    "bridal-jewellery.html",
    "about.html",
    "about-us.html",
    "contact.html",
    "contact-us.html"
)

Write-Host "Applying BUG #2 fix across all files..."

foreach ($file in $allFiles) {
    if (-not (Test-Path $file)) { continue }
    
    $rawBytes = [System.IO.File]::ReadAllBytes((Resolve-Path $file))
    $content = [System.Text.Encoding]::UTF8.GetString($rawBytes)

    # 1. Eradicate any literal ASCII 7 bell characters
    $content = $content.Replace([string][char]7, $dot)

    # 2. Eradicate any HTML entity &#7; or &amp;#7;
    $content = $content.Replace("&#7;", $dot)
    $content = $content.Replace("&amp;#7;", $dot)

    # 3. Fix Top Announcement Bar
    $content = [regex]::Replace($content, 'BIS 916 Hallmarked 22K Gold\s*(?:&nbsp;)?(?:[\x07•·\?]|&#7;|&middot;|&bull;)?(?:&nbsp;)?\s*White-Glove Insured Delivery', "BIS 916 Hallmarked 22K Gold${dot}White-Glove Insured Delivery")

    # 4. Fix Hero Badge
    $content = [regex]::Replace($content, 'Haute Joaillerie\s*(?:&nbsp;)?(?:[\x07•·\?]|&#7;|&middot;|&bull;)?(?:&nbsp;)?\s*Royal Indian Goldsmithing', "Haute Joaillerie${dot}Royal Indian Goldsmithing")

    # 5. Fix Footer Bottom
    $content = [regex]::Replace($content, 'THE ART OF GOLDEN ELEGANCE\s*(?:&nbsp;)?(?:[\x07•·\?]|&#7;|&middot;|&bull;)?(?:&nbsp;)?\s*BIS 916 Hallmarked Gold', "THE ART OF GOLDEN ELEGANCE${dot}BIS 916 Hallmarked Gold")

    # 6. Fix Drawer Subtotal note
    $content = [regex]::Replace($content, 'BIS 916 Hallmarked 22K Gold\s*(?:&nbsp;)?(?:[\x07•·\?]|&#7;|&middot;|&bull;)?(?:&nbsp;)?\s*Sample prices', "BIS 916 Hallmarked 22K Gold${dot}Sample prices")

    # 7. Fix Category Badges (Home & Shop)
    $content = [regex]::Replace($content, 'Chokers\s*(?:&nbsp;)?(?:[\x07•·\?]|&#7;|&middot;|&bull;)?(?:&nbsp;)?\s*Ranas', "Chokers${dot}Ranas")
    $content = [regex]::Replace($content, 'Jhumkas\s*(?:&nbsp;)?(?:[\x07•·\?]|&#7;|&middot;|&bull;)?(?:&nbsp;)?\s*Chandbalis', "Jhumkas${dot}Chandbalis")
    $content = [regex]::Replace($content, 'Filigree\s*(?:&nbsp;)?(?:[\x07•·\?]|&#7;|&middot;|&bull;)?(?:&nbsp;)?\s*Embossed', "Filigree${dot}Embossed")
    $content = [regex]::Replace($content, 'Solitaires\s*(?:&nbsp;)?(?:[\x07•·\?]|&#7;|&middot;|&bull;)?(?:&nbsp;)?\s*Signets', "Solitaires${dot}Signets")
    $content = [regex]::Replace($content, 'Temple\s*(?:&nbsp;)?(?:[\x07•·\?]|&#7;|&middot;|&bull;)?(?:&nbsp;)?\s*Polki Jadau', "Temple${dot}Polki Jadau")

    # 8. Fix Slideshow subtitle
    $content = [regex]::Replace($content, 'Continuous Slideshow\s*(?:&nbsp;)?(?:[\x07•·\?]|&#7;|&middot;|&bull;)?(?:&nbsp;)?\s*4\.5 Seconds', "Continuous Slideshow${dot}4.5 Seconds")

    # 9. Clean any doubled dots
    $content = $content.Replace("$dot$dot", $dot)

    [System.IO.File]::WriteAllText((Resolve-Path $file), $content, [System.Text.Encoding]::UTF8)
    Write-Host "  Updated $file successfully."
}

Write-Host "All files processed."
