Add-Type -AssemblyName System.Drawing
$imgPath = "C:\Users\Lenovo\.gemini\antigravity\brain\0025325e-82ce-414b-8444-3be6d4d10f04\.user_uploaded\media_1792567985470_4542d6ff.jpg"
$bmp = [System.Drawing.Bitmap]::FromFile($imgPath)

# Sample rows from 540 to 660 to see row content densities
for ($y = 540; $y -le 660; $y += 5) {
    $count = 0
    for ($x = 170; $x -le 550; $x++) {
        $p = $bmp.GetPixel($x, $y)
        if ((0.299*$p.R + 0.587*$p.G + 0.114*$p.B) -gt 30) { $count++ }
    }
    Write-Host "Y=$y : $count non-black pixels"
}
$bmp.Dispose()
