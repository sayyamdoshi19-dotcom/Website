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

Write-Host "================== CANONICAL TAGS AUDIT =================="

foreach ($f in $files) {
    if (Test-Path $f) {
        $text = [System.IO.File]::ReadAllText((Resolve-Path $f), [System.Text.Encoding]::UTF8)
        $m = [regex]::Match($text, '<link\s+rel="canonical"\s+href="(.*?)"\s*\/?>')
        if ($m.Success) {
            Write-Host "[$f] Canonical -> $($m.Groups[1].Value)"
        } else {
            Write-Host "[$f] Canonical -> MISSING!"
        }
    }
}
