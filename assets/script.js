/**
 * PRINCESS JEWELS — Interactive Haute Joaillerie Client-Side Engine
 * Brand: PRINCESS JEWELS
 * Tagline: THE ART OF GOLDEN ELEGANCE
 * Phone: +91 94265 57390
 * Email: parshwaexport108@gmail.com
 * WhatsApp: https://wa.me/919426557390
 */

// Global State
const PJ_CONFIG = {
  phone: '+91 94265 57390',
  phoneTel: '+919426557390',
  email: 'parshwaexport108@gmail.com',
  whatsappBase: 'https://wa.me/919426557390',
  defaultWhatsAppMsg: 'Hello PRINCESS JEWELS, I am interested in your jewellery collections. Please share more details.',
  bridalWhatsAppMsg: 'Hello PRINCESS JEWELS, I am interested in your bridal jewellery collection. Please share more details.'
};

// Initial Cart & Wishlist storage
let pjCart = JSON.parse(localStorage.getItem('pj_cart')) || [
  {
    id: 'prod-1',
    name: 'Devi Royal Navratna Choker',
    price: '₹4,20,000',
    priceNum: 420000,
    weight: '78.50g Pure Gold',
    purity: '22K (916) BIS Hallmarked',
    image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAsi_Kr5QBdj2cccqZLJ5Gm7SF_LeEsJ8tUvL0r7FjeH4jFBlVImswquBZTza835TC-3A-0cauV-DfVtjcak72NBT46rWcBd761GdE9n1PfJ4yuD_Q4wku22M_N50Y0YjWoZwLdL5EwHYj8y0SqobHN-wD2vddKD6_FDAnvxB7pj7GTDivan55e0Ids3jBXDiM1DUtvzKKA4Yr-9CRNHykxS4I16Hnc75UOtjN17-hN_7LD93wTchkQ'
  }
];

let pjWishlist = JSON.parse(localStorage.getItem('pj_wishlist')) || [
  'Devi Royal Navratna Choker',
  'Mayura Filigree Kada Pair',
  'Sultana Layered Polki Haar'
];

// Document Ready
document.addEventListener('DOMContentLoaded', () => {
  initMobileMenu();
  initHeroSlideshow();
  initCartAndWishlist();
  initSearchModal();
  initCategoryFilters();
  initContactForm();
  initBridalBookingForm();
  initBackToTop();
  initNewsletterVipForms();
  updateBadges();
});

/* ----------------------------------------------------
   1. MOBILE NAVIGATION DRAWER
---------------------------------------------------- */
function initMobileMenu() {
  const toggleBtn = document.getElementById('mobileMenuToggle');
  const drawer = document.getElementById('mobileNavDrawer');
  const backdrop = document.getElementById('mobileNavBackdrop');
  const closeBtn = document.getElementById('mobileNavClose');

  if (toggleBtn && drawer) {
    toggleBtn.addEventListener('click', () => {
      drawer.classList.remove('-translate-x-full');
      if (backdrop) backdrop.classList.remove('hidden');
      document.body.style.overflow = 'hidden';
    });
  }

  function closeDrawer() {
    if (drawer) drawer.classList.add('-translate-x-full');
    if (backdrop) backdrop.classList.add('hidden');
    document.body.style.overflow = '';
  }

  if (closeBtn) closeBtn.addEventListener('click', closeDrawer);
  if (backdrop) backdrop.addEventListener('click', closeDrawer);

  // Close on link click
  if (drawer) {
    drawer.querySelectorAll('a').forEach(link => {
      link.addEventListener('click', closeDrawer);
    });
  }
}

