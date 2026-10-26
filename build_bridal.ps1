$ErrorActionPreference = "Stop"

$root = $PSScriptRoot
if (-not $root) { $root = "." }

. "$root\build_all.ps1"

Write-Host "Building bridal.html..."
$bridalRaw = [System.IO.File]::ReadAllText("$root\stitch_source\stitch_princess_jewels_luxury_website\bridal_jewellery_princess_jewels\code.html", [System.Text.Encoding]::UTF8)
$bridalEnhanced = Enhance-PageContent $bridalRaw "bridal"

# Use uploaded bridal imagery in hero
$bridalEnhanced = $bridalEnhanced.Replace("url('https://lh3.googleusercontent.com/aida-public/AB6AXuAaNNyqr3CesOC6DZ-o_gOTxUxkE3VhE3JcD6oXIqkyAItmux0RXK71qqDOujNdEzU8o5Hmt1Yq7l1AvjKZkEAEftA2bj2Z2_4xCxjpyZC81a8K_-xaSDbmSnsTrRZeU3fve952DAv8aqw-eg5TKET4M_v4fl7YCrl-lREWX3IRpT1uM5BQ512GE-FP5peP9YGtTnBURii5DAeYPKdjHPefLGybWOq3X1gT4z2IkPH4YKcUU-xmtAtF')", "url('assets/images/uploaded_bridal_red.jpg')")

# Add direct WhatsApp bridal consultation button in Hero CTA cluster
$bridalHeroCtaOld = @'
<div class="flex flex-col sm:flex-row items-center gap-5 w-full sm:w-auto">
<a class="w-full sm:w-auto px-9 py-4 bg-primary-container text-on-primary-container font-label-lg text-label-lg uppercase tracking-[0.2em] shadow-lg hover:bg-primary-fixed hover:text-on-primary-fixed transition-all duration-300 text-center" href="#curations">
            Explore Bridal Collection
          </a>
<a class="w-full sm:w-auto px-8 py-4 bg-surface-container-lowest/10 backdrop-blur-md text-surface-bright font-label-lg text-label-lg uppercase tracking-[0.2em] hover:bg-surface-container-lowest hover:text-on-surface transition-all duration-300 text-center" href="#vip-consultation">
            Book Private Bridal Consultation
          </a>
</div>
'@

$bridalHeroCtaNew = @'
<div class="flex flex-col sm:flex-row items-center gap-4 w-full sm:w-auto">
  <a class="w-full sm:w-auto px-8 py-4 bg-primary-container text-on-primary-container font-label-lg text-label-lg uppercase tracking-[0.2em] shadow-lg hover:bg-primary-fixed hover:text-on-primary-fixed transition-all duration-300 text-center" href="#curations">
    Explore Bridal Collection
  </a>
  <a class="w-full sm:w-auto px-8 py-4 bg-surface-container-lowest/10 backdrop-blur-md text-surface-bright font-label-lg text-label-lg uppercase tracking-[0.2em] hover:bg-surface-container-lowest hover:text-on-surface transition-all duration-300 text-center border border-primary-container/40" href="#vip-consultation">
    Book Consultation
  </a>
  <a class="w-full sm:w-auto px-7 py-4 bg-[#2E7D32] hover:bg-[#1E4D2B] text-white font-label-lg text-label-lg uppercase tracking-[0.16em] transition-all duration-300 text-center flex items-center justify-center gap-2 shadow-lg" href="https://wa.me/919426557390?text=Hello%20PRINCESS%20JEWELS%2C%20I%20am%20interested%20in%20your%20bridal%20jewellery%20collection.%20Please%20share%20more%20details." target="_blank" rel="noopener noreferrer">
    <span class="material-symbols-outlined text-[20px]">chat</span>
    <span>WhatsApp Concierge</span>
  </a>
</div>
'@

$bridalEnhanced = $bridalEnhanced.Replace($bridalHeroCtaOld, $bridalHeroCtaNew)

# Save bridal.html and copy to bridal-jewellery.html
[System.IO.File]::WriteAllText("$root\bridal.html", $bridalEnhanced, [System.Text.Encoding]::UTF8)
[System.IO.File]::WriteAllText("$root\bridal-jewellery.html", $bridalEnhanced, [System.Text.Encoding]::UTF8)
Write-Host "bridal.html and bridal-jewellery.html generated successfully ($($bridalEnhanced.Length) bytes)"
