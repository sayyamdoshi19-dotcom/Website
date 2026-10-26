$ErrorActionPreference = "Stop"

$root = $PSScriptRoot
if (-not $root) { $root = "." }

. "$root\build_all.ps1"

Write-Host "Building contact.html..."
$contactRaw = [System.IO.File]::ReadAllText("$root\stitch_source\stitch_princess_jewels_luxury_website\contact_us_princess_jewels\code.html", [System.Text.Encoding]::UTF8)
$contactEnhanced = Enhance-PageContent $contactRaw "contact"

# Replace Form in Column 1 with the exact required fields
$oldFormRegex = '<form class="space-y-6" id="enquiryForm".*?<\/form>'

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

    <!-- Jewellery Category Selector -->
    <div class="space-y-1.5">
      <label class="block font-label-md text-label-md uppercase text-on-surface-variant tracking-wider" for="jewelleryCategory">
        Jewellery Category
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
    <textarea class="w-full bg-surface-container-low text-on-surface px-4 py-3 rounded text-body-md placeholder:text-outline-variant/70 focus:outline-none focus:bg-surface-container-lowest focus:ring-1 focus:ring-primary shadow-inner transition-colors resize-none" id="messageBody" name="messageBody" placeholder="Please outline your enquiry, event date, custom jewellery design ideas, or specific piece interest..." rows="4" required></textarea>
  </div>

  <!-- Discretion Note -->
  <div class="flex items-center gap-3 py-2.5 px-3.5 bg-surface-container-low rounded-lg border border-outline-variant/30">
    <span class="material-symbols-outlined text-primary text-[20px]">verified_user</span>
    <p class="font-body-sm text-xs text-on-surface-variant">
      Your privacy is safeguarded. Enquiries are treated with complete confidentiality.
    </p>
  </div>

  <!-- Submit Button -->
  <div class="pt-2">
    <button class="w-full sm:w-auto inline-flex items-center justify-center gap-3 px-10 py-4 bg-primary-container text-on-primary-container font-label-lg text-label-lg tracking-[0.2em] uppercase rounded shadow-md hover:bg-secondary hover:text-on-secondary transition-all duration-300" id="submitBtn" type="submit">
      <span>Submit Enquiry</span>
      <span class="material-symbols-outlined text-[18px]">arrow_forward</span>
    </button>
  </div>

  <!-- Success & Delivery Guidance Box -->
  <div class="hidden p-5 rounded-lg bg-surface-container-low border border-primary-container/40 transition-all space-y-4" id="formFeedback">
    <!-- Populated by JavaScript -->
  </div>
</form>
'@

$contactEnhanced = [System.Text.RegularExpressions.Regex]::Replace($contactEnhanced, $oldFormRegex, $newFormHtml, [System.Text.RegularExpressions.RegexOptions]::Singleline)

# Replace Column 2 Contact details with real phone, email, and honest placeholders
$oldCol2Regex = '<!-- Flagship Boutique Card -->.*?<!-- Social Channels & Heritage Touchpoints -->'