/* ----------------------------------------------------
   2. CONTINUOUS 3-SECOND AUTOMATIC HERO SLIDESHOW
---------------------------------------------------- */
function initHeroSlideshow() {
  const slideshow = document.getElementById('heroSlideshow');
  if (!slideshow) return;

  const slides = slideshow.querySelectorAll('.hero-slide');
  const indicators = document.querySelectorAll('.hero-dot');
  const prevBtn = document.getElementById('heroPrevBtn');
  const nextBtn = document.getElementById('heroNextBtn');
  const slideCount = slides.length;
  if (slideCount === 0) return;

  let currentIndex = 0;
  let slideInterval = null;
  const INTERVAL_MS = 4500; // Relaxed royal interval (4.5s)

  function showSlide(index) {
    currentIndex = (index + slideCount) % slideCount;
    slides.forEach((slide, i) => {
      if (i === currentIndex) {
        slide.classList.remove('opacity-0', 'pointer-events-none');
        slide.classList.add('opacity-100', 'pointer-events-auto');
        slide.style.zIndex = '1';
        const img = slide.querySelector('.hero-bg-img');
        if (img) {
          img.style.transform = 'scale(1.05)';
        }
      } else {
        slide.classList.remove('opacity-100', 'pointer-events-auto');
        slide.classList.add('opacity-0', 'pointer-events-none');
        slide.style.zIndex = '0';
        const img = slide.querySelector('.hero-bg-img');
        if (img) {
          img.style.transform = 'scale(1)';
        }
      }
    });

    indicators.forEach((dot, i) => {
      if (i === currentIndex) {
        dot.classList.remove('bg-surface-container-high/40');
        dot.classList.add('bg-primary-container', 'w-8');
      } else {
        dot.classList.remove('bg-primary-container', 'w-8');
        dot.classList.add('bg-surface-container-high/40', 'w-2.5');
      }
    });
  }

  function startAutoplay() {
    stopAutoplay();
    slideInterval = setInterval(() => {
      showSlide(currentIndex + 1);
    }, INTERVAL_MS);
  }

  function stopAutoplay() {
    if (slideInterval) {
      clearInterval(slideInterval);
      slideInterval = null;
    }
  }

  if (prevBtn) {
    prevBtn.addEventListener('click', (e) => {
      e.preventDefault();
      showSlide(currentIndex - 1);
      startAutoplay();
    });
  }

  if (nextBtn) {
    nextBtn.addEventListener('click', (e) => {
      e.preventDefault();
      showSlide(currentIndex + 1);
      startAutoplay();
    });
  }

  indicators.forEach((dot, idx) => {
    dot.addEventListener('click', () => {
      showSlide(idx);
      startAutoplay();
    });
  });

  // Pause on hover
  slideshow.addEventListener('mouseenter', stopAutoplay);
  slideshow.addEventListener('mouseleave', startAutoplay);

  // Mobile Touch-Swipe Support (MOBILE ISSUE #2)
  let touchStartX = 0;
  slideshow.addEventListener('touchstart', e => {
    if (e.touches && e.touches[0]) {
      touchStartX = e.touches[0].clientX;
    }
  }, { passive: true });
  slideshow.addEventListener('touchend', e => {
    if (e.changedTouches && e.changedTouches[0]) {
      const diff = touchStartX - e.changedTouches[0].clientX;
      if (Math.abs(diff) > 50) {
        if (diff > 0) showSlide(currentIndex + 1);
        else showSlide(currentIndex - 1);
        startAutoplay();
      }
    }
  }, { passive: true });

  // Initial display & autoplay start
  showSlide(0);
  startAutoplay();
}

/* ----------------------------------------------------
   3. CART & WISHLIST MODULE
---------------------------------------------------- */
function initCartAndWishlist() {
  // Bind Cart Drawer buttons
  document.querySelectorAll('[data-action="open-cart"]').forEach(btn => {
    btn.addEventListener('click', (e) => {
      e.preventDefault();
      openCartDrawer();
    });
  });

  const closeCartBtn = document.getElementById('closeCartDrawer');
  const cartBackdrop = document.getElementById('cartBackdrop');
  if (closeCartBtn) closeCartBtn.addEventListener('click', closeCartDrawer);
  if (cartBackdrop) cartBackdrop.addEventListener('click', closeCartDrawer);

  // Bind Wishlist Drawer buttons
  document.querySelectorAll('[data-action="open-wishlist"]').forEach(btn => {
    btn.addEventListener('click', (e) => {
      e.preventDefault();
      openWishlistDrawer();
    });
  });

  const closeWishlistBtn = document.getElementById('closeWishlistDrawer');
  const wishlistBackdrop = document.getElementById('wishlistBackdrop');
  if (closeWishlistBtn) closeWishlistBtn.addEventListener('click', closeWishlistDrawer);
  if (wishlistBackdrop) wishlistBackdrop.addEventListener('click', closeWishlistDrawer);

  renderCartDrawer();
  renderWishlistDrawer();
}

function updateBadges() {
  const cartBadges = document.querySelectorAll('.cart-count-badge');
  cartBadges.forEach(b => {
    b.textContent = pjCart.length;
    b.style.display = pjCart.length > 0 ? 'flex' : 'none';
  });

  const wishBadges = document.querySelectorAll('.wishlist-count-badge');
  wishBadges.forEach(b => {
    b.textContent = pjWishlist.length;
    b.style.display = pjWishlist.length > 0 ? 'flex' : 'none';
  });
}

function addToCart(item) {
  pjCart.push(item);
  localStorage.setItem('pj_cart', JSON.stringify(pjCart));
  updateBadges();
  renderCartDrawer();
  showToast(`Added to your Jewellery Bag: ${item.name}`);
  openCartDrawer();
}

function removeFromCart(index) {
  pjCart.splice(index, 1);
  localStorage.setItem('pj_cart', JSON.stringify(pjCart));
  updateBadges();
  renderCartDrawer();
}

function toggleWishlist(productName, btnElement) {
  const idx = pjWishlist.indexOf(productName);
  if (idx > -1) {
    pjWishlist.splice(idx, 1);
    if (btnElement) {
      btnElement.classList.remove('text-secondary', 'fill-secondary');
      btnElement.classList.add('text-on-surface-variant');
    }
    showToast(`Removed from Wishlist: ${productName}`);
  } else {
    pjWishlist.push(productName);
    if (btnElement) {
      btnElement.classList.remove('text-on-surface-variant');
      btnElement.classList.add('text-secondary', 'fill-secondary');
    }
    showToast(`Saved to Wishlist: ${productName}`);
  }
  localStorage.setItem('pj_wishlist', JSON.stringify(pjWishlist));
  updateBadges();
  renderWishlistDrawer();
}

function openCartDrawer() {
  const drawer = document.getElementById('cartDrawer');
  const backdrop = document.getElementById('cartBackdrop');
  if (drawer) drawer.classList.remove('translate-x-full');
  if (backdrop) backdrop.classList.remove('hidden');
  document.body.style.overflow = 'hidden';
}

