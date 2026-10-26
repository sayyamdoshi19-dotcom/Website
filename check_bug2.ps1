$files = @(
    "index.html",
    "products.html",
    "collections.html",
    "bridal.html",
    "bridal-jewellery.html",
    "about.html",
    "about-us.html",
    "contact.html",
    "contact-us.html",
    "build_templates\topbar.html",
    "build_templates\footer.html",
    "build_templates\hero_slideshow.html",
    "build_templates\shared_drawers.html"
)

Write-Host "=== AUDITING BUG #2 FIXES ==="

foreach ($f in $files) {
    if (Test-Path $f) {
        $text = [System.IO.File]::ReadAllText((Resolve-Path $f), [System.Text.Encoding]::UTF8)
        $bytes = [System.IO.File]::ReadAllBytes((Resolve-Path $f))
        
        $hasBell = $bytes -contains 7
        $hasEntity = $text.Contains("&#7;") -or $text.Contains("&amp;#7;")
        
        Write-Host "`n[$f]"
        Write-Host "  Raw Bell (\x07) : $hasBell"
        Write-Host "  Entity (&#7;)  : $hasEntity"

        # Check key strings
        if ($text.Contains("THE ART OF GOLDEN ELEGANCE&nbsp;·&nbsp;BIS 916 Hallmarked Gold")) {
            Write-Host "  Footer Bottom  : MATCHED (&nbsp;·&nbsp;)"
        } elseif ($text.Contains("THE ART OF GOLDEN ELEGANCE")) {
            $m = [regex]::Match($text, 'THE ART OF GOLDEN ELEGANCE.{1,30}BIS 916')
            if ($m.Success) {
                Write-Host "  Footer Bottom  : MISMATCH -> '$($m.Value)'"
            }
        }

        if ($text.Contains("BIS 916 Hallmarked 22K Gold&nbsp;·&nbsp;White-Glove Insured Delivery")) {
            Write-Host "  Top Bar        : MATCHED (&nbsp;·&nbsp;)"
        } elseif ($text.Contains("White-Glove Insured Delivery")) {
            $m = [regex]::Match($text, 'BIS 916 Hallmarked 22K Gold.{1,30}White-Glove')
            if ($m.Success) {
                Write-Host "  Top Bar        : MISMATCH -> '$($m.Value)'"
            }
        }

        if ($text.Contains("Haute Joaillerie&nbsp;·&nbsp;Royal Indian Goldsmithing")) {
            Write-Host "  Hero Badge     : MATCHED (&nbsp;·&nbsp;)"
        } elseif ($text.Contains("Royal Indian Goldsmithing")) {
            $m = [regex]::Match($text, 'Haute Joaillerie.{1,30}Royal Indian Goldsmithing')
            if ($m.Success) {
                Write-Host "  Hero Badge     : MISMATCH -> '$($m.Value)'"
            }
        }

        # Categories (index.html)
        if ($f -eq "index.html") {
            $cats = @(
                "Chokers&nbsp;·&nbsp;Ranas",
                "Jhumkas&nbsp;·&nbsp;Chandbalis",
                "Filigree&nbsp;·&nbsp;Embossed",
                "Solitaires&nbsp;·&nbsp;Signets",
                "Temple&nbsp;·&nbsp;Polki Jadau"
            )
            foreach ($c in $cats) {
                $matched = $text.Contains($c)
                Write-Host "  Category $c : $matched"
            }
        }
    }
}
