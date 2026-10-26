Add-Type -AssemblyName System.Drawing

$destDir = "c:\Users\Lenovo\OneDrive\Desktop\Website\assets\images"
$emblem = [System.Drawing.Bitmap]::FromFile("$destDir\princess_jewels_emblem_transparent.png")

# Rich Gold version for high-contrast on light ivory/white
$richGold = New-Object System.Drawing.Bitmap $emblem.Width, $emblem.Height, ([System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
for ($y = 0; $y -lt $emblem.Height; $y++) {
    for ($x = 0; $x -lt $emblem.Width; $x++) {
        $p = $emblem.GetPixel($x, $y)
        if ($p.A -gt 0) {
            # Map luminance to deep antique royal gold #775A1A (R=119, G=90, B=26)
            $lum = (0.299*$p.R + 0.587*$p.G + 0.114*$p.B) / 255.0
            $r = [int](130 * $lum + 30)
            $g = [int](98 * $lum + 20)
            $b = [int](28 * $lum + 8)
            $richGold.SetPixel($x, $y, [System.Drawing.Color]::FromArgb($p.A, $r, $g, $b))
        } else {
            $richGold.SetPixel($x, $y, [System.Drawing.Color]::FromArgb(0, 0, 0, 0))
        }
    }
}
$richGold.Save("$destDir\princess_jewels_emblem_richgold.png", [System.Drawing.Imaging.ImageFormat]::Png)
Write-Host "Created princess_jewels_emblem_richgold.png"

$emblem.Dispose()
$richGold.Dispose()
