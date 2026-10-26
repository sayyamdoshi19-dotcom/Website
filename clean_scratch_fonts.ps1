$files = @('indriya-demo.html','scratch_home.html','scratch_products.html')
foreach ($f in $files) {
    if (Test-Path $f) {
        $text = [System.IO.File]::ReadAllText((Resolve-Path $f), [System.Text.Encoding]::UTF8)
        $regex = '<link href="https:\/\/fonts\.googleapis\.com\/css2\?family=Material\+Symbols\+Outlined:wght,FILL@100\.\.700,0\.\.1&amp;display=swap" rel="stylesheet"\/>'
        $text = [System.Text.RegularExpressions.Regex]::Replace($text, $regex, '')
        [System.IO.File]::WriteAllText((Resolve-Path $f), $text, [System.Text.Encoding]::UTF8)
        Write-Host "Cleaned $f"
    }
}
