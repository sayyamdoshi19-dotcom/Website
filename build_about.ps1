$ErrorActionPreference = "Stop"

$root = $PSScriptRoot
if (-not $root) { $root = "." }

. "$root\build_all.ps1"

Write-Host "Building about.html..."
$aboutRaw = [System.IO.File]::ReadAllText("$root\stitch_source\stitch_princess_jewels_luxury_website\about_us_princess_jewels\code.html", [System.Text.Encoding]::UTF8)
$aboutEnhanced = Enhance-PageContent $aboutRaw "about"

# Replace any fake 1928 / foundation claims with honest, luxury craftsmanship
$aboutEnhanced = $aboutEnhanced.Replace('<span class="font-headline-md text-headline-md text-secondary block">1928</span>`n<span class="font-label-sm text-label-sm text-on-surface-variant uppercase tracking-wider block mt-1">Foundation Year</span>', '<span class="font-headline-sm text-headline-md text-secondary block">22KT</span><span class="font-label-sm text-label-sm text-on-surface-variant uppercase tracking-wider block mt-1">Sovereign Gold</span>')

$aboutEnhanced = $aboutEnhanced.Replace('Maison Heritage • Est. 1928', 'Royal Indian Goldsmithing • Sovereign Gold')
$aboutEnhanced = $aboutEnhanced.Replace('For nearly a century, our ateliers have been defined', 'Our ateliers are defined')

# Integrate user uploaded brand identity and packaging boxes into story visuals
$aboutEnhanced = $aboutEnhanced.Replace("src=`"https://lh3.googleusercontent.com/aida-public/AB6AXuAjqdU9psAVHC5x9SmMhA80P3zRHcstKludG2wtUZ-mecXquZhD-8pmpjFrEUC9OtqK2U48snQV7xQ1v8-0Jixo8ToqVpdX1lxiq3wukDORpvIxTc4rq5RygxmIgX8joZHf8nMdkKnwTZGuPkBKaVdu3F8Ts32ucL7lNX_Aw7lzGwX6S3NveMH4xlpijNoExCvkXbOHlBcJ5-mILNCWYfbi23-H0b8k5qEMEFPT24GilQg09BwF3tah`"", "src=`"assets/images/uploaded_packaging_boxes.jpg`"")

# Update Explore Collections button
$aboutEnhanced = $aboutEnhanced.Replace('href="#collections"', 'href="products.html"')
$aboutEnhanced = $aboutEnhanced.Replace('href="#explore"', 'href="products.html"')

# Save about.html and copy to about-us.html
[System.IO.File]::WriteAllText("$root\about.html", $aboutEnhanced, [System.Text.Encoding]::UTF8)
[System.IO.File]::WriteAllText("$root\about-us.html", $aboutEnhanced, [System.Text.Encoding]::UTF8)
Write-Host "about.html and about-us.html generated successfully ($($aboutEnhanced.Length) bytes)"
