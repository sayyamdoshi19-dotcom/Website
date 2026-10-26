# audit_og_tags.ps1
$files = @(
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

Write-Host "================== SOCIAL SHARE PREVIEW AUDIT =================="

foreach ($f in $files) {
    if (Test-Path $f) {
        $text = [System.IO.File]::ReadAllText((Resolve-Path $f), [System.Text.Encoding]::UTF8)
        
        $ogTitle = if ($text -match '<meta property="og:title" content="(.*?)"\s*\/?>') { $Matches[1] } else { "MISSING" }
        $ogDesc = if ($text -match '<meta property="og:description" content="(.*?)"\s*\/?>') { $Matches[1] } else { "MISSING" }
        $ogImg = if ($text -match '<meta property="og:image" content="(.*?)"\s*\/?>') { $Matches[1] } else { "MISSING" }
        $ogUrl = if ($text -match '<meta property="og:url" content="(.*?)"\s*\/?>') { $Matches[1] } else { "MISSING" }
        $ogType = if ($text -match '<meta property="og:type" content="(.*?)"\s*\/?>') { $Matches[1] } else { "MISSING" }
        $ogSite = if ($text -match '<meta property="og:site_name" content="(.*?)"\s*\/?>') { $Matches[1] } else { "MISSING" }
        $twCard = if ($text -match '<meta name="twitter:card" content="(.*?)"\s*\/?>') { $Matches[1] } else { "MISSING" }
        $twTitle = if ($text -match '<meta name="twitter:title" content="(.*?)"\s*\/?>') { $Matches[1] } else { "MISSING" }
        $twImg = if ($text -match '<meta name="twitter:image" content="(.*?)"\s*\/?>') { $Matches[1] } else { "MISSING" }
        
        Write-Host "`n[$f]"
        Write-Host "  og:title       : $ogTitle"
        Write-Host "  og:description : $ogDesc"
        Write-Host "  og:image       : $ogImg"
        Write-Host "  og:url         : $ogUrl"
        Write-Host "  og:type        : $ogType"
        Write-Host "  og:site_name   : $ogSite"
        Write-Host "  twitter:card   : $twCard"
        Write-Host "  twitter:title  : $twTitle"
        Write-Host "  twitter:image  : $twImg"
    }
}
