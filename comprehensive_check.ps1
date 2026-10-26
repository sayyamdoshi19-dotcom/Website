# comprehensive_check.ps1
$files = @("index.html", "products.html", "collections.html", "bridal.html", "bridal-jewellery.html", "about.html", "about-us.html", "contact.html", "contact-us.html")

Write-Host "================== COMPREHENSIVE 10/10 AUDIT CHECK =================="

foreach ($file in $files) {
    if (Test-Path $file) {
        $text = [System.IO.File]::ReadAllText((Resolve-Path $file), [System.Text.Encoding]::UTF8)
        
        # 1. Title Check
        $title = "NOT FOUND"
        if ($text -match '<title>(.*?)</title>') { $title = $Matches[1] }
        
        # 2. Bell Character Check
        $bellCount = 0
        $bytes = [System.IO.File]::ReadAllBytes((Resolve-Path $file))
        foreach ($b in $bytes) { if ($b -eq 7) { $bellCount++ } }
        
        # 3. Garbled question-mark quote check
        $hasGarbled = $text.Contains('?"')

        # 4. Two <main> tags check
        $mMatches = [regex]::Matches($text, '<main[\s>]')
        $mainCount = $mMatches.Count

        # 5. Duplicate Google Font check
        $fontDup = $text.Contains('Material+Symbols+Outlined:wght,FILL')

        # 6. Meta Description & Keywords
        $hasMetaDesc = $text.Contains('<meta name="description"')
        $hasKeywords = $text.Contains('<meta name="keywords"')

        # 7. Canonical Tag
        $hasCanonical = $text.Contains('<link rel="canonical"')

        # 8. OpenGraph & Twitter
        $hasOG = $text.Contains('<meta property="og:title"') -and $text.Contains('<meta property="og:image"')
        $hasTwitter = $text.Contains('<meta name="twitter:card"')

        # 9. JSON-LD Schema (index.html)
        $hasSchema = $text.Contains('application/ld+json')

        # 10. Back to top button
        $hasBackToTop = $text.Contains('id="backToTopBtn"') -or $text.Contains('id="backToTop"')

        # 11. Scroll progress bar
        $hasScrollProgress = $text.Contains('id="scrollProgress"') -or $text.Contains('scroll-progress')

        # 12. Fake 18 category text
        $hasFake18 = $text.Contains('18 Haute Categories')

        # 13. Dead href=# count
        $rawHrefPound = [regex]::Matches($text, 'href="#"').Count

        Write-Host ""
        Write-Host "[$file]"
        Write-Host "  Title        : $title"
        Write-Host "  Bell \x07    : $bellCount (Must be 0)"
        Write-Host "  Garbled QMark: $hasGarbled (Must be False)"
        Write-Host "  Main Tags    : $mainCount (Must be 1)"
        Write-Host "  Font Dup     : $fontDup (Must be False)"
        Write-Host "  SEO Meta     : Desc=$hasMetaDesc, Canonical=$hasCanonical, OG=$hasOG, Twitter=$hasTwitter"
        Write-Host "  Back To Top  : $hasBackToTop"
        Write-Host "  ScrollProg   : $hasScrollProgress"
        Write-Host "  Fake 18 Count: $hasFake18 (Must be False)"
        Write-Host "  href=# count : $rawHrefPound"
        if ($file -eq "index.html") {
            Write-Host "  Schema.org   : $hasSchema (Must be True)"
        }
    }
}
