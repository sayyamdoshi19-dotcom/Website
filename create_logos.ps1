Add-Type -AssemblyName System.Drawing

$sourcePath = "C:\Users\Lenovo\.gemini\antigravity\brain\0025325e-82ce-414b-8444-3be6d4d10f04\.user_uploaded\media_1792567985470_4542d6ff.jpg"
$destDir = "c:\Users\Lenovo\OneDrive\Desktop\Website\assets\images"

$src = [System.Drawing.Bitmap]::FromFile($sourcePath)

# Content bounds: X=172..548, Y=280..656
# Let's add slight padding:
# Full content: X=165..555 (width=390), Y=265..665 (height=400)
# Emblem only (Princess profile): X=240..480 (width=240), Y=265..590 (height=325)

# 1. GENERATE CROPPED ORIGINAL (Luxury Dark Full Logo)
$fullCropWidth = 555 - 165
$fullCropHeight = 665 - 265
$fullCrop = New-Object System.Drawing.Bitmap $fullCropWidth, $fullCropHeight, ([System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
$g1 = [System.Drawing.Graphics]::FromImage($fullCrop)
$g1.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$g1.DrawImage($src, 
    (New-Object System.Drawing.Rectangle 0, 0, $fullCropWidth, $fullCropHeight), 
    165, 265, $fullCropWidth, $fullCropHeight, 
    [System.Drawing.GraphicsUnit]::Pixel)
$g1.Dispose()
$fullCrop.Save("$destDir\princess_jewels_logo_dark.png", [System.Drawing.Imaging.ImageFormat]::Png)
Write-Host "Created princess_jewels_logo_dark.png ($($fullCropWidth)x$($fullCropHeight))"

# 2. GENERATE TRANSPARENT FULL LOGO (Gold on transparent)
$fullTransparent = New-Object System.Drawing.Bitmap $fullCropWidth, $fullCropHeight, ([System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
for ($y = 0; $y -lt $fullCropHeight; $y++) {
    for ($x = 0; $x -lt $fullCropWidth; $x++) {
        $p = $fullCrop.GetPixel($x, $y)
        $maxC = [Math]::Max($p.R, [Math]::Max($p.G, $p.B))
        if ($maxC -lt 18) {
            $fullTransparent.SetPixel($x, $y, [System.Drawing.Color]::FromArgb(0, 0, 0, 0))
        } else {
            # Compute alpha
            $alpha = [Math]::Min(255, [int](($maxC - 15) / 240.0 * 255.0))
            if ($alpha -lt 1) { $alpha = 1 }
            # Un-premultiply to preserve rich gold
            $factor = 255.0 / [Math]::Max($maxC, 30)
            $r = [Math]::Min(255, [int]($p.R * $factor))
            $g = [Math]::Min(255, [int]($p.G * $factor))
            $b = [Math]::Min(255, [int]($p.B * $factor))
            $fullTransparent.SetPixel($x, $y, [System.Drawing.Color]::FromArgb($alpha, $r, $g, $b))
        }
    }
}
$fullTransparent.Save("$destDir\princess_jewels_logo_transparent.png", [System.Drawing.Imaging.ImageFormat]::Png)
Write-Host "Created princess_jewels_logo_transparent.png"

# 3. GENERATE EMBLEM ONLY (Princess profile & tiara)
$emblemCropX = 240
$emblemCropY = 265
$emblemCropW = 240
$emblemCropH = 325

$emblemTransparent = New-Object System.Drawing.Bitmap $emblemCropW, $emblemCropH, ([System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
for ($y = 0; $y -lt $emblemCropH; $y++) {
    for ($x = 0; $x -lt $emblemCropW; $x++) {
        $p = $src.GetPixel($emblemCropX + $x, $emblemCropY + $y)
        $maxC = [Math]::Max($p.R, [Math]::Max($p.G, $p.B))
        if ($maxC -lt 18) {
            $emblemTransparent.SetPixel($x, $y, [System.Drawing.Color]::FromArgb(0, 0, 0, 0))
        } else {
            $alpha = [Math]::Min(255, [int](($maxC - 15) / 240.0 * 255.0))
            if ($alpha -lt 1) { $alpha = 1 }
            $factor = 255.0 / [Math]::Max($maxC, 30)
            $r = [Math]::Min(255, [int]($p.R * $factor))
            $g = [Math]::Min(255, [int]($p.G * $factor))
            $b = [Math]::Min(255, [int]($p.B * $factor))
            $emblemTransparent.SetPixel($x, $y, [System.Drawing.Color]::FromArgb($alpha, $r, $g, $b))
        }
    }
}
$emblemTransparent.Save("$destDir\princess_jewels_emblem_transparent.png", [System.Drawing.Imaging.ImageFormat]::Png)
Write-Host "Created princess_jewels_emblem_transparent.png"

# 4. GENERATE DEEP LUXURY MEDALLION EMBLEM (Circular royal medallion with gold border)
$medallionSize = 360
$medallion = New-Object System.Drawing.Bitmap $medallionSize, $medallionSize, ([System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
$gM = [System.Drawing.Graphics]::FromImage($medallion)
$gM.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$gM.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic

# Dark luxury background circle (rich midnight navy / onyx #141210)
$darkBrush = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(255, 20, 18, 16))
$gM.FillEllipse($darkBrush, 6, 6, ($medallionSize - 12), ($medallionSize - 12))

# Outer gold ring
$goldPenOuter = New-Object System.Drawing.Pen ([System.Drawing.Color]::FromArgb(255, 198, 161, 91)), 3
$gM.DrawEllipse($goldPenOuter, 6, 6, ($medallionSize - 12), ($medallionSize - 12))

# Inner delicate gold ring
$goldPenInner = New-Object System.Drawing.Pen ([System.Drawing.Color]::FromArgb(180, 225, 195, 125)), 1
$gM.DrawEllipse($goldPenInner, 12, 12, ($medallionSize - 24), ($medallionSize - 24))

# Draw the emblem in the center
$destRect = New-Object System.Drawing.Rectangle 70, 45, 220, 280
$gM.DrawImage($emblemTransparent, $destRect)

$gM.Dispose()
$medallion.Save("$destDir\princess_jewels_medallion.png", [System.Drawing.Imaging.ImageFormat]::Png)
Write-Host "Created princess_jewels_medallion.png"

$src.Dispose()
$fullCrop.Dispose()
$fullTransparent.Dispose()
$emblemTransparent.Dispose()
$medallion.Dispose()
