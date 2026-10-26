$ErrorActionPreference = "Stop"

$root = $PSScriptRoot
if (-not $root) { $root = "." }

$topbar = [System.IO.File]::ReadAllText("$root\build_templates\topbar.html", [System.Text.Encoding]::UTF8)
$footer = [System.IO.File]::ReadAllText("$root\build_templates\footer.html", [System.Text.Encoding]::UTF8)
$sharedDrawers = [System.IO.File]::ReadAllText("$root\build_templates\shared_drawers.html", [System.Text.Encoding]::UTF8)
$heroSlideshow = [System.IO.File]::ReadAllText("$root\build_templates\hero_slideshow.html", [System.Text.Encoding]::UTF8)

function Clean-Text($str) {
    # Replace bell character \x07 and other control characters
    $str = $str -replace [char]7, " • "
    $str = $str -replace "• •", "•"
    # Clean broken dash mojibake
    $str = $str -replace "•\?", "•"
    $str = $str -replace "\?\s*22K", "— 22K"
    $str = $str -replace "â€\"", "—"
    $str = $str -replace "â€”", "—"
    $str = $str -replace "â€“", "–"
    $str = $str -replace "â‚¹", "₹"
    return $str
}

function Enhance-Base($html, $pageType) {
    # 1. Favicon in head
    $favicon = @'
<link rel="icon" type="image/png" href="assets/images/princess_jewels_medallion.png"/>
<link rel="apple-touch-icon" href="assets/images/princess_jewels_medallion.png"/>
'@
    $html = $html.Replace('<head>', "<head>`n$favicon")
    $html = $html.Replace('<link rel="stylesheet" href="assets/style.css"/>', '') # Clean any existing
    
    # 2. Page Specific Metadata & Unique Titles
    $headMeta = switch ($pageType) {
        "home" {
            @'
<title>PRINCESS JEWELS | Luxury 22K Gold Jewellery — The Art of Golden Elegance</title>
<meta name="description" content="Discover PRINCESS JEWELS — The Art of Golden Elegance. Bespoke 22K BIS 916 hallmarked gold bridal jewellery, royal necklace sets, and heirloom bangles crafted in India."/>
<meta name="keywords" content="gold jewellery, 22K gold, bridal jewellery, BIS 916, hallmarked gold, Indian wedding jewellery, gold necklace, jhumka, bangle, PRINCESS JEWELS"/>
<link rel="canonical" href="https://princessjewels.in/"/>
<meta property="og:title" content="PRINCESS JEWELS | Luxury 22K Gold Jewellery — The Art of Golden Elegance"/>
<meta property="og:description" content="Handcrafted 22K Royal Gold & Bridal Jewellery. BIS 916 Hallmarked. WhatsApp +91 94265 57390."/>
<meta property="og:image" content="https://princessjewels.in/assets/images/princess_jewels_logo_dark.png"/>
<meta property="og:url" content="https://princessjewels.in/"/>
<meta property="og:type" content="website"/>
<meta property="og:site_name" content="PRINCESS JEWELS"/>
<meta name="twitter:card" content="summary_large_image"/>
<meta name="twitter:title" content="PRINCESS JEWELS | Luxury 22K Gold Jewellery — The Art of Golden Elegance"/>
<meta name="twitter:description" content="Handcrafted 22K Royal Gold & Bridal Jewellery. BIS 916 Hallmarked. WhatsApp +91 94265 57390."/>
<meta name="twitter:image" content="https://princessjewels.in/assets/images/princess_jewels_logo_dark.png"/>
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "JewelryStore",
  "name": "PRINCESS JEWELS",
  "alternateName": "Princess Jewels",
  "description": "Luxury handcrafted 22K BIS 916 hallmarked gold jewellery — bridal sets, necklaces, earrings, bangles and rings.",
  "url": "https://princessjewels.in/",
  "logo": "https://princessjewels.in/assets/images/princess_jewels_logo_dark.png",
  "image": "https://princessjewels.in/assets/images/uploaded_bridal_gold.jpg",
  "telephone": "+919426557390",
  "email": "parshwaexport108@gmail.com",
  "priceRange": "₹₹₹₹",
  "currenciesAccepted": "INR",
  "paymentAccepted": "Cash, UPI, Bank Transfer, Credit Card",
  "slogan": "THE ART OF GOLDEN ELEGANCE"
}
</script>
<link rel="stylesheet" href="assets/style.css"/>
'@
        }
        "collections" {
            @'
<title>Collections | PRINCESS JEWELS — 22K Hallmarked Gold Jewellery</title>
<meta name="description" content="Shop certified 22K hallmarked gold jewellery at PRINCESS JEWELS. Necklaces, earrings, bangles, rings and traditional temple jewellery. BIS 916 guaranteed purity."/>
<link rel="canonical" href="https://princessjewels.in/products.html"/>
<meta property="og:title" content="Collections | PRINCESS JEWELS — 22K Hallmarked Gold Jewellery"/>
<meta property="og:description" content="Shop certified 22K hallmarked gold necklaces, earrings, bangles, rings, and traditional temple jewellery."/>
<meta property="og:image" content="https://princessjewels.in/assets/images/necklace.jpg"/>
<meta property="og:url" content="https://princessjewels.in/products.html"/>
<meta property="og:type" content="website"/>
<meta property="og:site_name" content="PRINCESS JEWELS"/>
<meta name="twitter:card" content="summary_large_image"/>
<meta name="twitter:title" content="Collections | PRINCESS JEWELS — 22K Hallmarked Gold Jewellery"/>
<meta name="twitter:description" content="Shop certified 22K hallmarked gold jewellery at PRINCESS JEWELS."/>
<meta name="twitter:image" content="https://princessjewels.in/assets/images/necklace.jpg"/>
<link rel="stylesheet" href="assets/style.css"/>
'@
        }
        "bridal" {
            @'
<title>Bridal Jewellery | PRINCESS JEWELS — Royal Indian Wedding Collections</title>
<meta name="description" content="Royal bridal jewellery collections at PRINCESS JEWELS. Chokers, haars, kadas, chandbalis and complete trousseau suites. Private bridal consultation available. Call +91 94265 57390."/>
<link rel="canonical" href="https://princessjewels.in/bridal.html"/>
<meta property="og:title" content="Bridal Jewellery | PRINCESS JEWELS — Royal Indian Wedding Collections"/>
<meta property="og:description" content="Royal Indian wedding jewellery collections. Handcrafted 22K gold chokers, layered haars, kadas, and trousseau suites."/>
<meta property="og:image" content="https://princessjewels.in/assets/images/uploaded_bridal_red.jpg"/>
<meta property="og:url" content="https://princessjewels.in/bridal.html"/>
<meta property="og:type" content="website"/>
<meta property="og:site_name" content="PRINCESS JEWELS"/>
<meta name="twitter:card" content="summary_large_image"/>
<meta name="twitter:title" content="Bridal Jewellery | PRINCESS JEWELS — Royal Indian Wedding Collections"/>
<meta name="twitter:description" content="Royal bridal jewellery collections at PRINCESS JEWELS."/>
<meta name="twitter:image" content="https://princessjewels.in/assets/images/uploaded_bridal_red.jpg"/>
<link rel="stylesheet" href="assets/style.css"/>
'@
        }
        "about" {
            @'
<title>About Us | PRINCESS JEWELS — The Art of Golden Elegance</title>
<meta name="description" content="About PRINCESS JEWELS — The Art of Golden Elegance. Generational master karigars crafting BIS 916 hallmarked 22K gold heirloom jewellery."/>
<link rel="canonical" href="https://princessjewels.in/about.html"/>
<meta property="og:title" content="About Us | PRINCESS JEWELS — The Art of Golden Elegance"/>
<meta property="og:description" content="Generational master karigars crafting BIS 916 hallmarked 22K gold heirloom jewellery."/>
<meta property="og:image" content="https://princessjewels.in/assets/images/uploaded_packaging_boxes.jpg"/>
<meta property="og:url" content="https://princessjewels.in/about.html"/>
<meta property="og:type" content="website"/>
<meta property="og:site_name" content="PRINCESS JEWELS"/>
<meta name="twitter:card" content="summary_large_image"/>
<meta name="twitter:title" content="About Us | PRINCESS JEWELS — The Art of Golden Elegance"/>
<meta name="twitter:description" content="About PRINCESS JEWELS — The Art of Golden Elegance."/>
<meta name="twitter:image" content="https://princessjewels.in/assets/images/uploaded_packaging_boxes.jpg"/>
<link rel="stylesheet" href="assets/style.css"/>
'@
        }
        "contact" {
            @'
<title>Contact | PRINCESS JEWELS — Royal Gold Jewellery Concierge</title>
<meta name="description" content="Contact PRINCESS JEWELS. Phone: +91 94265 57390. Email: parshwaexport108@gmail.com. WhatsApp enquiry available. Book a private bridal jewellery consultation."/>
<link rel="canonical" href="https://princessjewels.in/contact.html"/>
<meta property="og:title" content="Contact | PRINCESS JEWELS — Royal Gold Jewellery Concierge"/>
<meta property="og:description" content="Contact PRINCESS JEWELS. Direct Telephone +91 94265 57390, WhatsApp Concierge, and Private Bridal Appointments."/>
<meta property="og:image" content="https://princessjewels.in/assets/images/princess_jewels_logo_dark.png"/>
<meta property="og:url" content="https://princessjewels.in/contact.html"/>
<meta property="og:type" content="website"/>
<meta property="og:site_name" content="PRINCESS JEWELS"/>
<meta name="twitter:card" content="summary_large_image"/>
<meta name="twitter:title" content="Contact | PRINCESS JEWELS — Royal Gold Jewellery Concierge"/>
<meta name="twitter:description" content="Contact PRINCESS JEWELS. Phone: +91 94265 57390. Email: parshwaexport108@gmail.com."/>
<meta name="twitter:image" content="https://princessjewels.in/assets/images/princess_jewels_logo_dark.png"/>
<link rel="stylesheet" href="assets/style.css"/>
'@
        }
    }

    # Replace old title tag with comprehensive metadata block
    $oldTitleRegex = '<title>.*?<\/title>'
    $html = [System.Text.RegularExpressions.Regex]::Replace($html, $oldTitleRegex, $headMeta, [System.Text.RegularExpressions.RegexOptions]::Singleline)

    # 3. Remove duplicate Material Symbols font link
    $duplicateFontRegex = '<link href="https:\/\/fonts\.googleapis\.com\/css2\?family=Material\+Symbols\+Outlined:wght,FILL@100\.\.700,0\.\.1&amp;display=swap" rel="stylesheet"\/>'
    $html = [System.Text.RegularExpressions.Regex]::Replace($html, $duplicateFontRegex, '', [System.Text.RegularExpressions.RegexOptions]::Singleline)

    # 4. Standard Brand & Path replacements
    $html = $html.Replace('data-path="home" href="#"', 'href="index.html"')
    $html = $html.Replace('princess JEWELS', 'PRINCESS JEWELS')
    $html = $html.Replace('The Art of Golden Elegance', 'THE ART OF GOLDEN ELEGANCE')

    # 5. Header Brand Logo Lockup with Royal Medallion
    $headerBrandRegex = '<a class="flex items-center gap-3.*?THE ART OF GOLDEN ELEGANCE<\/span><\/div><\/a>'
    $headerBrandHtml = @'