function closeCartDrawer() {
  const drawer = document.getElementById('cartDrawer');
  const backdrop = document.getElementById('cartBackdrop');
  if (drawer) drawer.classList.add('translate-x-full');
  if (backdrop) backdrop.classList.add('hidden');
  document.body.style.overflow = '';
}

function openWishlistDrawer() {
  const drawer = document.getElementById('wishlistDrawer');
  const backdrop = document.getElementById('wishlistBackdrop');
  if (drawer) drawer.classList.remove('translate-x-full');
  if (backdrop) backdrop.classList.remove('hidden');
  document.body.style.overflow = 'hidden';
}

function closeWishlistDrawer() {
  const drawer = document.getElementById('wishlistDrawer');
  const backdrop = document.getElementById('wishlistBackdrop');
  if (drawer) drawer.classList.add('translate-x-full');
  if (backdrop) backdrop.classList.add('hidden');
  document.body.style.overflow = '';
}

function renderCartDrawer() {
  const container = document.getElementById('cartItemsList');
  const subtotalEl = document.getElementById('cartSubtotal');
  const waBtn = document.getElementById('cartWhatsAppCheckout');
  if (!container) return;

  if (pjCart.length === 0) {
    container.innerHTML = `
      <div class="py-16 text-center space-y-3">
        <span class="material-symbols-outlined text-4xl text-outline-variant">shopping_bag</span>
        <p class="font-headline-sm text-title-lg text-on-surface">Your Jewellery Bag is Empty</p>
        <p class="font-body-sm text-on-surface-variant">Explore our 22K handcrafted collections to add royal heirlooms.</p>
        <a href="products.html" class="inline-block mt-4 px-6 py-2.5 bg-primary-container text-on-primary-container font-label-sm uppercase tracking-widest text-xs hover:bg-secondary hover:text-on-secondary transition-colors">
          Explore Collections
        </a>
      </div>
    `;
    if (subtotalEl) subtotalEl.innerHTML = '&#8377;0';
    if (waBtn) {
      waBtn.href = `${PJ_CONFIG.whatsappBase}?text=${encodeURIComponent(PJ_CONFIG.defaultWhatsAppMsg)}`;
    }
    return;
  }

  let total = 0;
  let itemsSummary = [];

  container.innerHTML = pjCart.map((item, idx) => {
    const priceNum = item.priceNum || parseInt(item.price.replace(/[^\d]/g, ''), 10) || 0;
    total += priceNum;
    itemsSummary.push(`${item.name} (${item.price})`);

    return `
      <div class="flex items-center gap-4 py-4 border-b border-surface-container-high/60 group">
        <img src="${item.image}" alt="${item.name}" class="w-16 h-16 object-cover rounded bg-surface-container-low shrink-0" />
        <div class="flex-1 min-w-0">
          <h4 class="font-headline-sm text-sm text-on-surface truncate">${item.name}</h4>
          <p class="font-body-sm text-[11px] text-tertiary">${item.purity || '22K BIS 916'} • ${item.weight || ''}</p>
          <span class="font-headline-sm text-sm text-primary font-bold block mt-1">${item.price}</span>
        </div>
        <button onclick="removeFromCart(${idx})" class="p-1.5 text-outline-variant hover:text-secondary transition-colors" title="Remove item">
          <span class="material-symbols-outlined text-[18px]">delete</span>
        </button>
      </div>
    `;
  }).join('');

  if (subtotalEl) {
    subtotalEl.innerHTML = '&#8377;' + total.toLocaleString('en-IN');
  }

  if (waBtn) {
    const msg = `Hello PRINCESS JEWELS, I would like to inquire regarding purchasing these creations from my bag:\n\n${itemsSummary.map((s, i) => `${i + 1}. ${s}`).join('\n')}\n\nTotal Estimated Price: ₹${total.toLocaleString('en-IN')}\n\nPlease share booking and insured dispatch details.`;
    waBtn.href = `${PJ_CONFIG.whatsappBase}?text=${encodeURIComponent(msg)}`;
  }
}

function renderWishlistDrawer() {
  const container = document.getElementById('wishlistItemsList');
  if (!container) return;

  if (pjWishlist.length === 0) {
    container.innerHTML = `
      <div class="py-16 text-center space-y-3">
        <span class="material-symbols-outlined text-4xl text-outline-variant">favorite_border</span>
        <p class="font-headline-sm text-title-lg text-on-surface">No Saved Pieces Yet</p>
        <p class="font-body-sm text-on-surface-variant">Tap the heart emblem on any piece to curate your private wishlist.</p>
      </div>
    `;
    return;
  }

  container.innerHTML = pjWishlist.map(name => {
    const waUrl = `${PJ_CONFIG.whatsappBase}?text=${encodeURIComponent(`Hello PRINCESS JEWELS, I have saved ${name} to my wishlist and would love more details.`)}`;
    return `
      <div class="flex items-center justify-between py-3.5 border-b border-surface-container-high/60">
        <div class="flex items-center gap-3">
          <span class="material-symbols-outlined text-secondary text-[20px]">favorite</span>
          <span class="font-headline-sm text-sm text-on-surface">${name}</span>
        </div>
        <div class="flex items-center gap-2">
          <a href="${waUrl}" target="_blank" rel="noopener noreferrer" class="p-1.5 text-primary hover:text-secondary text-xs uppercase font-label-sm tracking-wider flex items-center gap-1">
            <span class="material-symbols-outlined text-[16px]">chat</span>
            <span>Enquire</span>
          </a>
          <button onclick="toggleWishlist('${name}')" class="p-1 text-outline-variant hover:text-secondary">
            <span class="material-symbols-outlined text-[16px]">close</span>
          </button>
        </div>
      </div>
    `;
  }).join('');
}

