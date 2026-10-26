Add-Type -AssemblyName System.Drawing

$imagesPath = Join-Path $PSScriptRoot "assets\images"
$backupPath = Join-Path $imagesPath "originals_backup"
if (-not (Test-Path $backupPath)) {
    New-Item -ItemType Directory -Path $backupPath | Out-Null
}

$jpegCodec = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq "image/jpeg" }

# 1. Compress hero slides (Quality 76, preserving 1376x768 native dimensions)
$heroSlides = @("hero_slide_1.jpg", "hero_slide_2.jpg", "hero_slide_3.jpg")
foreach ($hero in $heroSlides) {
    $fullPath = Join-Path $imagesPath $hero
    $backupFile = Join-Path $backupPath $hero
    if (-not (Test-Path $backupFile)) {
        Copy-Item -Path $fullPath -Destination $backupFile
    }

    $sourceImg = [System.Drawing.Image]::FromFile($backupFile)
    $encoderParams = New-Object System.Drawing.Imaging.EncoderParameters(1)
    $encoderParams.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::Quality, [long]76)
    
    $tempFile = Join-Path $imagesPath ("temp_" + $hero)
    $sourceImg.Save($tempFile, $jpegCodec, $encoderParams)
    $sourceImg.Dispose()

    Move-Item -Path $tempFile -Destination $fullPath -Force
    $finalKb = [math]::Round((Get-Item $fullPath).Length / 1KB, 2)
    Write-Host "$hero compressed to $finalKb KB"
}

# 2. Compress uploaded_bridal_gold.jpg (High-quality bicubic 800x800, Quality 80)
$bridal = "uploaded_bridal_gold.jpg"
$bridalFullPath = Join-Path $imagesPath $bridal
$bridalBackup = Join-Path $backupPath $bridal
if (-not (Test-Path $bridalBackup)) {
    Copy-Item -Path $bridalFullPath -Destination $bridalBackup
}

$origBridal = [System.Drawing.Image]::FromFile($bridalBackup)
$bmp = New-Object System.Drawing.Bitmap(800, 800)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$g.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$g.DrawImage($origBridal, 0, 0, 800, 800)

$encoderParams = New-Object System.Drawing.Imaging.EncoderParameters(1)
$encoderParams.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::Quality, [long]80)

$bridalTemp = Join-Path $imagesPath ("temp_" + $bridal)
$bmp.Save($bridalTemp, $jpegCodec, $encoderParams)

$g.Dispose()
$bmp.Dispose()
$origBridal.Dispose()

Move-Item -Path $bridalTemp -Destination $bridalFullPath -Force
$bridalKb = [math]::Round((Get-Item $bridalFullPath).Length / 1KB, 2)
Write-Host "$bridal compressed to $bridalKb KB"

Write-Host "=== All Hero Images Compressed Successfully ==="
