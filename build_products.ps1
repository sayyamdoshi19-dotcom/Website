$ErrorActionPreference = "Stop"

$root = $PSScriptRoot
if (-not $root) { $root = "." }

. "$root\build_all.ps1"

Write-Host "Building products.html..."
$colRaw = [System.IO.File]::ReadAllText("$root\stitch_source\stitch_princess_jewels_luxury_website\collections_princess_jewels\code.html", [System.Text.Encoding]::UTF8)
$colEnhanced = Enhance-PageContent $colRaw "collections"

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
</ul>
'@

$newCategoryList = @'
<ul class="space-y-1.5 font-body-md text-body-md text-on-surface-variant">
  <li>
    <button data-category-filter="all" class="w-full text-left flex items-center justify-between font-semibold text-primary py-1.5 px-2 rounded hover:bg-surface-container transition-colors">
      <span>All Fine Jewellery</span>
      <span class="font-label-sm text-label-sm text-tertiary">14</span>
    </button>
  </li>
  <li>
    <button data-category-filter="necklaces" class="w-full text-left flex items-center justify-between hover:text-primary py-1.5 px-2 rounded hover:bg-surface-container transition-colors">
      <span>Gold Necklaces</span>
      <span class="font-label-sm text-label-sm text-tertiary">3</span>
    </button>
  </li>
  <li>
    <button data-category-filter="bridal" class="w-full text-left flex items-center justify-between hover:text-primary py-1.5 px-2 rounded hover:bg-surface-container transition-colors">
      <span>Bridal Jewellery</span>
      <span class="font-label-sm text-label-sm text-tertiary">3</span>
    </button>
  </li>
  <li>
    <button data-category-filter="earrings" class="w-full text-left flex items-center justify-between hover:text-primary py-1.5 px-2 rounded hover:bg-surface-container transition-colors">
      <span>Earrings &amp; Jhumkas</span>
      <span class="font-label-sm text-label-sm text-tertiary">3</span>
    </button>
  </li>
  <li>
    <button data-category-filter="bangles" class="w-full text-left flex items-center justify-between hover:text-primary py-1.5 px-2 rounded hover:bg-surface-container transition-colors">
      <span>Bangles &amp; Bracelets</span>
      <span class="font-label-sm text-label-sm text-tertiary">3</span>
    </button>
  </li>
  <li>
    <button data-category-filter="rings" class="w-full text-left flex items-center justify-between hover:text-primary py-1.5 px-2 rounded hover:bg-surface-container transition-colors">
      <span>Rings &amp; Signets</span>
      <span class="font-label-sm text-label-sm text-tertiary">2</span>
    </button>
  </li>
  <li>
    <button data-category-filter="traditional" class="w-full text-left flex items-center justify-between hover:text-primary py-1.5 px-2 rounded hover:bg-surface-container transition-colors">
      <span>Traditional Jewellery</span>
      <span class="font-label-sm text-label-sm text-tertiary">2</span>
    </button>
  </li>
  <li>
    <button data-category-filter="contemporary" class="w-full text-left flex items-center justify-between hover:text-primary py-1.5 px-2 rounded hover:bg-surface-container transition-colors">
      <span>Contemporary Jewellery</span>
      <span class="font-label-sm text-label-sm text-tertiary">1</span>
    </button>
  </li>
</ul>
'@

$colEnhanced = $colEnhanced.Replace($oldCategoryList, $newCategoryList)

# Update price checkboxes
$oldPriceList = @'
<div class="space-y-2">
<label class="flex items-center gap-3 cursor-pointer group">
<input class="accent-primary w-4 h-4 rounded" type="checkbox"/>
<span class="font-body-sm text-body-sm text-on-surface-variant group-hover:text-primary transition-colors">Under ₹1,00,000</span>
</label>
<label class="flex items-center gap-3 cursor-pointer group">
<input checked="" class="accent-primary w-4 h-4 rounded" type="checkbox"/>
<span class="font-body-sm text-body-sm text-on-surface-variant group-hover:text-primary transition-colors">₹1,00,000 – ₹2,50,000</span>
</label>
<label class="flex items-center gap-3 cursor-pointer group">
<input checked="" class="accent-primary w-4 h-4 rounded" type="checkbox"/>
<span class="font-body-sm text-body-sm text-on-surface-variant group-hover:text-primary transition-colors">₹2,50,000 – ₹5,00,000</span>
</label>
<label class="flex items-center gap-3 cursor-pointer group">
<input class="accent-primary w-4 h-4 rounded" type="checkbox"/>
<span class="font-body-sm text-body-sm text-on-surface-variant group-hover:text-primary transition-colors">₹5,00,000 &amp; Above</span>
</label>
</div>
'@