/* ----------------------------------------------------
   4. QUICK VIEW MODAL
---------------------------------------------------- */
function openModal(title, price, weight, desc, imgSrc, category) {
  const modal = document.getElementById('quickViewModal');
  if (!modal) return;

  const titleEl = document.getElementById('modalTitle');
  const priceEl = document.getElementById('modalPrice');
  const weightEl = document.getElementById('modalWeight');
  const descEl = document.getElementById('modalDesc');
  const imgEl = document.getElementById('modalImg');
  const waBtn = document.getElementById('modalWhatsAppBtn');
  const addBagBtn = document.getElementById('modalAddToBagBtn');

  if (titleEl) titleEl.textContent = title;
  if (priceEl) priceEl.textContent = price;
  if (weightEl) weightEl.textContent = weight;
  if (descEl) descEl.textContent = desc;
  if (imgEl && imgSrc) imgEl.src = imgSrc;

  // Configure Product Specific WhatsApp Enquiry URL
  if (waBtn) {
    const productMsg = `Hello PRINCESS JEWELS, I am interested in your ${title} (${price}, ${weight}). Please share more details and availability.`;
    waBtn.href = `${PJ_CONFIG.whatsappBase}?text=${encodeURIComponent(productMsg)}`;
  }

  // Configure Add to Bag
  if (addBagBtn) {
    addBagBtn.onclick = () => {
      addToCart({
        id: 'prod-' + Date.now(),
        name: title,
        price: price,
        priceNum: parseInt(price.replace(/[^\d]/g, ''), 10) || 0,
        weight: weight,
        purity: '22K (916) BIS Hallmarked',
        image: imgSrc || 'assets/images/necklace.jpg'
      });
      closeModal();
    };
  }

  modal.classList.remove('hidden');
  document.body.style.overflow = 'hidden';
}

function closeModal() {
  const modal = document.getElementById('quickViewModal');
  if (modal) modal.classList.add('hidden');
  document.body.style.overflow = '';
}

// Global modal backdrop close
document.addEventListener('click', (e) => {
  const modal = document.getElementById('quickViewModal');
  if (modal && e.target === modal) {
    closeModal();
  }
});

/* ----------------------------------------------------
   5. LIVE SEARCH MODAL
---------------------------------------------------- */
const CATALOG_ITEMS = [
  { name: 'The Maharani Imperial Choker', cat: 'Necklaces', price: '₹3,85,000', purity: '22K BIS 916', url: 'products.html?category=necklaces' },
  { name: 'Devi Royal Navratna Choker', cat: 'Necklaces', price: '₹4,20,000', purity: '22K BIS 916', url: 'products.html?category=necklaces' },
  { name: 'Aura Temple Peacock Kasu Mala', cat: 'Traditional', price: '₹2,45,000', purity: '22K Antique', url: 'products.html?category=traditional' },
  { name: 'Noor Handcrafted Filigree Bangles', cat: 'Bangles', price: '₹1,65,000', purity: '22K Pair Set', url: 'products.html?category=bangles' },
  { name: 'Chandrika Royal Tiered Jhumkas', cat: 'Earrings', price: '₹1,12,000', purity: '22K & Pearls', url: 'products.html?category=earrings' },
  { name: 'Mayura Filigree Kada Pair', cat: 'Bangles', price: '₹3,40,000', purity: '22K Yellow Gold', url: 'products.html?category=bangles' },
  { name: 'Sultana Layered Polki Haar', cat: 'Bridal', price: '₹6,80,000', purity: '22K Antique Gold', url: 'bridal.html' },
  { name: 'Padma Intricate Chandbali Earrings', cat: 'Earrings', price: '₹1,45,000', purity: '22K Gold & Rubies', url: 'products.html?category=earrings' },
  { name: 'Rajputana Crest Signet Ring', cat: 'Rings', price: '₹95,000', purity: '18K Solid Gold', url: 'products.html?category=rings' },
  { name: 'Swarna Floral Bridal Set', cat: 'Bridal', price: '₹5,50,000', purity: '22K Full Set', url: 'bridal.html' },
  { name: 'Ananya Mesh Gold Choker', cat: 'Contemporary', price: '₹1,85,000', purity: '18K Modern Gold', url: 'products.html?category=contemporary' },
  { name: 'Meenakari Enamelled Gold Kangan', cat: 'Traditional', price: '₹2,10,000', purity: '22K Hand-Fired Enamel', url: 'products.html?category=traditional' },
  { name: 'Vedic Laxmi Temple Long Necklace', cat: 'Traditional', price: '₹3,95,000', purity: '22K Nakshi Temple', url: 'products.html?category=traditional' }
];

