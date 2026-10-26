$allHtml = Get-ChildItem -Filter *.html
foreach ($h in $allHtml) {
    $text = [System.IO.File]::ReadAllText($h.FullName, [System.Text.Encoding]::UTF8)
    if ($text.Contains("Material+Symbols+Outlined:wght,FILL")) {
        Write-Host "FOUND DUPLICATE IN: $($h.Name)"
    }
}
Write-Host "Search complete."
