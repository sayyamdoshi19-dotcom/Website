$pages = @("index.html","products.html","bridal.html","about.html","contact.html")
foreach ($p in $pages) {
    $c = [System.IO.File]::ReadAllText($p, [System.Text.Encoding]::UTF8)
    $hasMeta = ($c.IndexOf("name=`"description`"") -ge 0)
    $hasOg = ($c.IndexOf("property=`"og:") -ge 0)
    $hasLd = ($c.IndexOf("application/ld+json") -ge 0)
    $hasBell = ($c.IndexOf([char]7) -ge 0)
    $dupFonts = [System.Text.RegularExpressions.Regex]::Matches($c, "Material.Symbols.Outlined").Count
    Write-Host "$p : MetaDesc=$hasMeta | OG=$hasOg | JsonLd=$hasLd | BellChar=$hasBell | DupFont=$dupFonts"
}