function initSearchModal() {
  const searchBtns = document.querySelectorAll('[data-action="open-search"]');
  const modal = document.getElementById('searchModal');
  const closeBtn = document.getElementById('closeSearchModal');
  const input = document.getElementById('siteSearchInput');
  const resultsContainer = document.getElementById('searchResultsList');

  function openSearch() {
    if (modal) {
      modal.classList.remove('hidden');
      if (input) {
        input.value = '';
        setTimeout(() => input.focus(), 100);
      }
      renderSearchResults('');
      document.body.style.overflow = 'hidden';
    }
  }

  function closeSearch() {
    if (modal) modal.classList.add('hidden');
    document.body.style.overflow = '';
  }

  searchBtns.forEach(btn => btn.addEventListener('click', (e) => {
    e.preventDefault();
    openSearch();
  }));

  if (closeBtn) closeBtn.addEventListener('click', closeSearch);
  if (modal) {
    modal.addEventListener('click', (e) => {
      if (e.target === modal) closeSearch();
    });
  }

  if (input) {
    input.addEventListener('input', (e) => {
      renderSearchResults(e.target.value.trim());
    });
  }

  function renderSearchResults(query) {
    if (!resultsContainer) return;
    const cleanQ = query.toLowerCase();
    const filtered = query ? CATALOG_ITEMS.filter(item => 
      item.name.toLowerCase().includes(cleanQ) || 
      item.cat.toLowerCase().includes(cleanQ) || 
      item.purity.toLowerCase().includes(cleanQ)
    ) : CATALOG_ITEMS.slice(0, 5);

    if (filtered.length === 0) {
      resultsContainer.innerHTML = `
        <div class="py-10 text-center text-on-surface-variant font-body-sm">
          No creations matching "<strong>${query}</strong>". Explore our Curated Categories or WhatsApp our Concierge.
        </div>
      `;
      return;
    }

    resultsContainer.innerHTML = filtered.map(item => `
      <a href="${item.url}" class="flex items-center justify-between p-3.5 hover:bg-surface-container rounded-lg transition-colors group">
        <div>
          <span class="font-label-sm text-[10px] text-primary uppercase tracking-wider">${item.cat} • ${item.purity}</span>
          <h4 class="font-headline-sm text-sm text-on-surface group-hover:text-primary transition-colors">${item.name}</h4>
        </div>
        <div class="text-right">
          <span class="font-headline-sm text-sm text-primary font-bold">${item.price}</span>
          <span class="material-symbols-outlined text-outline-variant text-[16px] block group-hover:translate-x-1 transition-transform">arrow_forward</span>
        </div>
      </a>
    `).join('');
  }
}

/* ----------------------------------------------------
   6. COLLECTIONS / SHOP PAGE CATEGORY & PRICE FILTER
---------------------------------------------------- */
function initCategoryFilters() {
  const categoryBtns = document.querySelectorAll('[data-category-filter]');
  const productCards = document.querySelectorAll('[data-product-category]');
  const priceCheckboxes = document.querySelectorAll('input[data-price-filter]');
  const resetBtn = document.getElementById('resetFiltersBtn');
  const countDisplay = document.getElementById('filteredCountDisplay');

  if (categoryBtns.length === 0 && productCards.length === 0) return;

  // Check URL params for category
  const urlParams = new URLSearchParams(window.location.search);
  const initialCategory = urlParams.get('category') || 'all';

  let currentCategory = initialCategory;

  function applyFilters() {
    let visibleCount = 0;

    // Get checked price ranges
    const checkedPrices = Array.from(priceCheckboxes)
      .filter(cb => cb.checked)
      .map(cb => cb.value);

    productCards.forEach(card => {
      const cardCat = card.getAttribute('data-product-category') || '';
      const cardPrice = parseInt(card.getAttribute('data-product-price') || '0', 10);

      // Match category
      let matchCat = currentCategory === 'all' || cardCat.toLowerCase() === currentCategory.toLowerCase();

      // Match price
      let matchPrice = true;
      if (checkedPrices.length > 0 && !checkedPrices.includes('all')) {
        matchPrice = false;
        checkedPrices.forEach(range => {
          if (range === 'under-100k' && cardPrice < 100000) matchPrice = true;
          if (range === '100k-250k' && cardPrice >= 100000 && cardPrice <= 250000) matchPrice = true;
          if (range === '250k-500k' && cardPrice >= 250000 && cardPrice <= 500000) matchPrice = true;
          if (range === 'above-500k' && cardPrice > 500000) matchPrice = true;
        });
      }

      if (matchCat && matchPrice) {
        card.style.display = '';
        visibleCount++;
      } else {
        card.style.display = 'none';
      }
    });

    if (countDisplay) {
      countDisplay.textContent = `Showing ${visibleCount} pieces`;
    }

    // Update active tab buttons
    categoryBtns.forEach(btn => {
      const filterVal = btn.getAttribute('data-category-filter');
      if (filterVal.toLowerCase() === currentCategory.toLowerCase()) {
        btn.classList.add('text-primary', 'font-semibold', 'bg-surface-container-high');
        btn.classList.remove('text-on-surface-variant');
      } else {
        btn.classList.remove('text-primary', 'font-semibold', 'bg-surface-container-high');
        btn.classList.add('text-on-surface-variant');
      }
    });
  }

  categoryBtns.forEach(btn => {
    btn.addEventListener('click', (e) => {
      e.preventDefault();
      currentCategory = btn.getAttribute('data-category-filter') || 'all';
      applyFilters();
    });
  });

  priceCheckboxes.forEach(cb => {
    cb.addEventListener('change', applyFilters);
  });

  if (resetBtn) {
    resetBtn.addEventListener('click', () => {
      currentCategory = 'all';
      priceCheckboxes.forEach(cb => cb.checked = false);
      applyFilters();
    });
  }

  // Sort dropdown
  const sortSelect = document.getElementById('catalogSortSelect');
  const productContainer = document.getElementById('productsGridContainer');
  if (sortSelect && productContainer) {
    sortSelect.addEventListener('change', () => {
      const sortVal = sortSelect.value;
      const cards = Array.from(productCards);

      cards.sort((a, b) => {
        const priceA = parseInt(a.getAttribute('data-product-price') || '0', 10);
        const priceB = parseInt(b.getAttribute('data-product-price') || '0', 10);

        if (sortVal === 'price-low') return priceA - priceB;
        if (sortVal === 'price-high') return priceB - priceA;
        return 0; // Default or popularity
      });

      cards.forEach(card => productContainer.appendChild(card));
    });
  }

  applyFilters();
}

