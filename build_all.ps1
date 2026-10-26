$ErrorActionPreference = "Stop"

$root = $PSScriptRoot
if (-not $root) { $root = "." }

$topbar = [System.IO.File]::ReadAllText("$root\build_templates\topbar.html", [System.Text.Encoding]::UTF8)
$footer = [System.IO.File]::ReadAllText("$root\build_templates\footer.html", [System.Text.Encoding]::UTF8)
$sharedDrawers = [System.IO.File]::ReadAllText("$root\build_templates\shared_drawers.html", [System.Text.Encoding]::UTF8)
$heroSlideshow = [System.IO.File]::ReadAllText("$root\build_templates\hero_slideshow.html", [System.Text.Encoding]::UTF8)

# Common replacements helper
function Enhance-PageContent($html, $pageType) {
    # 1. Update <head> & Favicons
    $html = $html.Replace('<head>', "<head>`n<link rel=""icon"" type=""image/png"" href=""assets/images/princess_jewels_medallion.png""/><link rel=""apple-touch-icon"" href=""assets/images/princess_jewels_medallion.png""/>")
    $html = $html.Replace('<title>princess JEWELS | The Art of Golden Elegance</title>', '<title>PRINCESS JEWELS | The Art of Golden Elegance — 22K Royal Gold & Bridal Jewellery</title><link rel="stylesheet" href="assets/style.css"/>')
    $html = $html.Replace('data-path="home" href="#"', 'href="index.html"')
    $html = $html.Replace('princess JEWELS', 'PRINCESS JEWELS')
    $html = $html.Replace('The Art of Golden Elegance', 'THE ART OF GOLDEN ELEGANCE')

    # Replace Header Logo Brand Lockup with Royal Medallion Logo
    $headerBrandRegex = '<a class="flex items-center gap-3 group".*?THE ART OF GOLDEN ELEGANCE<\/span><\/div><\/a>'
    $headerBrandHtml = '<a class="flex items-center gap-3.5 group" href="index.html"><div class="relative w-11 h-11 md:w-12 md:h-12 rounded-full p-0.5 bg-gradient-to-tr from-[#914852] via-[#c6a15b] to-[#ffdea5] shadow-md group-hover:scale-105 transition-transform duration-300 shrink-0"><img alt="PRINCESS JEWELS Royal Emblem" class="w-full h-full object-cover rounded-full bg-[#141210]" src="assets/images/princess_jewels_medallion.png"/></div><div class="flex flex-col"><span class="font-headline-sm text-base md:text-title-lg text-secondary tracking-[0.18em] uppercase font-bold leading-none">PRINCESS JEWELS</span><span class="font-label-sm text-[8px] md:text-[9px] tracking-[0.28em] text-primary uppercase mt-1 leading-none font-medium">THE ART OF GOLDEN ELEGANCE</span></div></a>'
    $html = [System.Text.RegularExpressions.Regex]::Replace($html, $headerBrandRegex, $headerBrandHtml, [System.Text.RegularExpressions.RegexOptions]::Singleline)

    
    # 2. Replace Top announcement bar
    $html = [System.Text.RegularExpressions.Regex]::Replace($html, '<div class="w-full bg-secondary text-surface-bright py-1.5.*?Concierge</span></a></div></div></div>', $topbar, [System.Text.RegularExpressions.RegexOptions]::Singleline)

    # 3. Replace Navigation Block
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

    # 4. Replace Header Action Icons (Search, Wishlist, Bag, Mobile Toggle)
    $actionsRegex = '<div class="flex items-center gap-3 sm:gap-4.*?expand_more<\/span><\/div><\/div>'
    $newActions = '<div class="flex items-center gap-2 sm:gap-4 shrink-0"><button aria-label="Search Catalogue" data-action="open-search" class="p-2 text-on-surface-variant hover:text-primary transition-colors flex items-center" type="button"><span class="material-symbols-outlined text-[22px]">search</span></button><button aria-label="Wishlist" data-action="open-wishlist" class="relative p-2 text-on-surface-variant hover:text-primary transition-colors flex items-center" type="button"><span class="material-symbols-outlined text-[22px]">favorite</span><span class="wishlist-count-badge absolute top-1 right-0.5 bg-secondary text-on-secondary font-label-sm text-[9px] w-4 h-4 rounded-full flex items-center justify-center leading-none">3</span></button><button aria-label="Shopping Bag" data-action="open-cart" class="relative p-2 text-on-surface-variant hover:text-primary transition-colors flex items-center" type="button"><span class="material-symbols-outlined text-[22px]">shopping_bag</span><span class="cart-count-badge absolute top-1 right-0.5 bg-primary-container text-on-primary-container font-label-sm text-[9px] w-4 h-4 rounded-full flex items-center justify-center leading-none font-bold">1</span></button><div class="h-5 w-px bg-outline-variant/40 hidden sm:block"></div><button id="mobileMenuToggle" aria-label="Open Mobile Menu" class="lg:hidden p-2 text-on-surface hover:text-primary transition-colors flex items-center" type="button"><span class="material-symbols-outlined text-[26px]">menu</span></button></div>'
    $html = [System.Text.RegularExpressions.Regex]::Replace($html, $actionsRegex, $newActions, [System.Text.RegularExpressions.RegexOptions]::Singleline)

    # 5. Replace Footer
    $footerRegex = '<footer class="w-full bg-inverse-surface.*?<\/footer>'
    $html = [System.Text.RegularExpressions.Regex]::Replace($html, $footerRegex, $footer, [System.Text.RegularExpressions.RegexOptions]::Singleline)

    # 6. Append Drawers and JS before </body>
    $html = [System.Text.RegularExpressions.Regex]::Replace($html, '<\/body>\s*<\/html>', $sharedDrawers, [System.Text.RegularExpressions.RegexOptions]::Singleline)

    # Clean fictitious claims
    $html = $html.Replace('Maison Fondée 1928', 'Royal Indian Goldsmithing')
    $html = $html.Replace('Maison Heritage • Est. 1928', 'Royal Heritage • Pure Gold Artistry')
    $html = $html.Replace('Haute Bridal Joaillerie • Anno 1928', 'Haute Bridal Joaillerie • Royal Indian Craft')
    $html = $html.Replace('since 1928', 'with enduring devotion')
    $html = $html.Replace('1928', 'Pure')
    $html = $html.Replace('97+ Years of Royal Patronage', 'Generations of Royal Karigar Heritage')
    $html = $html.Replace('96 Years of Artistry', 'Generations of Artistry')

    return $html
}