<a class="flex items-center gap-3.5 group" href="index.html">
  <div class="relative w-11 h-11 md:w-12 md:h-12 rounded-full p-0.5 bg-gradient-to-tr from-[#914852] via-[#c6a15b] to-[#ffdea5] shadow-md group-hover:scale-105 transition-transform duration-300 shrink-0">
    <img alt="PRINCESS JEWELS Royal Emblem" class="w-full h-full object-cover rounded-full bg-[#141210]" src="assets/images/princess_jewels_medallion.png"/>
  </div>
  <div class="flex flex-col">
    <span class="font-headline-sm text-base md:text-title-lg text-secondary tracking-[0.18em] uppercase font-bold leading-none">PRINCESS JEWELS</span>
    <span class="font-label-sm text-[8px] md:text-[9px] tracking-[0.28em] text-primary uppercase mt-1 leading-none font-medium">THE ART OF GOLDEN ELEGANCE</span>
  </div>
</a>
'@
    $html = [System.Text.RegularExpressions.Regex]::Replace($html, $headerBrandRegex, $headerBrandHtml, [System.Text.RegularExpressions.RegexOptions]::Singleline)

    # 6. Replace Top announcement bar
    $html = [System.Text.RegularExpressions.Regex]::Replace($html, '<div class="w-full bg-secondary text-surface-bright py-1.5.*?Concierge<\/span><\/a><\/div><\/div><\/div>', $topbar, [System.Text.RegularExpressions.RegexOptions]::Singleline)

    # 7. Navigation bar
    $navRegex = '<nav class="hidden lg:flex.*?<\/nav>'
    $navHtml = switch ($pageType) {
        "home" {
            '<nav class="hidden lg:flex items-center gap-8 xl:gap-10"><a aria-current="page" class="tracking-[0.16em] uppercase transition-colors py-1 text-primary font-semibold border-b border-primary-container pb-1" href="index.html">Home</a><a class="font-label-lg text-label-lg tracking-[0.16em] uppercase text-on-surface-variant hover:text-primary transition-colors py-1" href="products.html">Collections</a><a class="font-label-lg text-label-lg tracking-[0.16em] uppercase text-on-surface-variant hover:text-primary transition-colors py-1" href="bridal.html">Bridal Jewellery</a><a class="font-label-lg text-label-lg tracking-[0.16em] uppercase text-on-surface-variant hover:text-primary transition-colors py-1" href="about.html">About Us</a><a class="font-label-lg text-label-lg tracking-[0.16em] uppercase text-on-surface-variant hover:text-primary transition-colors py-1" href="contact.html">Contact Us</a></nav>'
        }
        "collections" {
            '<nav class="hidden lg:flex items-center gap-8 xl:gap-10"><a class="font-label-lg text-label-lg tracking-[0.16em] uppercase text-on-surface-variant hover:text-primary transition-colors py-1" href="index.html">Home</a><a aria-current="page" class="tracking-[0.16em] uppercase transition-colors py-1 text-primary font-semibold border-b border-primary-container pb-1" href="products.html">Collections</a><a class="font-label-lg text-label-lg tracking-[0.16em] uppercase text-on-surface-variant hover:text-primary transition-colors py-1" href="bridal.html">Bridal Jewellery</a><a class="font-label-lg text-label-lg tracking-[0.16em] uppercase text-on-surface-variant hover:text-primary transition-colors py-1" href="about.html">About Us</a><a class="font-label-lg text-label-lg tracking-[0.16em] uppercase text-on-surface-variant hover:text-primary transition-colors py-1" href="contact.html">Contact Us</a></nav>'
        }
        "bridal" {
            '<nav class="hidden lg:flex items-center gap-8 xl:gap-10"><a class="font-label-lg text-label-lg tracking-[0.16em] uppercase text-on-surface-variant hover:text-primary transition-colors py-1" href="index.html">Home</a><a class="font-label-lg text-label-lg tracking-[0.16em] uppercase text-on-surface-variant hover:text-primary transition-colors py-1" href="products.html">Collections</a><a aria-current="page" class="tracking-[0.16em] uppercase transition-colors py-1 text-primary font-semibold border-b border-primary-container pb-1" href="bridal.html">Bridal Jewellery</a><a class="font-label-lg text-label-lg tracking-[0.16em] uppercase text-on-surface-variant hover:text-primary transition-colors py-1" href="about.html">About Us</a><a class="font-label-lg text-label-lg tracking-[0.16em] uppercase text-on-surface-variant hover:text-primary transition-colors py-1" href="contact.html">Contact Us</a></nav>'
        }
        "about" {
            '<nav class="hidden lg:flex items-center gap-8 xl:gap-10"><a class="font-label-lg text-label-lg tracking-[0.16em] uppercase text-on-surface-variant hover:text-primary transition-colors py-1" href="index.html">Home</a><a class="font-label-lg text-label-lg tracking-[0.16em] uppercase text-on-surface-variant hover:text-primary transition-colors py-1" href="products.html">Collections</a><a class="font-label-lg text-label-lg tracking-[0.16em] uppercase text-on-surface-variant hover:text-primary transition-colors py-1" href="bridal.html">Bridal Jewellery</a><a aria-current="page" class="tracking-[0.16em] uppercase transition-colors py-1 text-primary font-semibold border-b border-primary-container pb-1" href="about.html">About Us</a><a class="font-label-lg text-label-lg tracking-[0.16em] uppercase text-on-surface-variant hover:text-primary transition-colors py-1" href="contact.html">Contact Us</a></nav>'
        }
        "contact" {
            '<nav class="hidden lg:flex items-center gap-8 xl:gap-10"><a class="font-label-lg text-label-lg tracking-[0.16em] uppercase text-on-surface-variant hover:text-primary transition-colors py-1" href="index.html">Home</a><a class="font-label-lg text-label-lg tracking-[0.16em] uppercase text-on-surface-variant hover:text-primary transition-colors py-1" href="products.html">Collections</a><a class="font-label-lg text-label-lg tracking-[0.16em] uppercase text-on-surface-variant hover:text-primary transition-colors py-1" href="bridal.html">Bridal Jewellery</a><a class="font-label-lg text-label-lg tracking-[0.16em] uppercase text-on-surface-variant hover:text-primary transition-colors py-1" href="about.html">About Us</a><a aria-current="page" class="tracking-[0.16em] uppercase transition-colors py-1 text-primary font-semibold border-b border-primary-container pb-1" href="contact.html">Contact Us</a></nav>'
        }
    }
    $html = [System.Text.RegularExpressions.Regex]::Replace($html, $navRegex, $navHtml, [System.Text.RegularExpressions.RegexOptions]::Singleline)

    # 8. Action Icons
    $actionsRegex = '<div class="flex items-center gap-3 sm:gap-4.*?expand_more<\/span><\/div><\/div>'
    $newActions = '<div class="flex items-center gap-2 sm:gap-4 shrink-0"><button aria-label="Search Catalogue" data-action="open-search" class="p-2 text-on-surface-variant hover:text-primary transition-colors flex items-center" type="button"><span class="material-symbols-outlined text-[22px]">search</span></button><button aria-label="Wishlist" data-action="open-wishlist" class="relative p-2 text-on-surface-variant hover:text-primary transition-colors flex items-center" type="button"><span class="material-symbols-outlined text-[22px]">favorite</span><span class="wishlist-count-badge absolute top-1 right-0.5 bg-secondary text-on-secondary font-label-sm text-[9px] w-4 h-4 rounded-full flex items-center justify-center leading-none">3</span></button><button aria-label="Shopping Bag" data-action="open-cart" class="relative p-2 text-on-surface-variant hover:text-primary transition-colors flex items-center" type="button"><span class="material-symbols-outlined text-[22px]">shopping_bag</span><span class="cart-count-badge absolute top-1 right-0.5 bg-primary-container text-on-primary-container font-label-sm text-[9px] w-4 h-4 rounded-full flex items-center justify-center leading-none font-bold">1</span></button><div class="h-5 w-px bg-outline-variant/40 hidden sm:block"></div><button id="mobileMenuToggle" aria-label="Open Mobile Menu" class="lg:hidden p-2 text-on-surface hover:text-primary transition-colors flex items-center" type="button"><span class="material-symbols-outlined text-[26px]">menu</span></button></div>'
    $html = [System.Text.RegularExpressions.Regex]::Replace($html, $actionsRegex, $newActions, [System.Text.RegularExpressions.RegexOptions]::Singleline)

    # 9. Replace Footer
    $footerRegex = '<footer class="w-full bg-inverse-surface.*?<\/footer>'
    $html = [System.Text.RegularExpressions.Regex]::Replace($html, $footerRegex, $footer, [System.Text.RegularExpressions.RegexOptions]::Singleline)

    # 10. Append Drawers and JS before </body>
    $html = [System.Text.RegularExpressions.Regex]::Replace($html, '<\/body>\s*<\/html>', $sharedDrawers, [System.Text.RegularExpressions.RegexOptions]::Singleline)

    # Clean fictitious claims
    $html = $html.Replace('Maison Fondée 1928', 'Royal Indian Goldsmithing')
    $html = $html.Replace('Maison Heritage • Est. 1928', 'Royal Heritage • Pure Gold Artistry')
    $html = $html.Replace('Haute Bridal Joaillerie • Anno 1928', 'Haute Bridal Joaillerie • Royal Indian Craft')
    $html = $html.Replace('since 1928', 'with enduring devotion')
    $html = $html.Replace('1928', 'Pure')
    $html = $html.Replace('97+ Years of Royal Patronage', 'Generations of Royal Karigar Heritage')
    $html = $html.Replace('96 Years of Artistry', 'Generations of Artistry')

    $html = Clean-Text $html
    return $html
}

