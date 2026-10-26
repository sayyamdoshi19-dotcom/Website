$c = [System.IO.File]::ReadAllText("scratch_home.html", [System.Text.Encoding]::UTF8)
$deadLinks = [System.Text.RegularExpressions.Regex]::Matches($c, 'href="#"').Count
$externalImgs = [System.Text.RegularExpressions.Regex]::Matches($c, "googleusercontent").Count
$totalImgs = [System.Text.RegularExpressions.Regex]::Matches($c, "<img ").Count
$bgImgs = [System.Text.RegularExpressions.Regex]::Matches($c, "background-image").Count
$inlineStyle = [System.Text.RegularExpressions.Regex]::Matches($c, "style=").Count
$hasBellChars = $c.IndexOf([char]7) -ge 0
$duplicateFonts = [System.Text.RegularExpressions.Regex]::Matches($c, "Material.Symbols.Outlined").Count
$metaDesc = $c.IndexOf('name="description"') -ge 0
$hasOG = $c.IndexOf('property="og:') -ge 0
$hasJsonLd = $c.IndexOf("application/ld+json") -ge 0
$hasBYOPTitle = $c.Contains("View All 18 Haute")
$hasInstaLink = $c.Contains("instagram-placeholder")
$hasBackToTop = $c.Contains("back-to-top") -or $c.Contains("scroll_to_top")
$hasLoadMore = $c.Contains("load-more") -or $c.Contains("loadMore")

Write-Host "Dead hash links (href='#'): $deadLinks"
Write-Host "External Google CDN images: $externalImgs"
Write-Host "Total img tags: $totalImgs"
Write-Host "Background-image CSS usages: $bgImgs"
Write-Host "Inline style attrs: $inlineStyle"
Write-Host "Bell control chars in code: $hasBellChars"
Write-Host "Duplicate Material Symbols links: $duplicateFonts"
Write-Host "Has meta description: $metaDesc"
Write-Host "Has Open Graph tags: $hasOG"
Write-Host "Has JSON-LD schema: $hasJsonLd"
Write-Host "Fake count 'View All 18': $hasBYOPTitle"
Write-Host "Instagram is placeholder: $hasInstaLink"
Write-Host "Has back-to-top button: $hasBackToTop"
Write-Host "Has load-more button: $hasLoadMore"