# -----------------
# 1. BUILD index.html
# -----------------
Write-Host "Building index.html..."
$homeRaw = [System.IO.File]::ReadAllText("$root\stitch_source\stitch_princess_jewels_luxury_website\home_princess_jewels\code.html", [System.Text.Encoding]::UTF8)
$homeEnhanced = Enhance-PageContent $homeRaw "home"

# Replace hero with slideshow
$oldHeroRegex = '<!-- 1\. CINEMATIC HERO SECTION -->.*?<!-- TRUST BADGES ROW -->'
$homeEnhanced = [System.Text.RegularExpressions.Regex]::Replace($homeEnhanced, $oldHeroRegex, ($heroSlideshow + "`n<!-- TRUST BADGES ROW -->"), [System.Text.RegularExpressions.RegexOptions]::Singleline)

# Update testimonials
$sampleNotice = '<div class="text-center max-w-3xl mx-auto mb-16 space-y-3"><span class="font-label-sm text-label-sm uppercase tracking-[0.26em] text-primary">Voices of the Royal Patrons</span><h2 class="font-headline-lg text-headline-lg text-on-surface">Heirlooms Revered Worldwide</h2><p class="font-body-md text-body-md text-on-surface-variant font-light">Patron experiences celebrating sacred milestones. <span class="italic text-xs text-primary block mt-1">(Clearly identified sample patron testimonials for illustration until verified)</span></p></div>'
$homeEnhanced = [System.Text.RegularExpressions.Regex]::Replace($homeEnhanced, '<div class="text-center max-w-3xl mx-auto mb-16 space-y-3">.*?Heirlooms Revered Worldwide.*?<\/div>', $sampleNotice, [System.Text.RegularExpressions.RegexOptions]::Singleline)

[System.IO.File]::WriteAllText("$root\index.html", $homeEnhanced, [System.Text.Encoding]::UTF8)
Write-Host "index.html built successfully ($($homeEnhanced.Length) bytes)"