# ==========================================
# 1. BUILD index.html
# ==========================================
Write-Host "Building index.html..."
$homeRaw = [System.IO.File]::ReadAllText("$root\stitch_source\stitch_princess_jewels_luxury_website\home_princess_jewels\code.html", [System.Text.Encoding]::UTF8)
$homeEnhanced = Enhance-Base $homeRaw "home"

# Replace hero with slideshow
$oldHeroRegex = '<!-- 1\. CINEMATIC HERO SECTION -->.*?<!-- TRUST BADGES ROW -->'
$homeEnhanced = [System.Text.RegularExpressions.Regex]::Replace($homeEnhanced, $oldHeroRegex, ($heroSlideshow + "`n<!-- TRUST BADGES ROW -->"), [System.Text.RegularExpressions.RegexOptions]::Singleline)

# Connect 6 Category Cards to real product filter pages
$homeEnhanced = $homeEnhanced.Replace('href="#all-categories"', 'href="products.html"')
$homeEnhanced = $homeEnhanced.Replace('<span>View All 18 Haute Categories</span>', '<span>View All Collections</span>')

$catReplacements = @{
    '<!-- 1. Gold Necklaces -->`n<a class="group relative flex flex-col bg-surface-container-lowest overflow-hidden shadow-sm hover:shadow-xl transition-all duration-500" href="#">' = '<!-- 1. Gold Necklaces -->`n<a class="group relative flex flex-col bg-surface-container-lowest overflow-hidden shadow-sm hover:shadow-xl transition-all duration-500" href="products.html?category=necklaces">'
    '<!-- 2. Bridal Jewellery -->`n<a class="group relative flex flex-col bg-surface-container-lowest overflow-hidden shadow-sm hover:shadow-xl transition-all duration-500" href="#">' = '<!-- 2. Bridal Jewellery -->`n<a class="group relative flex flex-col bg-surface-container-lowest overflow-hidden shadow-sm hover:shadow-xl transition-all duration-500" href="bridal.html">'
    '<!-- 3. Gold Bangles & Kadas -->`n<a class="group relative flex flex-col bg-surface-container-lowest overflow-hidden shadow-sm hover:shadow-xl transition-all duration-500" href="#">' = '<!-- 3. Gold Bangles & Kadas -->`n<a class="group relative flex flex-col bg-surface-container-lowest overflow-hidden shadow-sm hover:shadow-xl transition-all duration-500" href="products.html?category=bangles">'
    '<!-- 4. Earrings -->`n<a class="group relative flex flex-col bg-surface-container-lowest overflow-hidden shadow-sm hover:shadow-xl transition-all duration-500" href="#">' = '<!-- 4. Earrings -->`n<a class="group relative flex flex-col bg-surface-container-lowest overflow-hidden shadow-sm hover:shadow-xl transition-all duration-500" href="products.html?category=earrings">'
    '<!-- 5. Gold Rings -->`n<a class="group relative flex flex-col bg-surface-container-lowest overflow-hidden shadow-sm hover:shadow-xl transition-all duration-500" href="#">' = '<!-- 5. Gold Rings -->`n<a class="group relative flex flex-col bg-surface-container-lowest overflow-hidden shadow-sm hover:shadow-xl transition-all duration-500" href="products.html?category=rings">'
    '<!-- 6. Traditional Jewellery -->`n<a class="group relative flex flex-col bg-surface-container-lowest overflow-hidden shadow-sm hover:shadow-xl transition-all duration-500" href="#">' = '<!-- 6. Traditional Jewellery -->`n<a class="group relative flex flex-col bg-surface-container-lowest overflow-hidden shadow-sm hover:shadow-xl transition-all duration-500" href="products.html?category=traditional">'
}

