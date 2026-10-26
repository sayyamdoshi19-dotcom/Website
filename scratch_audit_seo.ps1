$files = @('index.html', 'products.html', 'bridal.html', 'about.html', 'contact.html')
foreach ($f in $files) {
    $c = [System.IO.File]::ReadAllText($f, [System.Text.Encoding]::UTF8)
    $hasDesc = $c.IndexOf('name="description"') -ge 0
    $hasOg = $c.IndexOf('property="og:') -ge 0
    $hasJsonLd = $c.IndexOf('application/ld+json') -ge 0
    $hasCanonical = $c.IndexOf('rel="canonical"') -ge 0
    $titleMatch = [System.Text.RegularExpressions.Regex]::Match($c, '<title>(.*?)<\/title>')
    $title = if ($titleMatch.Success) { $titleMatch.Groups[1].Value } else { "NO TITLE" }
    Write-Host "$f => Title: $title"
    Write-Host "   Meta Desc: $hasDesc | OG: $hasOg | JSON-LD: $hasJsonLd | Canonical: $hasCanonical"
}