/* ----------------------------------------------------
   7. CONTACT PAGE — FORM VALIDATION & DISPATCH
---------------------------------------------------- */
function initContactForm() {
  const form = document.getElementById('enquiryForm');
  if (!form) return;

  const fullNameInput = document.getElementById('fullName');
  const phoneInput = document.getElementById('phoneNumber');
  const emailInput = document.getElementById('emailAddress');
  const enquiryTypeSelect = document.getElementById('enquiryType');
  const categorySelect = document.getElementById('jewelleryCategory') || document.getElementById('jewelleryInterest');
  const budgetSelect = document.getElementById('budgetRange');
  const messageInput = document.getElementById('messageBody');
  const submitBtn = document.getElementById('submitBtn');
  const feedbackBox = document.getElementById('formFeedback');

  function showError(inputEl, msg) {
    let errEl = inputEl.parentElement.querySelector('.form-error-msg');
    if (!errEl) {
      errEl = document.createElement('p');
      errEl.className = 'form-error-msg text-secondary text-xs mt-1 font-body-sm font-medium';
      inputEl.parentElement.appendChild(errEl);
    }
    errEl.textContent = msg;
    inputEl.classList.add('border', 'border-secondary');
  }

  function clearError(inputEl) {
    const errEl = inputEl.parentElement.querySelector('.form-error-msg');
    if (errEl) errEl.remove();
    inputEl.classList.remove('border', 'border-secondary');
  }

  [fullNameInput, phoneInput, emailInput, messageInput].forEach(inp => {
    if (inp) {
      inp.addEventListener('input', () => clearError(inp));
    }
  });

  form.addEventListener('submit', (e) => {
    e.preventDefault();

    let isValid = true;

    // 1. Full Name
    const nameVal = fullNameInput.value.trim();
    if (!nameVal) {
      showError(fullNameInput, 'Please enter your full name.');
      isValid = false;
    } else {
      clearError(fullNameInput);
    }

    // 2. Phone Validation
    const phoneVal = phoneInput.value.trim();
    const phoneRegex = /^[+]?[\d\s\-]{8,15}$/;
    if (!phoneVal) {
      showError(phoneInput, 'Please enter your contact phone number.');
      isValid = false;
    } else if (!phoneRegex.test(phoneVal)) {
      showError(phoneInput, 'Please enter a valid telephone number (8 to 15 digits).');
      isValid = false;
    } else {
      clearError(phoneInput);
    }

    // 3. Email Validation
    const emailVal = emailInput.value.trim();
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailVal) {
      showError(emailInput, 'Please provide your email address.');
      isValid = false;
    } else if (!emailRegex.test(emailVal)) {
      showError(emailInput, 'Please enter a valid email format (e.g. name@domain.com).');
      isValid = false;
    } else {
      clearError(emailInput);
    }

    // 4. Message
    const msgVal = messageInput.value.trim();
    if (!msgVal) {
      showError(messageInput, 'Please share a brief note about your enquiry or requirement.');
      isValid = false;
    } else {
      clearError(messageInput);
    }

    if (!isValid) return;

    // Show processing
    submitBtn.disabled = true;
    submitBtn.classList.add('opacity-70');
    submitBtn.innerHTML = `<span>Processing Patron Enquiry...</span>`;

    setTimeout(() => {
      submitBtn.innerHTML = `<span>Enquiry Recorded</span> <span class="material-symbols-outlined text-[18px]">verified</span>`;
      submitBtn.classList.remove('bg-primary-container');
      submitBtn.classList.add('bg-secondary', 'text-on-secondary');

      const enquiryType = enquiryTypeSelect ? enquiryTypeSelect.options[enquiryTypeSelect.selectedIndex].text : 'General Enquiry';
      const category = categorySelect ? categorySelect.options[categorySelect.selectedIndex].text : 'Gold Jewellery';
      const budget = budgetSelect && budgetSelect.value ? budgetSelect.options[budgetSelect.selectedIndex].text : 'Not Specified';

      // Build structured text
      const inquiryText = `*PRINCESS JEWELS — NEW ENQUIRY*\n` +
        `• Name: ${nameVal}\n` +
        `• Phone: ${phoneVal}\n` +
        `• Email: ${emailVal}\n` +
        `• Enquiry Type: ${enquiryType}\n` +
        `• Category: ${category}\n` +
        `• Budget: ${budget}\n` +
        `• Message: ${msgVal}`;

      const waUrl = `${PJ_CONFIG.whatsappBase}?text=${encodeURIComponent(inquiryText)}`;
      const mailtoUrl = `mailto:${PJ_CONFIG.email}?subject=${encodeURIComponent(`New Jewellery Enquiry - ${nameVal} [${enquiryType}]`)}&body=${encodeURIComponent(inquiryText)}`;

      if (feedbackBox) {
        feedbackBox.classList.remove('hidden');
        feedbackBox.innerHTML = `
          <div class="space-y-4">
            <div class="flex items-start gap-3">
              <span class="material-symbols-outlined text-primary text-[28px]">check_circle</span>
              <div>
                <h4 class="font-headline-sm text-title-lg text-on-surface">Enquiry Successfully Prepared, ${nameVal}</h4>
                <p class="font-body-sm text-on-surface-variant mt-1 leading-relaxed">
                  Thank you for connecting with PRINCESS JEWELS. To deliver your request immediately, please choose your preferred instant dispatch channel:
                </p>
              </div>
            </div>

            <!-- Instant Delivery Action Cluster -->
            <div class="grid grid-cols-1 sm:grid-cols-2 gap-3 pt-2">
              <a href="${waUrl}" target="_blank" rel="noopener noreferrer" class="px-5 py-3.5 bg-gradient-to-r from-[#1E4D2B] to-[#2E7D32] text-white rounded font-label-md uppercase tracking-wider text-xs flex items-center justify-center gap-2 shadow hover:opacity-95 transition-opacity">
                <span class="material-symbols-outlined text-[20px]">chat</span>
                <span>Dispatch via WhatsApp Now</span>
              </a>
              <a href="${mailtoUrl}" class="px-5 py-3.5 bg-primary text-on-primary rounded font-label-md uppercase tracking-wider text-xs flex items-center justify-center gap-2 shadow hover:bg-secondary transition-colors">
                <span class="material-symbols-outlined text-[20px]">mail</span>
                <span>Send via Email Client</span>
              </a>
            </div>

            <!-- Transparent Backend Note -->
            <div class="p-3.5 bg-surface-container-high rounded text-[11px] font-body-sm text-on-surface-variant/90 border border-outline-variant/40 leading-relaxed">
              <strong>Transparent Integration Notice:</strong> Direct client-side websites require a backend email dispatch service (e.g., Formspree endpoint, EmailJS API key, or custom SMTP server) to route forms automatically to <em>${PJ_CONFIG.email}</em> without launching your email client. Tapping either button above guarantees instant, direct delivery of your details to our Chief Concierge.
            </div>
          </div>
        `;
        feedbackBox.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
      }
    }, 600);
  });
}