foreach ($key in $catReplacements.Keys) {
    $homeEnhanced = $homeEnhanced.Replace($key, $catReplacements[$key])
}

# Update testimonials note
$sampleNotice = '<div class="text-center max-w-3xl mx-auto mb-16 space-y-3"><span class="font-label-sm text-label-sm uppercase tracking-[0.26em] text-primary">Voices of the Royal Patrons</span><h2 class="font-headline-lg text-headline-lg text-on-surface">Heirlooms Revered Worldwide</h2><p class="font-body-md text-body-md text-on-surface-variant font-light">Patron experiences celebrating sacred milestones. <span class="italic text-xs text-primary block mt-1">(Clearly identified sample patron testimonials for illustration until verified)</span></p></div>'
$homeEnhanced = [System.Text.RegularExpressions.Regex]::Replace($homeEnhanced, '<div class="text-center max-w-3xl mx-auto mb-16 space-y-3">.*?Heirlooms Revered Worldwide.*?<\/div>', $sampleNotice, [System.Text.RegularExpressions.RegexOptions]::Singleline)

$homeEnhanced = Clean-Text $homeEnhanced
[System.IO.File]::WriteAllText("$root\index.html", $homeEnhanced, [System.Text.Encoding]::UTF8)
Write-Host "index.html built successfully."

# ==========================================
# 2. BUILD products.html & collections.html
# ==========================================
Write-Host "Building products.html..."
$colRaw = [System.IO.File]::ReadAllText("$root\stitch_source\stitch_princess_jewels_luxury_website\collections_princess_jewels\code.html", [System.Text.Encoding]::UTF8)
$colEnhanced = Enhance-Base $colRaw "collections"

# Fix BUG #4: Double <main> tag by replacing inner <main> with <div>
$colEnhanced = $colEnhanced.Replace('<main class="lg:col-span-9 space-y-10">', '<div class="lg:col-span-9 space-y-10">')
$colEnhanced = $colEnhanced.Replace('</main>`n</div>`n</div>`n</div>`n</section>', '</div>`n</div>`n</div>`n</div>`n</section>')

