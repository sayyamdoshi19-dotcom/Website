$files = @("index.html", "products.html", "bridal.html", "about.html", "contact.html")
foreach ($f in $files) {
    Write-Host "================== $f =================="
    $lines = Get-Content $f
    for ($i = 0; $i -lt $lines.Count; $i++) {
        if ($lines[$i] -match 'href="#"') {
            $lineNum = $i + 1
            $text = $lines[$i].Trim()
            Write-Host "L$lineNum : $text"
        }
    }
}
