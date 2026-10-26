# Generate index.html from Stitch home_princess_jewels/code.html
$ErrorActionPreference = "Stop"

$sourcePath = "stitch_source\stitch_princess_jewels_luxury_website\home_princess_jewels\code.html"
$content = [System.IO.File]::ReadAllText($sourcePath, [System.Text.Encoding]::UTF8)

# 1. Update Title and Head
$content = $content.Replace("<title>princess JEWELS | The Art of Golden Elegance</title>", "<title>PRINCESS JEWELS | The Art of Golden Elegance — 22K Royal Gold & Bridal Jewellery</title><link rel=`"stylesheet`" href=`"assets/style.css`"/>")

# 2. Update Top Announcement Bar
$oldTopBar = '<div class="w-full bg-secondary text-surface-bright py-1.5 px-margin-mobile md:px-margin-tablet lg:px-margin transition-colors duration-300"><div class="max-w-7xl mx-auto flex flex-col md:flex-row items-center justify-between text-[11px] tracking-[0.16em] font-label-sm uppercase gap-1.5"><div class="flex items-center gap-2 text-center md:text-left"><span class="text-primary-fixed-dim font-headline-sm italic text-xs normal-case">Special Announcement:</span><span>Discover Timeless Gold. Celebrate Every Precious Moment.</span><span class="hidden xl:inline text-outline-variant/60">|</span><span class="hidden xl:inline text-surface-container-high/90">Complimentary Insured White-Glove Shipping &amp; Private Concierge</span></div><div class="flex items-center gap-6 text-surface-container-high"><div class="flex items-center gap-1 cursor-pointer hover:text-primary-fixed-dim transition-colors"><span class="material-symbols-outlined text-[14px]">language</span><span class="font-label-sm">INR ₹</span><span class="material-symbols-outlined text-[12px]">arrow_drop_down</span></div><a class="flex items-center gap-1 hover:text-primary-fixed-dim transition-colors" data-path="boutiques" href="#"><span class="material-symbols-outlined text-[14px]">pin_drop</span><span class="font-label-sm tracking-wider">Boutique Locator</span></a><a class="flex items-center gap-1 hover:text-primary-fixed-dim transition-colors" data-path="concierge" href="#"><span class="material-symbols-outlined text-[14px]">support_agent</span><span class="font-label-sm tracking-wider">Concierge</span></a></div></div></div>'

$newTopBar = @'
<div class="w-full bg-secondary text-surface-bright py-2 px-margin-mobile md:px-margin-tablet lg:px-margin transition-colors duration-300">
  <div class="max-w-7xl mx-auto flex flex-col md:flex-row items-center justify-between text-[11px] tracking-[0.16em] font-label-sm uppercase gap-2">
    <div class="flex items-center gap-2 text-center md:text-left">
      <span class="text-primary-fixed-dim font-headline-sm italic text-xs normal-case">Special Announcement:</span>
      <span>Discover Timeless Gold. Celebrate Every Precious Moment.</span>
      <span class="hidden xl:inline text-outline-variant/60">|</span>
      <span class="hidden xl:inline text-surface-container-high/90">BIS 916 Hallmarked 22K Gold • White-Glove Insured Delivery</span>
    </div>
    <div class="flex items-center gap-5 text-surface-container-high">
      <a href="tel:+919426557390" class="flex items-center gap-1.5 hover:text-primary-fixed-dim transition-colors" title="Click to call">
        <span class="material-symbols-outlined text-[14px] text-primary-fixed-dim">call</span>
        <span class="font-semibold">+91 94265 57390</span>
      </a>
      <a href="mailto:parshwaexport108@gmail.com" class="hidden sm:flex items-center gap-1.5 hover:text-primary-fixed-dim transition-colors" title="Email us">
        <span class="material-symbols-outlined text-[14px] text-primary-fixed-dim">mail</span>
        <span>parshwaexport108@gmail.com</span>
      </a>
      <a href="https://wa.me/919426557390?text=Hello%20PRINCESS%20JEWELS%2C%20I%20am%20interested%20in%20your%20jewellery%20collections.%20Please%20share%20more%20details." target="_blank" rel="noopener noreferrer" class="flex items-center gap-1 text-primary-fixed-dim hover:text-white transition-colors" title="Chat on WhatsApp">
        <span class="material-symbols-outlined text-[14px]">chat</span>
        <span>WhatsApp</span>
      </a>
    </div>
  </div>
</div>
'@

if ($content.Contains($oldTopBar)) {
    $content = $content.Replace($oldTopBar, $newTopBar)
} else {
    Write-Host "Warning: Old Top Bar not matched exactly, replacing via regex"
    $content = [System.Text.RegularExpressions.Regex]::Replace($content, '<div class="w-full bg-secondary.*?Concierge</span></a></div></div></div>', $newTopBar, [System.Text.RegularExpressions.RegexOptions]::Singleline)
}

# 3. Update Header Navigation & Actions
$oldNavBlock = '<nav class="hidden lg:flex items-center gap-8 xl:gap-10" data-active-classes="text-primary font-semibold border-b border-primary-container pb-1"><a aria-current="page" class="tracking-[0.16em] uppercase transition-colors py-1 text-primary font-semibold border-b border-primary-container pb-1" data-path="home" href="#">Home</a><a class="font-label-lg text-label-lg tracking-[0.16em] uppercase text-on-surface-variant hover:text-primary transition-colors py-1" data-path="collections" href="#">Collections</a><a class="font-label-lg text-label-lg tracking-[0.16em] uppercase text-on-surface-variant hover:text-primary transition-colors py-1" data-path="bridal-jewellery" href="#">Bridal Jewellery</a><a class="font-label-lg text-label-lg tracking-[0.16em] uppercase text-on-surface-variant hover:text-primary transition-colors py-1" data-path="about-us" href="#">About Us</a><a class="font-label-lg text-label-lg tracking-[0.16em] uppercase text-on-surface-variant hover:text-primary transition-colors py-1" data-path="contact-us" href="#">Contact Us</a></nav>'

$newNavBlock = @'
<nav class="hidden lg:flex items-center gap-8 xl:gap-10">
  <a aria-current="page" class="tracking-[0.16em] uppercase transition-colors py-1 text-primary font-semibold border-b border-primary-container pb-1" href="index.html">Home</a>
  <a class="font-label-lg text-label-lg tracking-[0.16em] uppercase text-on-surface-variant hover:text-primary transition-colors py-1" href="products.html">Collections</a>
  <a class="font-label-lg text-label-lg tracking-[0.16em] uppercase text-on-surface-variant hover:text-primary transition-colors py-1" href="bridal.html">Bridal Jewellery</a>
  <a class="font-label-lg text-label-lg tracking-[0.16em] uppercase text-on-surface-variant hover:text-primary transition-colors py-1" href="about.html">About Us</a>
  <a class="font-label-lg text-label-lg tracking-[0.16em] uppercase text-on-surface-variant hover:text-primary transition-colors py-1" href="contact.html">Contact Us</a>
</nav>
'@

if ($content.Contains($oldNavBlock)) {
    $content = $content.Replace($oldNavBlock, $newNavBlock)
} else {
    $content = [System.Text.RegularExpressions.Regex]::Replace($content, '<nav class="hidden lg:flex.*?contact-us.*?<\/nav>', $newNavBlock, [System.Text.RegularExpressions.RegexOptions]::Singleline)
}

# Update brand link and title
$content = $content.Replace('data-path="home" href="#"', 'href="index.html"')
$content = $content.Replace('princess JEWELS', 'PRINCESS JEWELS')
$content = $content.Replace('The Art of Golden Elegance', 'THE ART OF GOLDEN ELEGANCE')

# Update header action icons (search, wishlist, bag, mobile toggle)
$oldHeaderActions = '<div class="flex items-center gap-3 sm:gap-4 md:gap-5 shrink-0"><button aria-label="Search Catalogue" class="p-2 text-on-surface-variant hover:text-primary transition-colors flex items-center" type="button"><span class="material-symbols-outlined text-[22px]">search</span></button><a aria-label="Wishlist" class="relative p-2 text-on-surface-variant hover:text-primary transition-colors flex items-center" data-path="wishlist" href="#"><span class="material-symbols-outlined text-[22px]">favorite</span><span class="absolute top-1 right-0.5 bg-secondary text-on-secondary font-label-sm text-[9px] w-4 h-4 rounded-full flex items-center justify-center leading-none">3</span></a><a aria-label="Shopping Bag" class="relative p-2 text-on-surface-variant hover:text-primary transition-colors flex items-center" data-path="shopping-bag" href="#"><span class="material-symbols-outlined text-[22px]">shopping_bag</span><span class="absolute top-1 right-0.5 bg-primary-container text-on-primary-container font-label-sm text-[9px] w-4 h-4 rounded-full flex items-center justify-center leading-none font-bold">1</span></a><div class="h-5 w-px bg-outline-variant/40 hidden sm:block"></div><div class="flex items-center gap-2 pl-1 cursor-pointer group"><div class="relative p-0.5 rounded-full ring-1 ring-primary-container/40 group-hover:ring-primary-container transition-all"><img alt="Profile" class="w-8 h-8 rounded-full object-cover" src="https://lh3.googleusercontent.com/aida-public/AB6AXuBt9Kt8Cx91DYH1KcJWxocfO1s59zjwWhRWc1SbRjyxYTl03dg6B8ubtKS4fnk18t7VcFwlY46V8oPqnJwUKAnwWAW4jsK37OtzAWFfqZwdBo_KR1QaV_QpaUdhTOt2BV6QlM6Pi4R34tRhQ7St1rfrKvmFiQA1iQCkhOcNaPY1C0BCQykxdBgq6zvD5LwXJZ3tu_sY1ucUgZ3NuTAO6hxcsTStMPOv-9hFhPEtFSbYWBVh_zUS5z3l"/></div><span class="material-symbols-outlined text-outline text-[16px] hidden sm:block group-hover:text-primary transition-colors">expand_more</span></div></div>'

$newHeaderActions = @'
<div class="flex items-center gap-2 sm:gap-4 shrink-0">
  <button aria-label="Search Catalogue" data-action="open-search" class="p-2 text-on-surface-variant hover:text-primary transition-colors flex items-center" type="button">
    <span class="material-symbols-outlined text-[22px]">search</span>
  </button>
  <button aria-label="Wishlist" data-action="open-wishlist" class="relative p-2 text-on-surface-variant hover:text-primary transition-colors flex items-center" type="button">
    <span class="material-symbols-outlined text-[22px]">favorite</span>
    <span class="wishlist-count-badge absolute top-1 right-0.5 bg-secondary text-on-secondary font-label-sm text-[9px] w-4 h-4 rounded-full flex items-center justify-center leading-none">3</span>
  </button>
  <button aria-label="Shopping Bag" data-action="open-cart" class="relative p-2 text-on-surface-variant hover:text-primary transition-colors flex items-center" type="button">
    <span class="material-symbols-outlined text-[22px]">shopping_bag</span>
    <span class="cart-count-badge absolute top-1 right-0.5 bg-primary-container text-on-primary-container font-label-sm text-[9px] w-4 h-4 rounded-full flex items-center justify-center leading-none font-bold">1</span>
  </button>
  <div class="h-5 w-px bg-outline-variant/40 hidden sm:block"></div>
  <!-- Mobile Hamburger Menu Button -->
  <button id="mobileMenuToggle" aria-label="Open Mobile Menu" class="lg:hidden p-2 text-on-surface hover:text-primary transition-colors flex items-center" type="button">
    <span class="material-symbols-outlined text-[26px]">menu</span>
  </button>
</div>
'@

if ($content.Contains($oldHeaderActions)) {
    $content = $content.Replace($oldHeaderActions, $newHeaderActions)
} else {
    $content = [System.Text.RegularExpressions.Regex]::Replace($content, '<div class="flex items-center gap-3 sm:gap-4.*?expand_more<\/span><\/div><\/div>', $newHeaderActions, [System.Text.RegularExpressions.RegexOptions]::Singleline)
}

# 4. Replace Single Hero Section with Continuous Automatic 3-Second Slideshow
$oldHeroRegex = '<!-- 1\. CINEMATIC HERO SECTION -->.*?<!-- TRUST BADGES ROW -->'
$newHeroSlideshow = @'
<!-- 1. CINEMATIC CONTINUOUS AUTOMATIC HERO SLIDESHOW (3-SECOND INTERVAL) -->
<section class="relative w-full -mt-28 min-h-[920px] lg:min-h-[960px] flex items-center justify-center overflow-hidden bg-inverse-surface" id="heroSlideshow">
  <!-- Slide 1 (Active): Uploaded Crimson Bridal Masterpiece -->
  <div class="hero-slide absolute inset-0 opacity-100 transition-opacity duration-1000 z-10 pointer-events-auto">
    <div class="hero-bg-img absolute inset-0 bg-cover bg-center transition-transform duration-6000 ease-out scale-105"
         style="background-image: url('assets/images/uploaded_bridal_red.jpg');"></div>
    <div class="absolute inset-0 bg-gradient-to-t from-inverse-surface via-inverse-surface/40 to-inverse-surface/75"></div>
    <div class="absolute inset-0 bg-gradient-to-r from-inverse-surface/85 via-transparent to-inverse-surface/85"></div>
  </div>

  <!-- Slide 2: Uploaded Royal Gold Bridal Choker -->
  <div class="hero-slide absolute inset-0 opacity-0 transition-opacity duration-1000 z-0 pointer-events-none">
    <div class="hero-bg-img absolute inset-0 bg-cover bg-center transition-transform duration-6000 ease-out scale-100"
         style="background-image: url('assets/images/uploaded_bridal_gold.jpg');"></div>
    <div class="absolute inset-0 bg-gradient-to-t from-inverse-surface via-inverse-surface/40 to-inverse-surface/75"></div>
    <div class="absolute inset-0 bg-gradient-to-r from-inverse-surface/85 via-transparent to-inverse-surface/85"></div>
  </div>

  <!-- Slide 3: Uploaded PRINCESS JEWELLS Bespoke White Packaging & Gift Cases -->
  <div class="hero-slide absolute inset-0 opacity-0 transition-opacity duration-1000 z-0 pointer-events-none">
    <div class="hero-bg-img absolute inset-0 bg-cover bg-center transition-transform duration-6000 ease-out scale-100"
         style="background-image: url('assets/images/uploaded_packaging_boxes.jpg');"></div>
    <div class="absolute inset-0 bg-gradient-to-t from-inverse-surface via-inverse-surface/40 to-inverse-surface/75"></div>
    <div class="absolute inset-0 bg-gradient-to-r from-inverse-surface/85 via-transparent to-inverse-surface/85"></div>
  </div>

  <!-- Slide 4: Uploaded Brand Identity Collage & Tiara Suite -->
  <div class="hero-slide absolute inset-0 opacity-0 transition-opacity duration-1000 z-0 pointer-events-none">
    <div class="hero-bg-img absolute inset-0 bg-cover bg-center transition-transform duration-6000 ease-out scale-100"
         style="background-image: url('assets/images/uploaded_brand_identity.jpg');"></div>
    <div class="absolute inset-0 bg-gradient-to-t from-inverse-surface via-inverse-surface/40 to-inverse-surface/75"></div>
    <div class="absolute inset-0 bg-gradient-to-r from-inverse-surface/85 via-transparent to-inverse-surface/85"></div>
  </div>

  <!-- Slide 5: Imperial Trousseau Atelier Suite -->
  <div class="hero-slide absolute inset-0 opacity-0 transition-opacity duration-1000 z-0 pointer-events-none">
    <div class="hero-bg-img absolute inset-0 bg-cover bg-center transition-transform duration-6000 ease-out scale-100"
         style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuAXbMbzmeX8ZH7pJX2Pftqz9rN2k3AeRiFwvOx-lOKF2G4wqvtEcNqhFrb51jVIpVUbPz5C8IT93VShHCLDYhPsZiNCiOYQqd9WGUyh0iQo50a3cAmInaq2XqM456GA2YOcFFFzzF1lqwaPpqQZf3YmkizTHB07aWkFKyjgJ9b8qBXJCQn6AVDh3NlKlj8NuLigWTsS-07KcjTYvXYQM3NG7t1fhYn6Hk_mau7dJGvWNotR2Sl_UU9Z');"></div>
    <div class="absolute inset-0 bg-gradient-to-t from-inverse-surface via-inverse-surface/40 to-inverse-surface/75"></div>
    <div class="absolute inset-0 bg-gradient-to-r from-inverse-surface/85 via-transparent to-inverse-surface/85"></div>
  </div>

  <!-- Fixed Hero Editorial Content -->
  <div class="relative z-20 max-w-5xl mx-auto px-margin-mobile md:px-margin-tablet lg:px-margin pt-36 pb-20 text-center flex flex-col items-center">
    <div class="flex items-center gap-3 mb-6">
      <span class="w-12 h-px bg-gradient-to-r from-transparent to-primary-container"></span>
      <span class="font-label-md text-label-md uppercase tracking-[0.28em] text-primary-fixed-dim">Haute Joaillerie • Royal Indian Goldsmithing</span>
      <span class="w-12 h-px bg-gradient-to-l from-transparent to-primary-container"></span>
    </div>

    <h1 class="font-display-lg text-display-lg text-surface-bright tracking-[0.08em] uppercase max-w-4xl drop-shadow-md">
      The Art of <span class="italic font-normal text-primary-fixed-dim">Golden Elegance</span>
    </h1>

    <p class="font-body-lg text-body-lg text-surface-container-high/90 max-w-2xl mt-5 mb-10 font-light leading-relaxed">
      Jewellery That Celebrates Your Story. Handcrafted 22K &amp; 18K royal heirlooms forged by ancestral karigars, echoing the timeless grandeur of Indian royalty.
    </p>

    <!-- Action Buttons Cluster -->
    <div class="flex flex-col sm:flex-row items-center gap-5 w-full sm:w-auto">
      <a class="w-full sm:w-auto px-9 py-4 bg-primary-container text-on-primary-container hover:bg-secondary hover:text-on-secondary font-label-lg text-label-lg tracking-[0.18em] uppercase transition-all duration-300 shadow-xl flex items-center justify-center gap-2 group" href="products.html">
        <span>Explore Collections</span>
        <span class="material-symbols-outlined text-base transition-transform group-hover:translate-x-1">arrow_forward</span>
      </a>
      <a class="w-full sm:w-auto px-9 py-4 bg-surface-container-lowest/15 backdrop-blur-md text-surface-bright hover:bg-surface-container-lowest/30 font-label-lg text-label-lg tracking-[0.18em] uppercase transition-all duration-300 border border-primary-container/40 flex items-center justify-center gap-2" href="bridal.html">
        <span>Bridal Jewellery</span>
      </a>
      <a class="w-full sm:w-auto px-6 py-4 bg-[#2E7D32]/90 hover:bg-[#1E4D2B] text-white font-label-lg text-label-lg tracking-[0.16em] uppercase transition-all duration-300 flex items-center justify-center gap-2 shadow-lg" href="https://wa.me/919426557390?text=Hello%20PRINCESS%20JEWELS%2C%20I%20am%20interested%20in%20your%20jewellery%20collections.%20Please%20share%20more%20details." target="_blank" rel="noopener noreferrer">
        <span class="material-symbols-outlined text-[20px]">chat</span>
        <span>WhatsApp</span>
      </a>
    </div>

    <!-- Slideshow Progress Indicators & Navigation Controls -->
    <div class="mt-12 flex items-center gap-6">
      <button id="heroPrevBtn" aria-label="Previous Slide" class="w-9 h-9 rounded-full bg-surface-container-lowest/15 hover:bg-surface-container-lowest/30 text-surface-bright backdrop-blur-sm flex items-center justify-center transition-colors">
        <span class="material-symbols-outlined text-sm">chevron_left</span>
      </button>

      <div class="flex items-center gap-2.5">
        <button class="hero-dot h-2.5 w-8 rounded-full bg-primary-container transition-all duration-300" aria-label="Go to slide 1"></button>
        <button class="hero-dot h-2.5 w-2.5 rounded-full bg-surface-container-high/40 hover:bg-surface-container-high transition-all duration-300" aria-label="Go to slide 2"></button>
        <button class="hero-dot h-2.5 w-2.5 rounded-full bg-surface-container-high/40 hover:bg-surface-container-high transition-all duration-300" aria-label="Go to slide 3"></button>
        <button class="hero-dot h-2.5 w-2.5 rounded-full bg-surface-container-high/40 hover:bg-surface-container-high transition-all duration-300" aria-label="Go to slide 4"></button>
        <button class="hero-dot h-2.5 w-2.5 rounded-full bg-surface-container-high/40 hover:bg-surface-container-high transition-all duration-300" aria-label="Go to slide 5"></button>
      </div>

      <button id="heroNextBtn" aria-label="Next Slide" class="w-9 h-9 rounded-full bg-surface-container-lowest/15 hover:bg-surface-container-lowest/30 text-surface-bright backdrop-blur-sm flex items-center justify-center transition-colors">
        <span class="material-symbols-outlined text-sm">chevron_right</span>
      </button>
    </div>

    <div class="mt-4 text-[11px] font-label-sm uppercase tracking-widest text-primary-fixed-dim/80">
      Continuous Slideshow • 3 Seconds
    </div>
  </div>
</section>
<!-- TRUST BADGES ROW -->
'@

$content = [System.Text.RegularExpressions.Regex]::Replace($content, $oldHeroRegex, $newHeroSlideshow, [System.Text.RegularExpressions.RegexOptions]::Singleline)

# 5. Connect Category Cards to Products Page
$content = $content.Replace('href="#all-categories"', 'href="products.html"')
$content = $content.Replace('href="#catalogue"', 'href="products.html"')
$content = $content.Replace('href="#bridal-consultation"', 'href="bridal.html#vip-consultation"')
$content = $content.Replace('href="#trousseau-guide"', 'href="bridal.html"')

# Wire up Quick View Buttons to JavaScript modal
$content = $content.Replace('<button class="w-full py-2.5 bg-primary-container text-on-primary-container font-label-sm text-[11px] uppercase tracking-wider hover:bg-secondary hover:text-on-secondary transition-colors shadow-md" type="button">`n                Quick View`n              </button>', '<button onclick="openModal(''The Maharani Imperial Choker'', ''₹3,85,000'', ''78.4g Gold'', ''22K Yellow Gold with Uncut Polki Gemstones and South Sea pearls.'', ''https://lh3.googleusercontent.com/aida-public/AB6AXuAVhWhIVJaOR9HFwb00tA_sKk7btZ1Ze_GJclZED-QZAniLjdqCOwB5EjIQOCnxk7UR_fYwgui-Ar6bIGWeolzvX-77EO8yircn9z798TZVU3cQ2kw716RzwmAkS3qx2uDCVdlTKvDu1JtClU-LG5pHjbiCWVTflM4SuiADaRYw1B-soay8VTXQkOQlH_7R9HOPQTjHcEMn02XXu7YUcdM8CcXz0q5ZzryZ-Aoar463WDqCiGE7i0vh'', ''necklaces'')" class="w-full py-2.5 bg-primary-container text-on-primary-container font-label-sm text-[11px] uppercase tracking-wider hover:bg-secondary hover:text-on-secondary transition-colors shadow-md" type="button">Quick View</button>')

# Customer Testimonials - add clear sample indication note
$oldTestimonialsHeader = '<div class="text-center max-w-3xl mx-auto mb-16 space-y-3"><span class="font-label-sm text-label-sm uppercase tracking-[0.26em] text-primary">Voices of the Royal Patrons</span><h2 class="font-headline-lg text-headline-lg text-on-surface">Heirlooms Revered Worldwide</h2><p class="font-body-md text-body-md text-on-surface-variant font-light">Real stories from our patrons celebrating milestones in Mumbai, Delhi, Jaipur, and London.</p></div>'

$newTestimonialsHeader = @'
<div class="text-center max-w-3xl mx-auto mb-16 space-y-3">
  <span class="font-label-sm text-label-sm uppercase tracking-[0.26em] text-primary">Voices of the Royal Patrons</span>
  <h2 class="font-headline-lg text-headline-lg text-on-surface">Heirlooms Revered Worldwide</h2>
  <p class="font-body-md text-body-md text-on-surface-variant font-light">
    Patron experiences celebrating sacred milestones. <span class="italic text-xs text-primary block mt-1">(Clearly identified sample patron testimonials for illustration until verified)</span>
  </p>
</div>
'@

$content = [System.Text.RegularExpressions.Regex]::Replace($content, '<div class="text-center max-w-3xl mx-auto mb-16 space-y-3">.*?Heirlooms Revered Worldwide.*?<\/div>', $newTestimonialsHeader, [System.Text.RegularExpressions.RegexOptions]::Singleline)

# Remove fabricated history claims (1928, etc.)
$content = $content.Replace('Maison Fondée 1928', 'Royal Indian Goldsmithing')
$content = $content.Replace('Maison Heritage • Est. 1928', 'Royal Heritage • Pure Gold Artistry')
$content = $content.Replace('since 1928', 'with enduring devotion')
$content = $content.Replace('97+ Years of Royal Patronage', 'Generations of Royal Karigar Heritage')

# 6. Update Footer with User Phone, Email, WhatsApp, and Links
$oldFooterRegex = '<footer class="w-full bg-inverse-surface.*?<\/footer>'

$newFooter = @'
<footer class="w-full bg-inverse-surface text-surface-container py-16 lg:py-20 border-t border-primary-container/20">
  <div class="max-w-7xl mx-auto px-margin-mobile md:px-margin-tablet lg:px-margin">
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-5 gap-10 lg:gap-8 pb-16">
      <!-- Col 1: Brand -->
      <div class="lg:col-span-1 space-y-4">
        <div class="flex items-center gap-3">
          <div class="w-9 h-9 rounded-full bg-primary-container/20 border border-primary-container/40 flex items-center justify-center text-primary-container">
            <svg class="w-5 h-5 text-primary-container" viewBox="0 0 24 24" fill="currentColor">
              <path d="M5 16L3 5L8.5 10L12 4L15.5 10L21 5L19 16H5M19 19C19 19.6 18.6 20 18 20H6C5.4 20 5 19.6 5 19V17H19V19Z"/>
            </svg>
          </div>
          <span class="font-headline-sm text-title-lg tracking-[0.2em] text-primary-fixed-dim uppercase font-bold">PRINCESS JEWELS</span>
        </div>
        <p class="font-label-sm text-primary-container tracking-[0.25em] uppercase text-[10px]">THE ART OF GOLDEN ELEGANCE</p>
        <p class="font-body-sm text-body-sm text-surface-variant/80 pt-2 leading-relaxed">
          Curating ancestral grandeur and bespoke 22K handcrafted royal jewellery for discerning gold jewellery patrons and wedding brides worldwide.
        </p>
        <div class="flex items-center gap-2 pt-2 text-outline-variant text-[11px] font-label-sm">
          <span class="material-symbols-outlined text-primary-container text-[16px]">verified</span>
          <span>BIS 916 HALLMARKED CERTIFIED</span>
        </div>
      </div>

      <!-- Col 2: Direct Contact -->
      <div class="space-y-4">
        <h4 class="font-headline-sm text-surface-bright text-base tracking-[0.14em] uppercase font-semibold">Contact &amp; Concierge</h4>
        <ul class="space-y-3 font-body-sm text-surface-variant/90">
          <li>
            <span class="text-[10px] uppercase font-label-sm text-primary-container block">Direct Telephone</span>
            <a href="tel:+919426557390" class="hover:text-primary-fixed-dim transition-colors font-medium flex items-center gap-1.5 mt-0.5">
              <span class="material-symbols-outlined text-sm text-primary-container">call</span>
              <span>+91 94265 57390</span>
            </a>
          </li>
          <li>
            <span class="text-[10px] uppercase font-label-sm text-primary-container block">Business Email</span>
            <a href="mailto:parshwaexport108@gmail.com" class="hover:text-primary-fixed-dim transition-colors break-all flex items-center gap-1.5 mt-0.5">
              <span class="material-symbols-outlined text-sm text-primary-container">mail</span>
              <span>parshwaexport108@gmail.com</span>
            </a>
          </li>
          <li>
            <span class="text-[10px] uppercase font-label-sm text-primary-container block">WhatsApp Service</span>
            <a href="https://wa.me/919426557390?text=Hello%20PRINCESS%20JEWELS%2C%20I%20am%20interested%20in%20your%20jewellery%20collections.%20Please%20share%20more%20details." target="_blank" rel="noopener noreferrer" class="hover:text-primary-fixed-dim transition-colors flex items-center gap-1.5 mt-0.5">
              <span class="material-symbols-outlined text-sm text-primary-container">chat</span>
              <span>+91 94265 57390</span>
            </a>
          </li>
          <li class="pt-1 flex gap-2">
            <a href="mailto:parshwaexport108@gmail.com" class="px-3 py-1.5 bg-primary-container text-on-primary-container font-label-sm text-[10px] uppercase tracking-wider hover:bg-secondary hover:text-white transition-colors">
              EMAIL US
            </a>
            <a href="tel:+919426557390" class="px-3 py-1.5 bg-surface-container-high text-on-surface font-label-sm text-[10px] uppercase tracking-wider hover:bg-white transition-colors">
              CALL US
            </a>
          </li>
        </ul>
      </div>

      <!-- Col 3: Navigation -->
      <div class="space-y-4">
        <h4 class="font-headline-sm text-surface-bright text-base tracking-[0.14em] uppercase font-semibold">Explore Repertoire</h4>
        <ul class="space-y-2.5 font-body-sm text-surface-variant/90">
          <li><a href="products.html?category=necklaces" class="hover:text-primary-fixed-dim transition-colors">Gold Necklaces &amp; Chokers</a></li>
          <li><a href="bridal.html" class="hover:text-primary-fixed-dim transition-colors">Bridal Jewellery Suites</a></li>
          <li><a href="products.html?category=earrings" class="hover:text-primary-fixed-dim transition-colors">Jhumkas &amp; Chandbalis</a></li>
          <li><a href="products.html?category=bangles" class="hover:text-primary-fixed-dim transition-colors">Bangles &amp; Royal Kadas</a></li>
          <li><a href="products.html?category=rings" class="hover:text-primary-fixed-dim transition-colors">Signets &amp; Solitaire Rings</a></li>
          <li><a href="products.html?category=traditional" class="hover:text-primary-fixed-dim transition-colors">Traditional Temple Jewellery</a></li>
          <li><a href="products.html?category=contemporary" class="hover:text-primary-fixed-dim transition-colors">Contemporary Fine Jewellery</a></li>
        </ul>
      </div>

      <!-- Col 4: The Maison -->
      <div class="space-y-4">
        <h4 class="font-headline-sm text-surface-bright text-base tracking-[0.14em] uppercase font-semibold">The Maison</h4>
        <ul class="space-y-2.5 font-body-sm text-surface-variant/90">
          <li><a href="about.html" class="hover:text-primary-fixed-dim transition-colors">About PRINCESS JEWELS</a></li>
          <li><a href="about.html#craftsmanship" class="hover:text-primary-fixed-dim transition-colors">Art of Karigar Craft</a></li>
          <li><a href="bridal.html#vip-consultation" class="hover:text-primary-fixed-dim transition-colors">Book Bridal Consultation</a></li>
          <li><a href="contact.html" class="hover:text-primary-fixed-dim transition-colors">Salon Suite &amp; Contact</a></li>
          <li><a href="contact.html#faqAccordionGroup" class="hover:text-primary-fixed-dim transition-colors">Patron FAQ &amp; Care Guide</a></li>
        </ul>
      </div>

      <!-- Col 5: VIP Private Salon Newsletter -->
      <div class="space-y-4">
        <h4 class="font-headline-sm text-surface-bright text-base tracking-[0.14em] uppercase font-semibold">Private Salon</h4>
        <p class="font-body-sm text-surface-variant/80 leading-relaxed">
          Receive confidential previews of unreleased royal bridal suites and bullion advisory.
        </p>
        <form class="space-y-2.5 pt-1" onsubmit="event.preventDefault(); document.getElementById('footer-vip-success').classList.remove('hidden');">
          <div class="relative">
            <input class="w-full bg-surface-container/10 border-0 text-surface-bright px-3.5 py-2.5 font-body-sm placeholder:text-outline-variant/60 focus:outline-none focus:ring-1 focus:ring-primary-container text-xs" placeholder="Enter your email address" required type="email"/>
            <button class="absolute right-1 top-1 bottom-1 px-3 bg-primary-container text-on-primary-container font-label-sm uppercase tracking-wider text-[10px] hover:bg-primary-fixed hover:text-on-primary-fixed transition-colors flex items-center justify-center" type="submit">Join</button>
          </div>
          <div id="footer-vip-success" class="hidden text-xs text-primary-fixed-dim pt-1 font-body-sm">
            ✓ Submitted to Concierge.
          </div>
          <p class="font-body-sm text-[10px] text-surface-variant/60">Strict discretion guaranteed.</p>
        </form>
      </div>
    </div>

    <!-- Bottom Attribution & Socials -->
    <div class="pt-8 mt-4 border-t border-surface-container/10 flex flex-col md:flex-row items-center justify-between gap-6">
      <div class="flex flex-col md:flex-row items-center gap-3 md:gap-6 font-body-sm text-[12px] text-surface-variant/80">
        <p>&copy; 2026 PRINCESS JEWELS. All rights reserved.</p>
        <span class="hidden md:inline text-surface-variant/40">•</span>
        <p>THE ART OF GOLDEN ELEGANCE • BIS 916 Hallmarked Gold</p>
      </div>

      <!-- Social Media Link Placeholders -->
      <div class="flex items-center gap-4 text-primary-fixed-dim">
        <a aria-label="Instagram Placeholder" class="p-1.5 hover:text-primary-container transition-colors flex items-center" href="#instagram-placeholder" title="Instagram (Placeholder)">
          <span class="material-symbols-outlined text-[18px]">photo_camera</span>
        </a>
        <a aria-label="Pinterest Placeholder" class="p-1.5 hover:text-primary-container transition-colors flex items-center" href="#pinterest-placeholder" title="Pinterest (Placeholder)">
          <span class="material-symbols-outlined text-[18px]">palette</span>
        </a>
        <a aria-label="YouTube Placeholder" class="p-1.5 hover:text-primary-container transition-colors flex items-center" href="#youtube-placeholder" title="YouTube (Placeholder)">
          <span class="material-symbols-outlined text-[18px]">smart_display</span>
        </a>
        <a aria-label="WhatsApp Concierge" class="p-1.5 hover:text-primary-container transition-colors flex items-center" href="https://wa.me/919426557390?text=Hello%20PRINCESS%20JEWELS%2C%20I%20am%20interested%20in%20your%20jewellery%20collections.%20Please%20share%20more%20details." target="_blank" rel="noopener noreferrer" title="WhatsApp Concierge">
          <span class="material-symbols-outlined text-[18px]">chat</span>
        </a>
      </div>

      <div class="flex items-center gap-3 font-label-sm text-[10px] text-surface-variant/70 tracking-widest uppercase">
        <span class="px-2 py-0.5 bg-surface-container/10 rounded">BIS 916</span>
        <span class="px-2 py-0.5 bg-surface-container/10 rounded">22K Gold</span>
        <span class="px-2 py-0.5 bg-surface-container/10 rounded">UPI</span>
        <span class="px-2 py-0.5 bg-surface-container/10 rounded">Cards</span>
      </div>
    </div>
  </div>
</footer>
'@

$content = [System.Text.RegularExpressions.Regex]::Replace($content, $oldFooterRegex, $newFooter, [System.Text.RegularExpressions.RegexOptions]::Singleline)

# 7. Append Shared Modals, Drawers, Floating Buttons & JavaScript Engine
$sharedComponents = @'
<!-- Mobile Navigation Drawer -->
<div id="mobileNavBackdrop" class="fixed inset-0 bg-on-surface/60 backdrop-blur-sm z-50 hidden transition-opacity"></div>
<aside id="mobileNavDrawer" class="fixed top-0 left-0 bottom-0 w-80 max-w-[85vw] bg-surface-container-lowest z-50 shadow-2xl transform -translate-x-full transition-transform duration-300 ease-out flex flex-col justify-between p-6 overflow-y-auto">
  <div class="space-y-6">
    <div class="flex items-center justify-between pb-4 border-b border-surface-container-high">
      <div class="flex flex-col">
        <span class="font-headline-sm text-title-lg text-secondary tracking-[0.16em] uppercase font-bold leading-none">PRINCESS JEWELS</span>
        <span class="font-label-sm text-[8px] tracking-[0.24em] text-primary uppercase mt-1">THE ART OF GOLDEN ELEGANCE</span>
      </div>
      <button id="mobileNavClose" class="p-2 text-on-surface-variant hover:text-primary transition-colors" aria-label="Close Navigation">
        <span class="material-symbols-outlined text-[24px]">close</span>
      </button>
    </div>

    <nav class="space-y-3 font-label-lg text-label-lg uppercase tracking-[0.16em]">
      <a href="index.html" class="block py-2.5 px-3 rounded text-primary font-bold bg-surface-container-low">Home</a>
      <a href="products.html" class="block py-2.5 px-3 rounded text-on-surface hover:bg-surface-container-low hover:text-primary transition-colors">Collections</a>
      <a href="bridal.html" class="block py-2.5 px-3 rounded text-on-surface hover:bg-surface-container-low hover:text-primary transition-colors">Bridal Jewellery</a>
      <a href="about.html" class="block py-2.5 px-3 rounded text-on-surface hover:bg-surface-container-low hover:text-primary transition-colors">About Us</a>
      <a href="contact.html" class="block py-2.5 px-3 rounded text-on-surface hover:bg-surface-container-low hover:text-primary transition-colors">Contact Us</a>
    </nav>
  </div>

  <div class="pt-6 border-t border-surface-container-high space-y-3 text-sm">
    <a href="tel:+919426557390" class="flex items-center gap-3 p-3 rounded bg-surface-container-low text-on-surface hover:text-primary transition-colors">
      <span class="material-symbols-outlined text-primary text-[20px]">call</span>
      <div>
        <span class="font-label-sm text-[10px] text-tertiary uppercase tracking-wider block">Direct Phone</span>
        <span class="font-semibold">+91 94265 57390</span>
      </div>
    </a>
    <a href="https://wa.me/919426557390?text=Hello%20PRINCESS%20JEWELS%2C%20I%20am%20interested%20in%20your%20jewellery%20collections.%20Please%20share%20more%20details." target="_blank" rel="noopener noreferrer" class="flex items-center gap-3 p-3 rounded bg-[#2E7D32]/10 text-[#2E7D32] hover:bg-[#2E7D32]/20 transition-colors">
      <span class="material-symbols-outlined text-[20px]">chat</span>
      <div>
        <span class="font-label-sm text-[10px] uppercase tracking-wider block">WhatsApp Concierge</span>
        <span class="font-semibold">+91 94265 57390</span>
      </div>
    </a>
    <a href="mailto:parshwaexport108@gmail.com" class="flex items-center gap-3 p-3 rounded bg-surface-container-low text-on-surface hover:text-primary transition-colors">
      <span class="material-symbols-outlined text-primary text-[20px]">mail</span>
      <div class="truncate">
        <span class="font-label-sm text-[10px] text-tertiary uppercase tracking-wider block">Email Us</span>
        <span class="font-semibold text-xs">parshwaexport108@gmail.com</span>
      </div>
    </a>
  </div>
</aside>

<!-- Shopping Bag Drawer -->
<div id="cartBackdrop" class="fixed inset-0 bg-on-surface/60 backdrop-blur-sm z-50 hidden transition-opacity"></div>
<aside id="cartDrawer" class="fixed top-0 right-0 bottom-0 w-96 max-w-[90vw] bg-surface-container-lowest z-50 shadow-2xl transform translate-x-full transition-transform duration-300 ease-out flex flex-col justify-between p-6">
  <div>
    <div class="flex items-center justify-between pb-4 border-b border-surface-container-high">
      <div class="flex items-center gap-2">
        <span class="material-symbols-outlined text-primary text-[22px]">shopping_bag</span>
        <h3 class="font-headline-sm text-title-lg text-on-surface">Your Jewellery Bag</h3>
      </div>
      <button id="closeCartDrawer" class="p-1.5 text-on-surface-variant hover:text-primary transition-colors" aria-label="Close Bag">
        <span class="material-symbols-outlined text-[22px]">close</span>
      </button>
    </div>
    <div id="cartItemsList" class="divide-y divide-surface-container-high overflow-y-auto max-h-[60vh] mt-2"></div>
  </div>

  <div class="pt-5 border-t border-surface-container-high space-y-3">
    <div class="flex items-center justify-between font-headline-sm text-base">
      <span class="text-on-surface">Estimated Subtotal:</span>
      <span id="cartSubtotal" class="text-primary font-bold">₹0</span>
    </div>
    <p class="font-body-sm text-[11px] text-tertiary leading-tight">
      BIS 916 Hallmarked 22K Gold • Sample prices until verified inventory.
    </p>
    <a id="cartWhatsAppCheckout" href="#" target="_blank" rel="noopener noreferrer" class="w-full py-3.5 bg-gradient-to-r from-[#1E4D2B] to-[#2E7D32] text-white rounded font-label-lg text-label-lg uppercase tracking-[0.16em] flex items-center justify-center gap-2 shadow hover:opacity-95 transition-opacity">
      <span class="material-symbols-outlined text-[18px]">chat</span>
      <span>Enquire on WhatsApp</span>
    </a>
    <a href="tel:+919426557390" class="w-full py-2.5 bg-surface-container-high text-on-surface rounded font-label-md text-label-md uppercase tracking-wider text-center block hover:bg-surface-container-highest transition-colors">
      Call Concierge (+91 94265 57390)
    </a>
  </div>
</aside>

<!-- Wishlist Drawer -->
<div id="wishlistBackdrop" class="fixed inset-0 bg-on-surface/60 backdrop-blur-sm z-50 hidden transition-opacity"></div>
<aside id="wishlistDrawer" class="fixed top-0 right-0 bottom-0 w-96 max-w-[90vw] bg-surface-container-lowest z-50 shadow-2xl transform translate-x-full transition-transform duration-300 ease-out flex flex-col justify-between p-6">
  <div>
    <div class="flex items-center justify-between pb-4 border-b border-surface-container-high">
      <div class="flex items-center gap-2">
        <span class="material-symbols-outlined text-secondary text-[22px]">favorite</span>
        <h3 class="font-headline-sm text-title-lg text-on-surface">Curated Wishlist</h3>
      </div>
      <button id="closeWishlistDrawer" class="p-1.5 text-on-surface-variant hover:text-primary transition-colors" aria-label="Close Wishlist">
        <span class="material-symbols-outlined text-[22px]">close</span>
      </button>
    </div>
    <div id="wishlistItemsList" class="divide-y divide-surface-container-high overflow-y-auto max-h-[65vh] mt-2"></div>
  </div>
  <div class="pt-4 border-t border-surface-container-high">
    <a href="products.html" class="w-full py-3 bg-primary-container text-on-primary-container rounded font-label-md uppercase tracking-wider text-center block hover:bg-secondary hover:text-on-secondary transition-colors">
      Explore All Jewellery
    </a>
  </div>
</aside>

<!-- Search Modal -->
<div id="searchModal" class="fixed inset-0 bg-on-surface/70 backdrop-blur-md z-50 hidden flex items-start justify-center pt-20 p-4">
  <div class="bg-surface-container-lowest max-w-2xl w-full rounded-xl shadow-2xl p-6 space-y-5 relative">
    <div class="flex items-center justify-between pb-3 border-b border-surface-container-high">
      <span class="font-label-md uppercase tracking-widest text-primary text-xs">Catalogue Search</span>
      <button id="closeSearchModal" class="p-1 text-on-surface-variant hover:text-primary">
        <span class="material-symbols-outlined text-[20px]">close</span>
      </button>
    </div>
    <div class="relative">
      <input id="siteSearchInput" type="text" placeholder="Search by gold jewellery name, karat, chokers, bangles, bridal..." class="w-full pl-11 pr-4 py-3.5 bg-surface-container-low text-on-surface rounded-lg font-body-md focus:outline-none focus:bg-surface-container-lowest focus:ring-1 focus:ring-primary-container shadow-inner" />
      <span class="material-symbols-outlined absolute left-3.5 top-3.5 text-primary text-[22px]">search</span>
    </div>
    <div id="searchResultsList" class="max-h-80 overflow-y-auto space-y-1 divide-y divide-surface-container-high/40"></div>
  </div>
</div>

<!-- Quick View Modal -->
<div id="quickViewModal" class="fixed inset-0 z-50 hidden bg-on-surface/65 backdrop-blur-sm flex items-center justify-center p-4">
  <div class="bg-surface-container-lowest rounded-xl max-w-3xl w-full shadow-2xl overflow-hidden relative max-h-[90vh] flex flex-col md:flex-row">
    <button aria-label="Close Preview" class="absolute top-4 right-4 z-20 p-2 rounded-full bg-surface-container-high/90 text-on-surface hover:bg-secondary hover:text-white transition-colors" onclick="closeModal()">
      <span class="material-symbols-outlined text-[20px]">close</span>
    </button>
    <div class="md:w-1/2 bg-surface-container-low p-8 flex items-center justify-center relative">
      <img id="modalImg" class="w-full h-64 md:h-full object-contain mix-blend-multiply" src="assets/images/necklace.jpg" alt="Product View" />
      <span class="absolute bottom-4 left-4 font-label-sm text-[11px] text-tertiary bg-surface-container-lowest/90 px-2.5 py-1 rounded">
        BIS 916 Hallmarked Pure Gold
      </span>
    </div>
    <div class="md:w-1/2 p-6 md:p-8 flex flex-col justify-between overflow-y-auto">
      <div class="space-y-4">
        <div class="inline-flex items-center gap-1.5 px-2.5 py-0.5 bg-primary-fixed text-on-primary-fixed rounded text-xs font-label-sm uppercase tracking-wider">
          <span class="material-symbols-outlined text-[14px]">verified</span>
          <span>Certified Royal Heirloom</span>
        </div>
        <h2 id="modalTitle" class="font-headline-sm text-headline-sm text-on-surface font-medium">Devi Royal Navratna Choker</h2>
        <p id="modalPrice" class="font-headline-sm text-headline-md text-primary font-bold">₹4,20,000</p>
        <div class="p-3.5 bg-surface-container-low rounded-lg space-y-1.5 text-xs font-body-sm">
          <div class="flex justify-between">
            <span class="text-tertiary">Gold Purity:</span>
            <span class="text-on-surface font-semibold">22K (916) BIS Hallmarked</span>
          </div>
          <div class="flex justify-between">
            <span class="text-tertiary">Approx Weight:</span>
            <span id="modalWeight" class="text-on-surface font-semibold">78.50g Pure Gold</span>
          </div>
          <div class="flex justify-between">
            <span class="text-tertiary">Craftsmanship:</span>
            <span class="text-on-surface font-semibold">Handcrafted Royal Karigari</span>
          </div>
        </div>
        <p id="modalDesc" class="font-body-sm text-on-surface-variant leading-relaxed">
          Exquisite 22K pure gold handcrafted creation sculpted by generational karigars.
        </p>
        <p class="text-[11px] text-on-surface-variant/70 italic">
          * Clearly identified sample product &amp; price until verified inventory.
        </p>
      </div>

      <div class="pt-6 space-y-2.5">
        <a id="modalWhatsAppBtn" href="#" target="_blank" rel="noopener noreferrer" class="w-full py-3.5 bg-gradient-to-r from-[#1E4D2B] to-[#2E7D32] text-white font-label-md uppercase tracking-[0.16em] rounded shadow hover:opacity-95 transition-opacity flex items-center justify-center gap-2">
          <span class="material-symbols-outlined text-[18px]">chat</span>
          <span>Enquire on WhatsApp</span>
        </a>
        <button id="modalAddToBagBtn" type="button" class="w-full py-3 bg-primary-container text-on-primary-container font-label-md uppercase tracking-[0.16em] rounded shadow hover:bg-secondary hover:text-on-secondary transition-colors flex items-center justify-center gap-2">
          <span class="material-symbols-outlined text-[18px]">shopping_bag</span>
          <span>Add to Jewellery Bag</span>
        </button>
      </div>
    </div>
  </div>
</div>

<!-- Floating Quick-Contact Widgets -->
<aside aria-label="Quick Concierge Contact" class="fixed bottom-20 sm:bottom-8 right-5 z-40 flex flex-col items-end gap-3 pointer-events-auto">
  <a href="tel:+919426557390" title="Call Concierge (+91 94265 57390)" class="floating-quick-btn w-12 h-12 rounded-full bg-primary text-on-primary flex items-center justify-center shadow-2xl hover:bg-secondary transition-colors group relative">
    <span class="material-symbols-outlined text-[24px]">call</span>
    <span class="absolute right-14 bg-inverse-surface text-surface-bright font-label-sm text-[10px] uppercase tracking-wider py-1 px-2.5 rounded shadow-lg whitespace-nowrap opacity-0 group-hover:opacity-100 transition-opacity pointer-events-none">
      Call: +91 94265 57390
    </span>
  </a>

  <a href="https://wa.me/919426557390?text=Hello%20PRINCESS%20JEWELS%2C%20I%20am%20interested%20in%20your%20jewellery%20collections.%20Please%20share%20more%20details." target="_blank" rel="noopener noreferrer" title="Chat on WhatsApp" class="floating-quick-btn w-14 h-14 rounded-full bg-[#25D366] text-white flex items-center justify-center shadow-2xl hover:bg-[#1EBE5D] transition-transform relative group">
    <svg class="w-8 h-8 fill-current" viewBox="0 0 24 24">
      <path d="M12.04 2C6.58 2 2.13 6.45 2.13 11.91C2.13 13.66 2.59 15.36 3.45 16.86L2.05 22L7.3 20.62C8.75 21.41 10.38 21.83 12.04 21.83C17.5 21.83 21.95 17.38 21.95 11.92C21.95 9.27 20.92 6.78 19.05 4.91C17.18 3.03 14.69 2 12.04 2M12.05 3.67C14.25 3.67 16.31 4.53 17.87 6.09C19.42 7.65 20.28 9.72 20.28 11.92C20.28 16.46 16.58 20.15 12.04 20.15C10.56 20.15 9.11 19.76 7.85 19.01L7.55 18.83L4.43 19.65L5.26 16.61L5.06 16.29C4.24 14.99 3.81 13.47 3.81 11.91C3.81 7.37 7.5 3.67 12.05 3.67M9.11 7.03C8.94 7.03 8.66 7.1 8.42 7.35C8.18 7.61 7.5 8.25 7.5 9.54C7.5 10.83 8.44 12.07 8.57 12.24C8.7 12.41 10.37 15.11 13 16.14C15.19 17 15.63 16.83 16.1 16.79C16.57 16.75 17.62 16.16 17.84 15.54C18.06 14.92 18.06 14.39 18 14.28C17.94 14.17 17.77 14.11 17.52 13.98C17.27 13.85 16.05 13.25 15.82 13.17C15.59 13.09 15.42 13.05 15.25 13.3C15.08 13.55 14.6 14.11 14.45 14.28C14.3 14.45 14.15 14.47 13.9 14.35C13.65 14.22 12.85 13.96 11.9 13.11C11.16 12.45 10.66 11.64 10.51 11.39C10.36 11.14 10.49 11 10.62 10.88C10.73 10.77 10.87 10.59 11 10.44C11.13 10.29 11.17 10.18 11.25 10.02C11.33 9.85 11.29 9.71 11.23 9.58C11.17 9.45 10.66 8.21 10.45 7.71C10.24 7.22 10.03 7.29 9.88 7.28C9.74 7.28 9.57 7.28 9.4 7.28L9.11 7.03Z"/>
    </svg>
    <span class="absolute right-16 bg-inverse-surface text-surface-bright font-label-sm text-[10px] uppercase tracking-wider py-1 px-2.5 rounded shadow-lg whitespace-nowrap opacity-0 group-hover:opacity-100 transition-opacity pointer-events-none">
      WhatsApp Concierge
    </span>
  </a>
</aside>

<!-- Mobile Bottom Sticky Navigation (<768px) -->
<nav aria-label="Mobile Quick Actions" class="md:hidden fixed bottom-0 left-0 right-0 z-40 bg-surface-container-lowest/95 backdrop-blur-md border-t border-surface-container-high py-2 px-4 flex items-center justify-around shadow-[0_-4px_16px_rgba(0,0,0,0.06)]">
  <a href="tel:+919426557390" class="flex flex-col items-center text-on-surface-variant hover:text-primary transition-colors">
    <span class="material-symbols-outlined text-[20px]">call</span>
    <span class="font-label-sm text-[9px] uppercase tracking-wider mt-0.5">Call</span>
  </a>
  <a href="https://wa.me/919426557390?text=Hello%20PRINCESS%20JEWELS%2C%20I%20am%20interested%20in%20your%20jewellery%20collections.%20Please%20share%20more%20details." target="_blank" rel="noopener noreferrer" class="flex flex-col items-center text-[#2E7D32]">
    <span class="material-symbols-outlined text-[20px]">chat</span>
    <span class="font-label-sm text-[9px] uppercase tracking-wider mt-0.5">WhatsApp</span>
  </a>
  <a href="products.html" class="flex flex-col items-center text-on-surface-variant hover:text-primary transition-colors">
    <span class="material-symbols-outlined text-[20px]">diamond</span>
    <span class="font-label-sm text-[9px] uppercase tracking-wider mt-0.5">Shop</span>
  </a>
  <a href="bridal.html" class="flex flex-col items-center text-on-surface-variant hover:text-primary transition-colors">
    <span class="material-symbols-outlined text-[20px]">celebration</span>
    <span class="font-label-sm text-[9px] uppercase tracking-wider mt-0.5">Bridal</span>
  </a>
  <a href="#" data-action="open-cart" class="relative flex flex-col items-center text-on-surface-variant hover:text-primary transition-colors">
    <span class="material-symbols-outlined text-[20px]">shopping_bag</span>
    <span class="cart-count-badge absolute -top-1 right-2 bg-primary-container text-on-primary-container font-label-sm text-[8px] w-3.5 h-3.5 rounded-full flex items-center justify-center font-bold">1</span>
    <span class="font-label-sm text-[9px] uppercase tracking-wider mt-0.5">Bag</span>
  </a>
</nav>

<script src="assets/script.js"></script>
</body>
</html>
'@

$content = [System.Text.RegularExpressions.Regex]::Replace($content, '<\/body>\s*<\/html>', $sharedComponents, [System.Text.RegularExpressions.RegexOptions]::Singleline)

[System.IO.File]::WriteAllText("index.html", $content, [System.Text.Encoding]::UTF8)
Write-Host "Successfully generated index.html (Length: $($content.Length))"