/* ----------------------------------------------------
   8. BRIDAL BOOKING MODULE DISPATCH
---------------------------------------------------- */
function initBridalBookingForm() {
  const form = document.getElementById('bridalBookingForm');
  if (!form) return;

  form.addEventListener('submit', (e) => {
    e.preventDefault();
    const brideName = document.getElementById('brideName')?.value || 'Valued Patron';
    const bridePhone = document.getElementById('bridePhone')?.value || '';
    const weddingDate = document.getElementById('weddingDate')?.value || '';
    const consultDate = document.getElementById('consultDate')?.value || '';
    const notes = document.getElementById('brideNotes')?.value || '';

    const bookingMsg = `Hello PRINCESS JEWELS, I would like to book a Private Bridal Consultation:\n\n` +
      `• Bride/Patron: ${brideName}\n` +
      `• Phone: ${bridePhone}\n` +
      `• Wedding Date: ${weddingDate}\n` +
      `• Preferred Consultation: ${consultDate}\n` +
      `• Notes: ${notes}\n\n` +
      `Please confirm availability.`;

    const waUrl = `${PJ_CONFIG.whatsappBase}?text=${encodeURIComponent(bookingMsg)}`;

    const confirmBox = document.getElementById('bookingConfirmMsg');
    if (confirmBox) {
      confirmBox.classList.remove('hidden');
      confirmBox.innerHTML = `
        <div class="space-y-3">
          <p class="font-headline-sm text-title-lg">Bridal Suite Request Initialized</p>
          <p class="font-body-sm text-on-surface-variant">Tap below to confirm and connect directly with our Senior Bridal Concierge on WhatsApp:</p>
          <a href="${waUrl}" target="_blank" rel="noopener noreferrer" class="inline-flex items-center gap-2 px-6 py-3 bg-[#2E7D32] text-white rounded font-label-md uppercase tracking-wider text-xs shadow hover:bg-[#1E4D2B] transition-colors">
            <span class="material-symbols-outlined text-[18px]">chat</span>
            <span>Confirm Booking on WhatsApp</span>
          </a>
        </div>
      `;
    }
  });
}