# Update category sidebar buttons to use data-category-filter
$oldCategoryList = @'
<ul class="space-y-2 font-body-md text-body-md text-on-surface-variant">
<li>
<button class="w-full text-left flex items-center justify-between font-semibold text-primary py-1">
<span>All Curations</span>
<span class="font-label-sm text-label-sm text-tertiary">24</span>
</button>
</li>
<li>
<button class="w-full text-left flex items-center justify-between hover:text-primary py-1 transition-colors">
<span>Necklaces &amp; Chokers</span>
<span class="font-label-sm text-label-sm text-tertiary">9</span>
</button>
</li>
<li>
<button class="w-full text-left flex items-center justify-between hover:text-primary py-1 transition-colors">
<span>Bangles &amp; Kadas</span>
<span class="font-label-sm text-label-sm text-tertiary">6</span>
</button>
</li>
<li>
<button class="w-full text-left flex items-center justify-between hover:text-primary py-1 transition-colors">
<span>Bridal Suites</span>
<span class="font-label-sm text-label-sm text-tertiary">4</span>
</button>
</li>
<li>
<button class="w-full text-left flex items-center justify-between hover:text-primary py-1 transition-colors">
<span>Earrings &amp; Chandbalis</span>
<span class="font-label-sm text-label-sm text-tertiary">3</span>
</button>
</li>
<li>
<button class="w-full text-left flex items-center justify-between hover:text-primary py-1 transition-colors">
<span>Heritage Rings</span>
<span class="font-label-sm text-label-sm text-tertiary">2</span>
</button>
</li>
'@

$newCategoryList = @'
<ul class="space-y-1.5 font-body-md text-body-md text-on-surface-variant">
<li>
<button data-category-filter="all" class="w-full text-left flex items-center justify-between font-semibold text-primary py-1 px-2 rounded hover:bg-surface-container transition-colors">
<span>All Creations</span>
<span class="font-label-sm text-label-sm text-tertiary">9</span>
</button>
</li>
<li>
<button data-category-filter="necklaces" class="w-full text-left flex items-center justify-between hover:text-primary py-1 px-2 rounded hover:bg-surface-container transition-colors">
<span>Gold Necklaces</span>
<span class="font-label-sm text-label-sm text-tertiary">2</span>
</button>
</li>
<li>
<button data-category-filter="bridal" class="w-full text-left flex items-center justify-between hover:text-primary py-1 px-2 rounded hover:bg-surface-container transition-colors">
<span>Bridal Jewellery</span>
<span class="font-label-sm text-label-sm text-tertiary">2</span>
</button>
</li>
<li>
<button data-category-filter="earrings" class="w-full text-left flex items-center justify-between hover:text-primary py-1 px-2 rounded hover:bg-surface-container transition-colors">
<span>Earrings &amp; Chandbalis</span>
<span class="font-label-sm text-label-sm text-tertiary">1</span>
</button>
</li>
<li>
<button data-category-filter="bangles" class="w-full text-left flex items-center justify-between hover:text-primary py-1 px-2 rounded hover:bg-surface-container transition-colors">
<span>Bangles &amp; Kadas</span>
<span class="font-label-sm text-label-sm text-tertiary">1</span>
</button>
</li>
<li>
<button data-category-filter="rings" class="w-full text-left flex items-center justify-between hover:text-primary py-1 px-2 rounded hover:bg-surface-container transition-colors">
<span>Gold Rings</span>
<span class="font-label-sm text-label-sm text-tertiary">1</span>
</button>
</li>
<li>
<button data-category-filter="traditional" class="w-full text-left flex items-center justify-between hover:text-primary py-1 px-2 rounded hover:bg-surface-container transition-colors">
<span>Traditional Jewellery</span>
<span class="font-label-sm text-label-sm text-tertiary">2</span>
</button>
</li>
<li>
<button data-category-filter="contemporary" class="w-full text-left flex items-center justify-between hover:text-primary py-1 px-2 rounded hover:bg-surface-container transition-colors">
<span>Contemporary Fine</span>
<span class="font-label-sm text-label-sm text-tertiary">1</span>
</button>
</li>
'@

$colEnhanced = $colEnhanced.Replace($oldCategoryList, $newCategoryList)

# Price filter update
$oldPriceList = @'
<div class="space-y-3 font-body-md text-body-md text-on-surface-variant">
<label class="flex items-center gap-3 cursor-pointer">
<input checked="" class="w-4 h-4 rounded border-outline-variant text-primary focus:ring-primary" type="checkbox"/>
<span>All Ranges</span>
</label>
<label class="flex items-center gap-3 cursor-pointer">
<input class="w-4 h-4 rounded border-outline-variant text-primary focus:ring-primary" type="checkbox"/>
<span>Under ₹1,00,000</span>
</label>
<label class="flex items-center gap-3 cursor-pointer">
<input class="w-4 h-4 rounded border-outline-variant text-primary focus:ring-primary" type="checkbox"/>
<span>₹1,00,000 – ₹2,50,000</span>
</label>
<label class="flex items-center gap-3 cursor-pointer">
<input class="w-4 h-4 rounded border-outline-variant text-primary focus:ring-primary" type="checkbox"/>
<span>₹2,50,000 – ₹5,00,000</span>
</label>
<label class="flex items-center gap-3 cursor-pointer">
<input class="w-4 h-4 rounded border-outline-variant text-primary focus:ring-primary" type="checkbox"/>
<span>Above ₹5,00,000</span>
</label>
</div>
'@

$newPriceList = @'
<div class="space-y-3 font-body-md text-body-md text-on-surface-variant">
<label class="flex items-center gap-3 cursor-pointer">
<input data-price-filter="all" checked class="w-4 h-4 rounded border-outline-variant text-primary focus:ring-primary" type="checkbox" value="all"/>
<span>All Ranges</span>
</label>
<label class="flex items-center gap-3 cursor-pointer">
<input data-price-filter="under-100k" class="w-4 h-4 rounded border-outline-variant text-primary focus:ring-primary" type="checkbox" value="under-100k"/>
<span>Under ₹1,00,000</span>
</label>
<label class="flex items-center gap-3 cursor-pointer">
<input data-price-filter="100k-250k" class="w-4 h-4 rounded border-outline-variant text-primary focus:ring-primary" type="checkbox" value="100k-250k"/>
<span>₹1,00,000 – ₹2,50,000</span>
</label>
<label class="flex items-center gap-3 cursor-pointer">
<input data-price-filter="250k-500k" class="w-4 h-4 rounded border-outline-variant text-primary focus:ring-primary" type="checkbox" value="250k-500k"/>
<span>₹2,50,000 – ₹5,00,000</span>
</label>
<label class="flex items-center gap-3 cursor-pointer">
<input data-price-filter="above-500k" class="w-4 h-4 rounded border-outline-variant text-primary focus:ring-primary" type="checkbox" value="above-500k"/>
<span>Above ₹5,00,000</span>
</label>
</div>
'@

$colEnhanced = $colEnhanced.Replace($oldPriceList, $newPriceList)
$colEnhanced = $colEnhanced.Replace('Reset Filters', 'Reset Filters" id="resetFiltersBtn')