$newCol2Html = @'
<!-- Flagship Salon & Concierge Card -->
<div class="bg-surface-container p-6 sm:p-8 rounded-xl shadow-sm relative overflow-hidden space-y-6">
  <div class="space-y-2">
    <span class="font-label-sm text-label-sm text-primary tracking-[0.25em] uppercase font-semibold">PRINCESS JEWELS</span>
    <h3 class="font-headline-md text-headline-md text-on-surface">THE ART OF GOLDEN ELEGANCE</h3>
    <p class="font-body-sm text-on-surface-variant">Private Consultation Salon &amp; Bespoke Goldsmithing</p>
  </div>

  <!-- Phone & Click-to-Call -->
  <div class="flex items-start gap-3.5 text-on-surface">
    <div class="w-9 h-9 rounded-full bg-primary-container/20 text-primary flex items-center justify-center shrink-0 mt-0.5">
      <span class="material-symbols-outlined text-[20px]">call</span>
    </div>
    <div>
      <h4 class="font-label-md text-label-md uppercase text-on-surface-variant tracking-wider">Contact Number</h4>
      <div class="mt-1 flex flex-wrap items-center gap-3">
        <a href="tel:+919426557390" class="font-headline-sm text-base text-primary hover:text-secondary font-bold flex items-center gap-1.5" title="Click to call from your device">
          <span>+91 94265 57390</span>
          <span class="material-symbols-outlined text-sm">phone_forwarded</span>
        </a>
        <a href="tel:+919426557390" class="px-3 py-1 bg-primary text-on-primary font-label-sm text-[10px] uppercase tracking-wider rounded hover:bg-secondary transition-colors">
          CLICK TO CALL
        </a>
      </div>
      <p class="text-[11px] text-tertiary mt-1">Direct patron line. Mobile dialler launches automatically on tap.</p>
    </div>
  </div>

  <!-- Business Email -->
  <div class="flex items-start gap-3.5 text-on-surface">
    <div class="w-9 h-9 rounded-full bg-primary-container/20 text-primary flex items-center justify-center shrink-0 mt-0.5">
      <span class="material-symbols-outlined text-[20px]">mail</span>
    </div>
    <div>
      <h4 class="font-label-md text-label-md uppercase text-on-surface-variant tracking-wider">Business Email</h4>
      <div class="mt-1 flex flex-wrap items-center gap-3">
        <a href="mailto:parshwaexport108@gmail.com" class="font-body-md text-body-md text-primary font-medium hover:underline break-all" title="Send email">
          parshwaexport108@gmail.com
        </a>
        <a href="mailto:parshwaexport108@gmail.com" class="px-3 py-1 bg-primary-container text-on-primary-container font-label-sm text-[10px] uppercase tracking-wider rounded hover:bg-secondary hover:text-white transition-colors">
          EMAIL US
        </a>
      </div>
      <p class="text-[11px] text-tertiary mt-1">Official business communications and export inquiries.</p>
    </div>
  </div>

  <!-- Business Address Placeholder -->
  <div class="flex items-start gap-3.5 text-on-surface">
    <div class="w-9 h-9 rounded-full bg-primary-container/20 text-primary flex items-center justify-center shrink-0 mt-0.5">
      <span class="material-symbols-outlined text-[20px]">location_on</span>
    </div>
    <div>
      <h4 class="font-label-md text-label-md uppercase text-on-surface-variant tracking-wider">Showroom &amp; Atelier Address</h4>
      <p class="font-body-md text-body-md text-on-surface mt-1 leading-relaxed">
        [Showroom &amp; Atelier Address Placeholder]<br/>
        <span class="text-xs text-tertiary">Private salon viewings by prior appointment. Please call or WhatsApp ahead.</span>
      </p>
    </div>
  </div>

  <!-- Business Hours Placeholder -->
  <div class="flex items-start gap-3.5 text-on-surface">
    <div class="w-9 h-9 rounded-full bg-primary-container/20 text-primary flex items-center justify-center shrink-0 mt-0.5">
      <span class="material-symbols-outlined text-[20px]">schedule</span>
    </div>
    <div>
      <h4 class="font-label-md text-label-md uppercase text-on-surface-variant tracking-wider">Business &amp; Salon Hours</h4>
      <p class="font-body-md text-body-md text-on-surface mt-1 leading-relaxed">
        [Business Hours Placeholder — Monday to Saturday, By Appointment]<br/>
        <span class="text-xs text-tertiary">Dedicated private bridal appointments scheduled upon request.</span>
      </p>
    </div>
  </div>

  <!-- Direct WhatsApp Concierge Button -->
  <a aria-label="Direct WhatsApp Concierge" class="group w-full p-4 rounded-xl bg-gradient-to-r from-[#1E4D2B] to-[#2E7D32] text-white flex items-center justify-between shadow-lg hover:shadow-xl transition-all duration-300" href="https://wa.me/919426557390?text=Hello%20PRINCESS%20JEWELS%2C%20I%20am%20interested%20in%20your%20jewellery%20collections.%20Please%20share%20more%20details." target="_blank" rel="noopener noreferrer">
    <div class="flex items-center gap-3">
      <div class="w-10 h-10 rounded-full bg-white/10 flex items-center justify-center text-primary-fixed-dim shrink-0">
        <span class="material-symbols-outlined text-[24px]">chat</span>
      </div>
      <div>
        <span class="font-label-sm text-[10px] uppercase tracking-[0.2em] text-primary-fixed block">VIP Priority WhatsApp</span>
        <span class="font-headline-sm text-sm text-white group-hover:text-primary-fixed-dim transition-colors">
          Chat Directly on WhatsApp (+91 94265 57390)
        </span>
      </div>
    </div>
    <span class="material-symbols-outlined text-[20px] text-primary-fixed shrink-0">arrow_forward</span>
  </a>
</div>
<!-- Social Channels & Heritage Touchpoints -->
'@

$contactEnhanced = [System.Text.RegularExpressions.Regex]::Replace($contactEnhanced, $oldCol2Regex, $newCol2Html, [System.Text.RegularExpressions.RegexOptions]::Singleline)

