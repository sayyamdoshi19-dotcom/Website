# audit_all_links.ps1
$files = @("index.html", "products.html", "collections.html", "bridal.html", "bridal-jewellery.html", "about.html", "about-us.html", "contact.html", "contact-us.html")

Write-Host "================== AUDITING ALL LINKS FOR DEAD HREF =================="

foreach ($f in $files) {
    if (Test-Path $f) {
        $text = [System.IO.File]::ReadAllText((Resolve-Path $f), [System.Text.Encoding]::UTF8)
        
        # 1. Check for href="#"
        $deadMatches = [regex]::Matches($text, 'href="#"')
        
        # 2. Check for placeholder hashes
        $placeholderHashes = [regex]::Matches($text, 'href="#[a-zA-Z0-9_\-]*placeholder[a-zA-Z0-9_\-]*"')
        
        # 3. Check for fake 18 categories text
        $hasFake18 = $text.Contains("18 Haute Categories")
        
        Write-Host "`n[$f]"
        Write-Host "  href='#' count        : $($deadMatches.Count)"
        Write-Host "  #placeholder count    : $($placeholderHashes.Count)"
        Write-Host "  Fake '18 Categories'  : $hasFake18"

        if ($f -eq "index.html") {
            # Check 6 Category Cards in index.html
            $c1 = $text.Contains('href="products.html?category=necklaces"')
            $c2 = $text.Contains('href="bridal.html"')
            $c3 = $text.Contains('href="products.html?category=bangles"')
            $c4 = $text.Contains('href="products.html?category=earrings"')
            $c5 = $text.Contains('href="products.html?category=rings"')
            $c6 = $text.Contains('href="products.html?category=traditional"')
            $viewAll = $text.Contains('href="products.html"') -and $text.Contains('View All Collections')
            
            Write-Host "  Category 1 (Necklaces)  : $c1"
            Write-Host "  Category 2 (Bridal)     : $c2"
            Write-Host "  Category 3 (Bangles)    : $c3"
            Write-Host "  Category 4 (Earrings)   : $c4"
            Write-Host "  Category 5 (Rings)      : $c5"
            Write-Host "  Category 6 (Traditional): $c6"
            Write-Host "  View All Collections    : $viewAll"
        }

        # List any remaining href="#" or #placeholder
        if ($deadMatches.Count -gt 0 -or $placeholderHashes.Count -gt 0) {
            $lines = Get-Content (Resolve-Path $f)
            for ($i = 0; $i -lt $lines.Count; $i++) {
                if ($lines[$i] -match 'href="#"' -or $lines[$i] -match 'placeholder') {
                    Write-Host "    Line $($i+1): $($lines[$i].Trim())"
                }
            }
        }
    }
}
