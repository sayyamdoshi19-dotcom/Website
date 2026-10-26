Add-Type -AssemblyName System.Drawing
$imgPath = "C:\Users\Lenovo\.gemini\antigravity\brain\0025325e-82ce-414b-8444-3be6d4d10f04\.user_uploaded\media_1792567985470_4542d6ff.jpg"
$bmp = [System.Drawing.Bitmap]::FromFile($imgPath)

# Sample some gold pixels in the crown and text
$goldSamples = @()
for ($y = 280; $y -le 655; $y += 10) {
    for ($x = 180; $x -le 540; $x += 10) {
        $p = $bmp.GetPixel($x, $y)
        if ($p.R -gt 150 -and $p.G -gt 100) {
            $goldSamples += "$($p.R),$($p.G),$($p.B)"
        }
    }
}
Write-Host "Sampled $( $goldSamples.Count ) gold pixels."
$goldSamples | Select-Object -First 10 | ForEach-Object { Write-Host "RGB: $_" }
$bmp.Dispose()