$newPriceList = @'
<div class="space-y-2">
  <label class="flex items-center gap-3 cursor-pointer group">
    <input data-price-filter="true" value="under-100k" class="accent-primary w-4 h-4 rounded" type="checkbox"/>
    <span class="font-body-sm text-body-sm text-on-surface-variant group-hover:text-primary transition-colors">Under ₹1,00,000</span>
  </label>
  <label class="flex items-center gap-3 cursor-pointer group">
    <input data-price-filter="true" value="100k-250k" class="accent-primary w-4 h-4 rounded" type="checkbox"/>
    <span class="font-body-sm text-body-sm text-on-surface-variant group-hover:text-primary transition-colors">₹1,00,000 – ₹2,50,000</span>
  </label>
  <label class="flex items-center gap-3 cursor-pointer group">
    <input data-price-filter="true" value="250k-500k" class="accent-primary w-4 h-4 rounded" type="checkbox"/>
    <span class="font-body-sm text-body-sm text-on-surface-variant group-hover:text-primary transition-colors">₹2,50,000 – ₹5,00,000</span>
  </label>
  <label class="flex items-center gap-3 cursor-pointer group">
    <input data-price-filter="true" value="above-500k" class="accent-primary w-4 h-4 rounded" type="checkbox"/>
    <span class="font-body-sm text-body-sm text-on-surface-variant group-hover:text-primary transition-colors">₹5,00,000 &amp; Above</span>
  </label>
</div>
'@

$colEnhanced = $colEnhanced.Replace($oldPriceList, $newPriceList)

# Reset filters button ID
$colEnhanced = $colEnhanced.Replace('Reset Filters', 'Reset Filters" id="resetFiltersBtn')

# Sort select & header
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

# Update showing count text
$colEnhanced = $colEnhanced.Replace('<p class="font-body-sm text-body-sm text-tertiary">Showing 9 of 24 pieces</p>', '<p id="filteredCountDisplay" class="font-body-sm text-body-sm text-tertiary font-medium">Showing curated creations</p><p class="text-xs text-on-surface-variant/70 italic mt-1">* Clearly identified sample products &amp; prices until verified inventory is provided.</p>')

# Add data attributes and WhatsApp buttons to products
$colEnhanced = $colEnhanced.Replace("onclick=`"openModal('Devi Royal Navratna Choker'", "data-product-card=`"true`" onclick=`"openModal('Devi Royal Navratna Choker'")

# Tag specific articles by unique titles
$colEnhanced = $colEnhanced.Replace('<!-- Product Card 1 -->`n<article class="group bg-surface-container-lowest', '<!-- Product Card 1 -->`n<article data-product-category="necklaces" data-product-price="420000" class="group bg-surface-container-lowest')
$colEnhanced = $colEnhanced.Replace('<!-- Product Card 2 -->`n<article class="group bg-surface-container-lowest', '<!-- Product Card 2 -->`n<article data-product-category="bangles" data-product-price="340000" class="group bg-surface-container-lowest')
$colEnhanced = $colEnhanced.Replace('<!-- Product Card 3 -->`n<article class="group bg-surface-container-lowest', '<!-- Product Card 3 -->`n<article data-product-category="bridal" data-product-price="680000" class="group bg-surface-container-lowest')
$colEnhanced = $colEnhanced.Replace('<!-- Product Card 4 -->`n<article class="group bg-surface-container-lowest', '<!-- Product Card 4 -->`n<article data-product-category="earrings" data-product-price="145000" class="group bg-surface-container-lowest')
$colEnhanced = $colEnhanced.Replace('<!-- Product Card 5 -->`n<article class="group bg-surface-container-lowest', '<!-- Product Card 5 -->`n<article data-product-category="rings" data-product-price="95000" class="group bg-surface-container-lowest')
$colEnhanced = $colEnhanced.Replace('<!-- Product Card 6 -->`n<article class="group bg-surface-container-lowest', '<!-- Product Card 6 -->`n<article data-product-category="bridal" data-product-price="550000" class="group bg-surface-container-lowest')
$colEnhanced = $colEnhanced.Replace('<!-- Product Card 7 -->`n<article class="group bg-surface-container-lowest', '<!-- Product Card 7 -->`n<article data-product-category="contemporary" data-product-price="185000" class="group bg-surface-container-lowest')
$colEnhanced = $colEnhanced.Replace('<!-- Product Card 8 -->`n<article class="group bg-surface-container-lowest', '<!-- Product Card 8 -->`n<article data-product-category="traditional" data-product-price="210000" class="group bg-surface-container-lowest')
$colEnhanced = $colEnhanced.Replace('<!-- Product Card 9 -->`n<article class="group bg-surface-container-lowest', '<!-- Product Card 9 -->`n<article data-product-category="traditional" data-product-price="395000" class="group bg-surface-container-lowest')

# Save products.html and copy to collections.html
[System.IO.File]::WriteAllText("$root\products.html", $colEnhanced, [System.Text.Encoding]::UTF8)
[System.IO.File]::WriteAllText("$root\collections.html", $colEnhanced, [System.Text.Encoding]::UTF8)
Write-Host "products.html and collections.html generated successfully ($($colEnhanced.Length) bytes)"