/* ----------------------------------------------------
   9. LUXURY TOAST NOTIFICATION
---------------------------------------------------- */
function showToast(message) {
  let toast = document.getElementById('pjLuxuryToast');
  if (!toast) {
    toast = document.createElement('div');
    toast.id = 'pjLuxuryToast';
    toast.className = 'fixed bottom-6 right-6 z-50 px-5 py-3.5 bg-inverse-surface text-surface-bright rounded shadow-2xl font-body-sm text-sm border border-primary-container/30 flex items-center gap-3 transform translate-y-12 opacity-0 transition-all duration-300 pointer-events-none';
    document.body.appendChild(toast);
  }

  toast.innerHTML = `
    <span class="material-symbols-outlined text-primary-container text-[20px]">verified</span>
    <span>${message}</span>
  `;
  toast.classList.remove('translate-y-12', 'opacity-0');
  toast.classList.add('translate-y-0', 'opacity-100');

  setTimeout(() => {
    toast.classList.remove('translate-y-0', 'opacity-100');
    toast.classList.add('translate-y-12', 'opacity-0');
  }, 3200);
}

// Accordion helper for FAQ
function toggleAccordion(button) {
  const parent = button.closest('[data-accordion-item]');
  if (!parent) return;
  const content = parent.querySelector('.accordion-content');
  const arrow = parent.querySelector('.accordion-arrow');
  const isExpanded = button.getAttribute('aria-expanded') === 'true';

  document.querySelectorAll('#faqAccordionGroup [data-accordion-item]').forEach(item => {
    if (item !== parent) {
      const btn = item.querySelector('button');
      const cnt = item.querySelector('.accordion-content');
      const arr = item.querySelector('.accordion-arrow');
      if (btn) btn.setAttribute('aria-expanded', 'false');
      if (cnt) cnt.style.maxHeight = '0px';
      if (arr) arr.style.transform = 'rotate(0deg)';
    }
  });

  if (isExpanded) {
    button.setAttribute('aria-expanded', 'false');
    content.style.maxHeight = '0px';
    if (arrow) arrow.style.transform = 'rotate(0deg)';
  } else {
    button.setAttribute('aria-expanded', 'true');
    content.style.maxHeight = content.scrollHeight + 'px';
    if (arrow) arrow.style.transform = 'rotate(180deg)';
  }
}

/* ----------------------------------------------------
   10. FLOATING BACK TO TOP & SCROLL PROGRESS MODULE
---------------------------------------------------- */
function initBackToTop() {
  const btn = document.getElementById('backToTop') || document.getElementById('backToTopBtn');
  const progress = document.getElementById('scrollProgress');

  window.addEventListener('scroll', () => {
    // 1. Update Scroll Progress Bar
    if (progress) {
      const winScroll = document.body.scrollTop || document.documentElement.scrollTop;
      const height = document.documentElement.scrollHeight - document.documentElement.clientHeight;
      const scrolled = height > 0 ? (winScroll / height) * 100 : 0;
      progress.style.width = scrolled + '%';
    }

    // 2. Toggle Back to Top Button visibility after scrolling 400px
    if (btn) {
      if (window.scrollY > 400) {
        btn.classList.remove('hidden', 'opacity-0', 'pointer-events-none');
        btn.classList.add('flex', 'opacity-100', 'pointer-events-auto');
      } else {
        btn.classList.remove('flex', 'opacity-100', 'pointer-events-auto');
        btn.classList.add('hidden', 'opacity-0', 'pointer-events-none');
      }
    }
  }, { passive: true });

  if (btn) {
    btn.addEventListener('click', (e) => {
      e.preventDefault();
      window.scrollTo({ top: 0, behavior: 'smooth' });
    });
  }
}

/* ----------------------------------------------------
   11. VIP SALON NEWSLETTER & WHATSAPP REGISTRATION
---------------------------------------------------- */
function initNewsletterVipForms() {
  const setupVip = (formId, inputId, successId) => {
    const form = document.getElementById(formId);
    const input = document.getElementById(inputId);
    const success = document.getElementById(successId);
    if (!form || !input) return;

    form.addEventListener('submit', (e) => {
      e.preventDefault();
      const email = (input.value || '').trim();
      if (!email) return;

      // 1. Save subscriber locally in browser storage
      try {
        const stored = JSON.parse(localStorage.getItem('pj_vip_subscribers') || '[]');
        if (!stored.includes(email)) {
          stored.push(email);
          localStorage.setItem('pj_vip_subscribers', JSON.stringify(stored));
        }
      } catch (err) {
        console.warn('Storage error:', err);
      }

      // 2. Display royal confirmation
      if (success) {
        success.classList.remove('hidden');
      }

      // 3. Open WhatsApp with pre-filled VIP request
      const msg = `Hello PRINCESS JEWELS, I would like to join the High Jewellery Salon VIP list. My email is: ${email}`;
      const url = `https://wa.me/919426557390?text=${encodeURIComponent(msg)}`;
      window.open(url, '_blank');
    });
  };

  setupVip('salonVipForm', 'salonVipEmail', 'vip-success');
  setupVip('footerVipForm', 'footerVipEmail', 'footer-vip-success');
}
