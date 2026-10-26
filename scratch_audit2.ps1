$c = [System.IO.File]::ReadAllText('scratch_home.html', [System.Text.Encoding]::UTF8)
$metaCnt = [System.Text.RegularExpressions.Regex]::Matches($c, '<meta name=').Count
$imgTotal = [System.Text.RegularExpressions.Regex]::Matches($c, '<img ').Count
$externalImgs = [System.Text.RegularExpressions.Regex]::Matches($c, 'lh3\.googleusercontent').Count
$deadAnchors = [System.Text.RegularExpressions.Regex]::Matches($c, 'href="#"').Count
$hasBellChar = $c -match [char]7
$hasMojibake = $c.Contains('â€"') -or $c.Contains('? ') 
$duplicateFonts = [System.Text.RegularExpressions.Regex]::Matches($c, 'Material.Symbols.Outlined').Count
$hasViewAll18 = $c.Contains('View All 18 Haute Categories')
$instagramPlaceholder = $c.Contains('#instagram-placeholder')

Write-Host "=== HOMEPAGE AUDIT RESULTS ==="
Write-Host "Meta description tags: $metaCnt"
Write-Host "Total img tags: $imgTotal"  
Write-Host "External Google CDN images: $externalImgs"
Write-Host "Dead hash-only links (href='#'): $deadAnchors"
Write-Host "Bell control char in text: $hasBellChar"
Write-Host "Duplicate font links (Material Symbols): $duplicateFonts"
Write-Host "Fake count 'View All 18' : $hasViewAll18"
Write-Host "Instagram placeholder (not linked): $instagramPlaceholder"

# Check for key missing sections
Write-Host ""
Write-Host "=== KEY SECTIONS ==="
Write-Host "Has Featured Products: $($c.Contains('FEATURED SIGNATURE CREATIONS'))"
Write-Host "Has Bestsellers: $($c.Contains('BESTSELLING'))"
Write-Host "Has Newsletter: $($c.Contains('Newsletter') -or $c.Contains('NEWSLETTER'))"
Write-Host "Has Contact WhatsApp: $($c.Contains('wa.me/919426557390'))"
Write-Host "Has Brand Story: $($c.Contains('Brand') -or $c.Contains('story'))"
Write-Host "Has scroll to top btn: $($c.Contains('scroll_to_top') -or $c.Contains('back-to-top'))"
Write-Host "Has loading spinner: $($c.Contains('loading') -or $c.Contains('spinner'))"