# Update Map Section to be an honest Map Placeholder
$oldMapRegex = '<!-- VISUAL BOUTIQUE VITRINE & INTERACTIVE MAP SECTION -->.*?<!-- PRIVATE SALON EXPERIENCE FAQ'
$newMapHtml = @'
<!-- VISUAL VITRINE & MAP PLACEHOLDER SECTION -->
<section class="w-full py-16 bg-surface-container-low">
  <div class="max-w-7xl mx-auto px-margin-mobile md:px-margin-tablet lg:px-margin space-y-10">
    <div class="flex flex-col md:flex-row md:items-end justify-between gap-4">
      <div>
        <span class="font-label-md text-label-md uppercase tracking-[0.25em] text-primary block">Private Sanctum</span>
        <h2 class="font-headline-lg text-headline-lg text-on-surface tracking-tight mt-1">Showroom &amp; Atelier Location</h2>
      </div>
      <p class="font-body-md text-body-md text-on-surface-variant max-w-md">
        Private salon viewings conducted in secluded chambers with master gemmologist guidance.
      </p>
    </div>

    <!-- Map Placeholder & Vitrine Mosaic -->
    <div class="grid grid-cols-1 lg:grid-cols-12 gap-8 items-stretch">
      <div class="lg:col-span-7 relative rounded-xl overflow-hidden shadow-lg group min-h-[380px]">
        <div class="bg-cover bg-center w-full h-full transform transition-transform duration-700 group-hover:scale-105" style="background-image: url('assets/images/uploaded_packaging_boxes.jpg');"></div>
        <div class="absolute inset-0 bg-gradient-to-t from-on-surface/90 via-on-surface/30 to-transparent flex flex-col justify-end p-8 text-surface-bright">
          <span class="font-label-sm text-label-sm uppercase tracking-[0.25em] text-primary-fixed-dim">PRINCESS JEWELS Atelier</span>
          <h3 class="font-headline-md text-headline-md mt-1">Bespoke Bridal Salon</h3>
          <p class="font-body-sm text-body-sm text-surface-container-high/90 max-w-lg mt-2 leading-relaxed">
            Reserved exclusively for bespoke bridal viewings, certified gold assays, and custom family heirloom commissions.
          </p>
        </div>
      </div>

      <!-- Map Placeholder Card -->
      <div class="lg:col-span-5 bg-surface-container-lowest rounded-xl overflow-hidden shadow-lg flex flex-col justify-between p-7 border border-primary-container/20">
        <div class="space-y-4">
          <div class="w-12 h-12 rounded-full bg-primary-fixed/40 text-primary flex items-center justify-center">
            <span class="material-symbols-outlined text-[26px]">pin_drop</span>
          </div>
          <h3 class="font-headline-sm text-title-lg text-on-surface">Location Map Placeholder</h3>
          <p class="font-body-md text-body-md text-on-surface-variant leading-relaxed">
            [Map Placeholder — Physical showroom address provided upon consultation appointment confirmation.]
          </p>
          <div class="p-3.5 bg-surface-container-low rounded-lg space-y-1 text-xs font-body-sm text-on-surface-variant">
            <p>• <strong>Telephone:</strong> +91 94265 57390</p>
            <p>• <strong>Email:</strong> parshwaexport108@gmail.com</p>
            <p>• <strong>Mode:</strong> In-Boutique Suite or Virtual Video Concierge</p>
          </div>
        </div>

        <div class="pt-6">
          <a href="https://wa.me/919426557390?text=Hello%20PRINCESS%20JEWELS%2C%20I%20would%20like%20to%20request%20the%20exact%20showroom%20location%20and%20directions." target="_blank" rel="noopener noreferrer" class="w-full py-3 bg-primary-container text-on-primary-container font-label-md text-label-md uppercase tracking-wider rounded text-center block hover:bg-secondary hover:text-white transition-colors">
            Request Showroom Directions on WhatsApp
          </a>
        </div>
      </div>
    </div>
  </div>
</section>
<!-- PRIVATE SALON EXPERIENCE FAQ
'@

$contactEnhanced = [System.Text.RegularExpressions.Regex]::Replace($contactEnhanced, $oldMapRegex, $newMapHtml, [System.Text.RegularExpressions.RegexOptions]::Singleline)

# Save contact.html and copy to contact-us.html
[System.IO.File]::WriteAllText("$root\contact.html", $contactEnhanced, [System.Text.Encoding]::UTF8)
[System.IO.File]::WriteAllText("$root\contact-us.html", $contactEnhanced, [System.Text.Encoding]::UTF8)
Write-Host "contact.html and contact-us.html generated successfully ($($contactEnhanced.Length) bytes)"
