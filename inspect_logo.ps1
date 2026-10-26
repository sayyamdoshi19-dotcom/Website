Add-Type -AssemblyName System.Drawing
$imgPath = "C:\Users\Lenovo\.gemini\antigravity\brain\0025325e-82ce-414b-8444-3be6d4d10f04\.user_uploaded\media_1792567985470_4542d6ff.jpg"
$bmp = [System.Drawing.Bitmap]::FromFile($imgPath)
Write-Host "Dimensions: $($bmp.Width) x $($bmp.Height)"

$corner = $bmp.GetPixel(10, 10)
Write-Host "Corner: R=$($corner.R), G=$($corner.G), B=$($corner.B)"

# Find bounding box of non-black pixels (luminance > 25)
$minX = $bmp.Width
$maxX = 0
$minY = $bmp.Height
$maxY = 0

for ($y = 0; $y -lt $bmp.Height; $y += 4) {
    for ($x = 0; $x -lt $bmp.Width; $x += 4) {
        $p = $bmp.GetPixel($x, $y)
        $lum = 0.299 * $p.R + 0.587 * $p.G + 0.114 * $p.B
        if ($lum -gt 25) {
            if ($x -lt $minX) { $minX = $x }
            if ($x -gt $maxX) { $maxX = $x }
            if ($y -lt $minY) { $minY = $y }
            if ($y -gt $maxY) { $maxY = $y }
        }
    }
}

Write-Host "Content bounds: X=$minX..$maxX, Y=$minY..$maxY"
$bmp.Dispose()