# Sort Header
$sortingHtml = @'
<div class="flex flex-col sm:flex-row sm:items-center justify-between pb-6 border-b border-surface-container-high gap-4">
  <div class="flex items-center gap-3">
    <span class="font-label-sm text-xs uppercase tracking-wider text-on-surface font-semibold">Sort Collections:</span>
    <select id="catalogSortSelect" class="bg-surface-container-low text-on-surface text-xs font-body-sm py-2 px-3 rounded border-0 focus:ring-1 focus:ring-primary-container cursor-pointer shadow-sm">
      <option value="popularity">Curator Selection</option>
      <option value="price-low">Price: Low to High</option>
      <option value="price-high">Price: High to Low</option>
    </select>
  </div>
  <div class="flex items-center gap-2 text-xs font-label-sm text-primary uppercase tracking-widest">
    <span class="material-symbols-outlined text-[16px] text-primary">verified</span>
    <span>100% Certified 22K &amp; 18K Hallmarked</span>
  </div>
</div>
'@

$colEnhanced = $colEnhanced.Replace('<div class="grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-3 gap-6 sm:gap-7">', ($sortingHtml + "`n" + '<div id="productsGridContainer" class="grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-3 gap-6 sm:gap-7">'))
$colEnhanced = $colEnhanced.Replace('<p class="font-body-sm text-body-sm text-tertiary">Showing 9 of 24 pieces</p>', '<p id="filteredCountDisplay" class="font-body-sm text-body-sm text-tertiary font-medium">Showing curated creations</p><p class="text-xs text-on-surface-variant/70 italic mt-1">* Clearly identified sample products &amp; prices until verified inventory is provided.</p>')

# Add data attributes and WhatsApp buttons to products
$colEnhanced = $colEnhanced.Replace('<!-- Product Card 1 -->`n<article class="group bg-surface-container-lowest', '<!-- Product Card 1 -->`n<article data-product-category="necklaces" data-product-price="420000" class="group bg-surface-container-lowest')
$colEnhanced = $colEnhanced.Replace('<!-- Product Card 2 -->`n<article class="group bg-surface-container-lowest', '<!-- Product Card 2 -->`n<article data-product-category="bangles" data-product-price="340000" class="group bg-surface-container-lowest')
$colEnhanced = $colEnhanced.Replace('<!-- Product Card 3 -->`n<article class="group bg-surface-container-lowest', '<!-- Product Card 3 -->`n<article data-product-category="bridal" data-product-price="680000" class="group bg-surface-container-lowest')
$colEnhanced = $colEnhanced.Replace('<!-- Product Card 4 -->`n<article class="group bg-surface-container-lowest', '<!-- Product Card 4 -->`n<article data-product-category="earrings" data-product-price="145000" class="group bg-surface-container-lowest')
$colEnhanced = $colEnhanced.Replace('<!-- Product Card 5 -->`n<article class="group bg-surface-container-lowest', '<!-- Product Card 5 -->`n<article data-product-category="rings" data-product-price="95000" class="group bg-surface-container-lowest')
$colEnhanced = $colEnhanced.Replace('<!-- Product Card 6 -->`n<article class="group bg-surface-container-lowest', '<!-- Product Card 6 -->`n<article data-product-category="bridal" data-product-price="550000" class="group bg-surface-container-lowest')
$colEnhanced = $colEnhanced.Replace('<!-- Product Card 7 -->`n<article class="group bg-surface-container-lowest', '<!-- Product Card 7 -->`n<article data-product-category="contemporary" data-product-price="185000" class="group bg-surface-container-lowest')
$colEnhanced = $colEnhanced.Replace('<!-- Product Card 8 -->`n<article class="group bg-surface-container-lowest', '<!-- Product Card 8 -->`n<article data-product-category="traditional" data-product-price="210000" class="group bg-surface-container-lowest')
$colEnhanced = $colEnhanced.Replace('<!-- Product Card 9 -->`n<article class="group bg-surface-container-lowest', '<!-- Product Card 9 -->`n<article data-product-category="traditional" data-product-price="395000" class="group bg-surface-container-lowest')

$colEnhanced = Clean-Text $colEnhanced
[System.IO.File]::WriteAllText("$root\products.html", $colEnhanced, [System.Text.Encoding]::UTF8)
[System.IO.File]::WriteAllText("$root\collections.html", $colEnhanced, [System.Text.Encoding]::UTF8)
Write-Host "products.html and collections.html built successfully."

# ==========================================
# 3. BUILD bridal.html & bridal-jewellery.html
# ==========================================
Write-Host "Building bridal.html..."
$bridalRaw = [System.IO.File]::ReadAllText("$root\stitch_source\stitch_princess_jewels_luxury_website\bridal_jewellery_princess_jewels\code.html", [System.Text.Encoding]::UTF8)
$bridalEnhanced = Enhance-Base $bridalRaw "bridal"

# Use uploaded bridal image in hero
$bridalEnhanced = $bridalEnhanced.Replace("url('https://lh3.googleusercontent.com/aida-public/AB6AXuAaNNyqr3CesOC6DZ-o_gOTxUxkE3VhE3JcD6oXIqkyAItmux0RXK71qqDOujNdEzU8o5Hmt1Yq7l1AvjKZkEAEftA2bj2Z2_4xCxjpyZC81a8K_-xaSDbmSnsTrRZeU3fve952DAv8aqw-eg5TKET4M_v4fl7YCrl-lREWX3IRpT1uM5BQ512GE-FP5peP9YGtTnBURii5DAeYPKdjHPefLGybWOq3X1gT4z2IkPH4YKcUU-xmtAtF')", "url('assets/images/uploaded_bridal_red.jpg')")

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
$bridalEnhanced = Clean-Text $bridalEnhanced

[System.IO.File]::WriteAllText("$root\bridal.html", $bridalEnhanced, [System.Text.Encoding]::UTF8)
[System.IO.File]::WriteAllText("$root\bridal-jewellery.html", $bridalEnhanced, [System.Text.Encoding]::UTF8)
Write-Host "bridal.html and bridal-jewellery.html built successfully."

# ==========================================
# 4. BUILD about.html & about-us.html
# ==========================================
Write-Host "Building about.html..."
$aboutRaw = [System.IO.File]::ReadAllText("$root\stitch_source\stitch_princess_jewels_luxury_website\about_us_princess_jewels\code.html", [System.Text.Encoding]::UTF8)
$aboutEnhanced = Enhance-Base $aboutRaw "about"

