Add-Type -AssemblyName System.Web
$files = @('index.html', 'products.html', 'bridal.html', 'about.html', 'contact.html')
$root = "c:\Users\Lenovo\OneDrive\Desktop\Website"

foreach ($f in $files) {
    $c = [System.IO.File]::ReadAllText("$root\$f", [System.Text.Encoding]::UTF8)
    $imgMatches = [System.Text.RegularExpressions.Regex]::Matches($c, '<img[^>]+src=["''](.*?)["'']', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
    $bgMatches = [System.Text.RegularExpressions.Regex]::Matches($c, 'background-image:\s*url\((.*?)\)', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
    
    $localMissing = @()
    $remoteImgs = @()
    
    foreach ($m in $imgMatches) {
        $src = $m.Groups[1].Value.Trim("'", '"')
        if ($src.StartsWith('http')) {
            $remoteImgs += $src
        } else {
            $fullP = Join-Path $root $src.Replace('/', '\')
            if (-not (Test-Path $fullP)) {
                $localMissing += $src
            }
        }
    }
    foreach ($m in $bgMatches) {
        $src = $m.Groups[1].Value.Trim("'", '"')
        if ($src.StartsWith('http')) {
            $remoteImgs += $src
        } else {
            $fullP = Join-Path $root $src.Replace('/', '\')
            if (-not (Test-Path $fullP)) {
                $localMissing += $src
            }
        }
    }
    
    Write-Host "File $f : $($imgMatches.Count + $bgMatches.Count) total images"
    Write-Host "   Missing local files: $(($localMissing | Select-Object -Unique) -join ', ')"
    Write-Host "   External Google CDN URLs: $(($remoteImgs | Select-Object -Unique).Count)"
}