$aboutEnhanced = $aboutEnhanced.Replace('<span class="font-headline-md text-headline-md text-secondary block">1928</span>`n<span class="font-label-sm text-label-sm text-on-surface-variant uppercase tracking-wider block mt-1">Foundation Year</span>', '<span class="font-headline-sm text-headline-md text-secondary block">22KT</span><span class="font-label-sm text-label-sm text-on-surface-variant uppercase tracking-wider block mt-1">Sovereign Gold</span>')
$aboutEnhanced = $aboutEnhanced.Replace('Maison Heritage • Est. 1928', 'Royal Indian Goldsmithing • Sovereign Gold')
$aboutEnhanced = $aboutEnhanced.Replace('For nearly a century, our ateliers have been defined', 'Our ateliers are defined')

# Integrate user uploaded brand identity and packaging
$aboutEnhanced = $aboutEnhanced.Replace("src=`"https://lh3.googleusercontent.com/aida-public/AB6AXuAjqdU9psAVHC5x9SmMhA80P3zRHcstKludG2wtUZ-mecXquZhD-8pmpjFrEUC9OtqK2U48snQV7xQ1v8-0Jixo8ToqVpdX1lxiq3wukDORpvIxTc4rq5RygxmIgX8joZHf8nMdkKnwTZGuPkBKaVdu3F8Ts32ucL7lNX_Aw7lzGwX6S3NveMH4xlpijNoExCvkXbOHlBcJ5-mILNCWYfbi23-H0b8k5qEMEFPT24GilQg09BwF3tah`"", "src=`"assets/images/uploaded_packaging_boxes.jpg`"")

$aboutEnhanced = $aboutEnhanced.Replace('href="#collections"', 'href="products.html"')
$aboutEnhanced = $aboutEnhanced.Replace('href="#explore"', 'href="products.html"')
$aboutEnhanced = Clean-Text $aboutEnhanced

[System.IO.File]::WriteAllText("$root\about.html", $aboutEnhanced, [System.Text.Encoding]::UTF8)
[System.IO.File]::WriteAllText("$root\about-us.html", $aboutEnhanced, [System.Text.Encoding]::UTF8)
Write-Host "about.html and about-us.html built successfully."

# ==========================================
# 5. BUILD contact.html & contact-us.html
# ==========================================
Write-Host "Building contact.html..."
$contactRaw = [System.IO.File]::ReadAllText("$root\stitch_source\stitch_princess_jewels_luxury_website\contact_us_princess_jewels\code.html", [System.Text.Encoding]::UTF8)
$contactEnhanced = Enhance-Base $contactRaw "contact"

# Form replacement with all 10 requested options and budget range
$newFormHtml = @'
<form class="space-y-6" id="enquiryForm" novalidate>
  <!-- 1. Full Name & Email Address -->
  <div class="grid grid-cols-1 sm:grid-cols-2 gap-6">
    <div class="space-y-1.5">
      <label class="block font-label-md text-label-md uppercase text-on-surface-variant tracking-wider" for="fullName">
        Full Name <span class="text-secondary font-bold">*</span>
      </label>
      <input class="w-full bg-surface-container-low text-on-surface px-4 py-3 rounded text-body-md placeholder:text-outline-variant/70 focus:outline-none focus:bg-surface-container-lowest focus:ring-1 focus:ring-primary shadow-inner transition-colors" id="fullName" name="fullName" placeholder="e.g. Radhika Sharma" required type="text"/>
    </div>
    <div class="space-y-1.5">
      <label class="block font-label-md text-label-md uppercase text-on-surface-variant tracking-wider" for="emailAddress">
        Email Address <span class="text-secondary font-bold">*</span>
      </label>
      <input class="w-full bg-surface-container-low text-on-surface px-4 py-3 rounded text-body-md placeholder:text-outline-variant/70 focus:outline-none focus:bg-surface-container-lowest focus:ring-1 focus:ring-primary shadow-inner transition-colors" id="emailAddress" name="emailAddress" placeholder="e.g. patron@example.com" required type="email"/>
    </div>
  </div>

  <!-- 2. Phone Number -->
  <div class="space-y-1.5">
    <label class="block font-label-md text-label-md uppercase text-on-surface-variant tracking-wider" for="phoneNumber">
      Phone Number <span class="text-secondary font-bold">*</span>
    </label>
    <div class="relative">
      <input class="w-full bg-surface-container-low text-on-surface px-4 py-3 rounded text-body-md placeholder:text-outline-variant/70 focus:outline-none focus:bg-surface-container-lowest focus:ring-1 focus:ring-primary shadow-inner transition-colors" id="phoneNumber" name="phoneNumber" placeholder="+91 94265 57390 or 10-digit mobile number" required type="tel"/>
    </div>
    <p class="text-[11px] text-tertiary">Used for encrypted WhatsApp or voice consultation callback.</p>
  </div>

  <!-- 3. Enquiry Type & Jewellery Category -->
  <div class="grid grid-cols-1 sm:grid-cols-2 gap-6">
    <!-- Enquiry Type (10 exact requested options) -->
    <div class="space-y-1.5">
      <label class="block font-label-md text-label-md uppercase text-on-surface-variant tracking-wider" for="enquiryType">
        Enquiry Type <span class="text-secondary font-bold">*</span>
      </label>
      <div class="relative">
        <select class="w-full appearance-none bg-surface-container-low text-on-surface px-4 py-3 pr-10 rounded text-body-md focus:outline-none focus:bg-surface-container-lowest focus:ring-1 focus:ring-primary shadow-inner cursor-pointer" id="enquiryType" name="enquiryType">
          <option value="General Enquiry">General Enquiry</option>
          <option value="Gold Jewellery">Gold Jewellery</option>
          <option value="Bridal Jewellery">Bridal Jewellery</option>
          <option value="Necklace Sets">Necklace Sets</option>
          <option value="Earrings">Earrings</option>
          <option value="Rings">Rings</option>
          <option value="Bangles and Bracelets">Bangles and Bracelets</option>
          <option value="Product Pricing">Product Pricing</option>
          <option value="Custom Jewellery">Custom Jewellery</option>
          <option value="Order Support">Order Support</option>
        </select>
        <span class="material-symbols-outlined pointer-events-none absolute right-3 top-3 text-[20px] text-primary">expand_more</span>
      </div>
    </div>

    <!-- Jewellery Category -->
    <div class="space-y-1.5">
      <label class="block font-label-md text-label-md uppercase text-on-surface-variant tracking-wider" for="jewelleryCategory">
        Jewellery Category <span class="text-secondary font-bold">*</span>
      </label>
      <div class="relative">
        <select class="w-full appearance-none bg-surface-container-low text-on-surface px-4 py-3 pr-10 rounded text-body-md focus:outline-none focus:bg-surface-container-lowest focus:ring-1 focus:ring-primary shadow-inner cursor-pointer" id="jewelleryCategory" name="jewelleryCategory">
          <option value="Gold Necklaces">Gold Necklaces &amp; Chokers</option>
          <option value="Bridal Jewellery">Bridal Jewellery Suites</option>
          <option value="Earrings">Earrings &amp; Chandbalis</option>
          <option value="Bangles and Bracelets">Bangles and Bracelets</option>
          <option value="Rings">Rings &amp; Signets</option>
          <option value="Traditional Jewellery">Traditional Temple Jewellery</option>
          <option value="Contemporary Jewellery">Contemporary Jewellery</option>
        </select>
        <span class="material-symbols-outlined pointer-events-none absolute right-3 top-3 text-[20px] text-primary">expand_more</span>
      </div>
    </div>
  </div>

  <!-- 4. Budget Range (Optional) -->
  <div class="space-y-1.5">
    <label class="block font-label-md text-label-md uppercase text-on-surface-variant tracking-wider" for="budgetRange">
      Budget Range <span class="text-tertiary text-xs normal-case">(Optional)</span>
    </label>
    <div class="relative">
      <select class="w-full appearance-none bg-surface-container-low text-on-surface px-4 py-3 pr-10 rounded text-body-md focus:outline-none focus:bg-surface-container-lowest focus:ring-1 focus:ring-primary shadow-inner cursor-pointer" id="budgetRange" name="budgetRange">
        <option value="">Flexible / To Be Discussed</option>
        <option value="Under ₹1,00,000">Under ₹1,00,000</option>
        <option value="₹1,00,000 – ₹2,50,000">₹1,00,000 – ₹2,50,000</option>
        <option value="₹2,50,000 – ₹5,00,000">₹2,50,000 – ₹5,00,000</option>
        <option value="Above ₹5,00,000">Above ₹5,00,000</option>
      </select>
      <span class="material-symbols-outlined pointer-events-none absolute right-3 top-3 text-[20px] text-primary">expand_more</span>
    </div>
  </div>

  <!-- 5. Message -->
  <div class="space-y-1.5">
    <label class="block font-label-md text-label-md uppercase text-on-surface-variant tracking-wider" for="messageBody">
      Message <span class="text-secondary font-bold">*</span>
    </label>
    <textarea class="w-full bg-surface-container-low text-on-surface px-4 py-3 rounded text-body-md placeholder:text-outline-variant/70 focus:outline-none focus:bg-surface-container-lowest focus:ring-1 focus:ring-primary shadow-inner transition-colors resize-y min-h-[120px]" id="messageBody" name="messageBody" placeholder="Please specify your design requirements, metal preferences, gold purity (22K/18K), or event timeline..." required></textarea>
  </div>

  <!-- Submit Enquiry Button -->
  <button class="w-full py-4 bg-primary-container text-on-primary-container hover:bg-secondary hover:text-on-secondary font-label-lg text-label-lg tracking-[0.2em] uppercase transition-all duration-300 shadow-md flex items-center justify-center gap-2 group cursor-pointer" id="submitBtn" type="submit">
    <span>Submit Enquiry</span>
    <span class="material-symbols-outlined text-base transition-transform group-hover:translate-x-1">arrow_forward</span>
  </button>

  <!-- Clear Feedback Message Area -->
  <div class="hidden p-5 rounded-lg bg-surface-container-low border border-primary-container/40" id="formFeedback"></div>
</form>
'@

$contactEnhanced = [System.Text.RegularExpressions.Regex]::Replace($contactEnhanced, '<form class="space-y-6" id="enquiryForm".*?<\/form>', $newFormHtml, [System.Text.RegularExpressions.RegexOptions]::Singleline)

# Clean address/hours placeholders in Column 2
$contactCol2Old = @'
<div class="p-8 md:p-10 border border-outline-variant/30 rounded-lg space-y-8 bg-surface-container-low/20">
<div>
<h3 class="font-headline-sm text-headline-sm text-on-surface">Maison Colaba</h3>
<p class="font-body-sm text-body-sm text-on-surface-variant mt-1">Flagship Salon &amp; Bespoke Design Atelier</p>
</div>
<div class="space-y-4 font-body-md text-body-md text-on-surface-variant">
<div class="flex items-start gap-4">
<span class="material-symbols-outlined text-primary text-[20px] mt-0.5">location_on</span>
<div>
<p class="text-on-surface">Imperial Chambers, Ground Floor</p>
<p>42/A B.K. Boman Behram Marg, Colaba</p>
<p>Mumbai, Maharashtra 400001</p>
</div>
</div>
<div class="flex items-start gap-4">
<span class="material-symbols-outlined text-primary text-[20px] mt-0.5">schedule</span>
<div>
<p class="text-on-surface font-medium">Monday — Saturday</p>
<p class="text-sm">11:00 AM — 08:00 PM IST</p>
<p class="text-on-surface font-medium mt-2">Sunday</p>
<p class="text-sm">Private Salon Appointments Only</p>
</div>
</div>
</div>
'@

$contactCol2New = @'
<div class="p-8 md:p-10 border border-outline-variant/30 rounded-lg space-y-8 bg-surface-container-low/20">
<div>
<h3 class="font-headline-sm text-headline-sm text-on-surface">PRINCESS JEWELS Flagship</h3>
<p class="font-body-sm text-body-sm text-on-surface-variant mt-1">Haute Joaillerie &amp; Bespoke Karigar Design Atelier</p>
</div>
<div class="space-y-5 font-body-md text-body-md text-on-surface-variant">
<div class="flex items-start gap-4">
<span class="material-symbols-outlined text-primary text-[22px] mt-0.5">location_on</span>
<div>
<p class="text-on-surface font-semibold">[Showroom &amp; Atelier Address Placeholder]</p>
<p class="text-xs text-tertiary mt-0.5">Official address will be provided upon private appointment confirmation.</p>
</div>
</div>
<div class="flex items-start gap-4">
<span class="material-symbols-outlined text-primary text-[22px] mt-0.5">schedule</span>
<div>
<p class="text-on-surface font-semibold">[Business Hours Placeholder]</p>
<p class="text-xs text-tertiary mt-0.5">Contact Concierge via WhatsApp or Phone for appointment availability.</p>
</div>
</div>
<div class="flex items-start gap-4">
<span class="material-symbols-outlined text-primary text-[22px] mt-0.5">map</span>
<div>
<p class="text-on-surface font-semibold">[Interactive Location Map Placeholder]</p>
<p class="text-xs text-tertiary mt-0.5">Protected white-glove insured delivery available across India and internationally.</p>
</div>
</div>
</div>
'@

$contactEnhanced = $contactEnhanced.Replace($contactCol2Old, $contactCol2New)
$contactEnhanced = Clean-Text $contactEnhanced

[System.IO.File]::WriteAllText("$root\contact.html", $contactEnhanced, [System.Text.Encoding]::UTF8)
[System.IO.File]::WriteAllText("$root\contact-us.html", $contactEnhanced, [System.Text.Encoding]::UTF8)
Write-Host "contact.html and contact-us.html built successfully."

Write-Host "`nAll 5 website pages rebuilt successfully with 100% clean UTF-8 encoding and luxury standards."
