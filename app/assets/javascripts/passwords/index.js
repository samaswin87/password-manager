(function ($) {
  // ========================================
  // Password Cards View (Modern UI with Pagination)
  // ========================================

  let allPasswords = [];
  let filteredPasswords = [];
  let currentFilter = 'all';
  let searchQuery = '';
  let currentPage = 1;
  let pagyData = null;

  function initCards(_params, _url) {
    params = _params;
    url = _url;
    loadPasswords(1);
    setupEventListeners();
  }

  function loadPasswords(page) {
    page = page || currentPage;

    const ajaxParams = {
      page: page
    };

    if (searchQuery) {
      ajaxParams.search = searchQuery;
    }

    if (currentFilter !== 'all') {
      ajaxParams.filter = currentFilter;
    }

    $.ajax({
      url: params.passwordsUrl,
      method: 'GET',
      dataType: 'json',
      data: ajaxParams,
      success: function(response) {
        allPasswords = response.data || [];
        filteredPasswords = allPasswords;
        pagyData = response.pagy;
        currentPage = page;
        renderPasswordCards();
        renderPagination();
      },
      error: function(error) {
        console.error('Error loading passwords:', error);
        showEmptyState('Error loading passwords. Please refresh the page.');
      }
    });
  }

  function setupEventListeners() {
    // Search input with debounce
    let searchTimeout;
    $('#passwords-search').on('input', function() {
      searchQuery = $(this).val();
      clearTimeout(searchTimeout);
      searchTimeout = setTimeout(function() {
        loadPasswords(1);
      }, 300);
    });

    // Filter tags
    $('.filter-tag').on('click', function() {
      $('.filter-tag').removeClass('active');
      $(this).addClass('active');
      currentFilter = $(this).data('filter');
      loadPasswords(1);
    });

    // Delegate events for dynamic elements
    $(document).on('click', '.quick-copy-btn', handleQuickCopy);
    $(document).on('click', '.pagy-nav a', handlePagination);
  }

  function handlePagination(e) {
    e.preventDefault();
    const page = parseInt($(this).data('page'));
    if (page && page !== currentPage) {
      loadPasswords(page);
      // Scroll to top of passwords section
      $('html, body').animate({
        scrollTop: $('#passwords-container').offset().top - 100
      }, 300);
    }
  }

  function renderPasswordCards() {
    const container = $('#passwords-container');

    if (filteredPasswords.length === 0) {
      showEmptyState();
      return;
    }

    const cardsHtml = filteredPasswords.map(function(password) {
      return createPasswordCard(password);
    }).join('');

    container.html('<div class="passwords-grid">' + cardsHtml + '</div>');
    initializeClipboard();
  }

  function renderPagination() {
    let paginationHtml = '';

    if (pagyData && pagyData.pages > 1) {
      paginationHtml = '<nav class="pagy-nav" role="navigation" aria-label="Pagination">';
      paginationHtml += '<ul class="pagination">';

      // Previous button
      if (pagyData.prev) {
        paginationHtml += '<li class="page-item"><a class="page-link" href="#" data-page="' + pagyData.prev + '" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>';
      } else {
        paginationHtml += '<li class="page-item disabled"><span class="page-link">&laquo;</span></li>';
      }

      // Page numbers
      const startPage = Math.max(1, pagyData.page - 2);
      const endPage = Math.min(pagyData.pages, pagyData.page + 2);

      if (startPage > 1) {
        paginationHtml += '<li class="page-item"><a class="page-link" href="#" data-page="1">1</a></li>';
        if (startPage > 2) {
          paginationHtml += '<li class="page-item disabled"><span class="page-link">...</span></li>';
        }
      }

      for (let i = startPage; i <= endPage; i++) {
        if (i === pagyData.page) {
          paginationHtml += '<li class="page-item active"><span class="page-link">' + i + '</span></li>';
        } else {
          paginationHtml += '<li class="page-item"><a class="page-link" href="#" data-page="' + i + '">' + i + '</a></li>';
        }
      }

      if (endPage < pagyData.pages) {
        if (endPage < pagyData.pages - 1) {
          paginationHtml += '<li class="page-item disabled"><span class="page-link">...</span></li>';
        }
        paginationHtml += '<li class="page-item"><a class="page-link" href="#" data-page="' + pagyData.pages + '">' + pagyData.pages + '</a></li>';
      }

      // Next button
      if (pagyData.next) {
        paginationHtml += '<li class="page-item"><a class="page-link" href="#" data-page="' + pagyData.next + '" aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>';
      } else {
        paginationHtml += '<li class="page-item disabled"><span class="page-link">&raquo;</span></li>';
      }

      paginationHtml += '</ul>';
      paginationHtml += '<div class="pagy-info">Showing ' + pagyData.from + ' to ' + pagyData.to + ' of ' + pagyData.count + ' passwords</div>';
      paginationHtml += '</nav>';
    }

    // Insert pagination after the passwords grid
    $('.passwords-grid').after(paginationHtml);
  }

  function createPasswordCard(password) {
    const strength = calculatePasswordStrength(password);
    const status = getPasswordStatus(password);
    const logoHtml = getLogoHtml(password);
    const isActive = status === 'Active';

    return `
      <div class="password-card" data-id="${password.DT_RowId}">
        <div class="password-card-header">
          <div class="password-card-logo">
            ${logoHtml}
          </div>
          <div class="password-card-title-section">
            <h3 class="password-card-title">${escapeHtml(password.name || 'Unnamed')}</h3>
            <div class="password-card-url">
              <i class="fa fa-globe"></i>
              <span>${escapeHtml(password.url || 'No URL')}</span>
            </div>
          </div>
          <div class="password-card-status">
            <span class="label ${isActive ? 'label-success' : 'label-danger'}">
              ${status}
            </span>
          </div>
        </div>

        <div class="password-card-info">
          <div class="password-info-row">
            <div class="password-info-icon">
              <i class="fa fa-user"></i>
            </div>
            <div class="password-info-content">
              <div class="password-info-label">Username</div>
              <div class="password-info-value">${escapeHtml(password.username || 'Not set')}</div>
            </div>
            ${password.username ? `
              <button class="quick-copy-btn" data-copy="${escapeHtml(password.username)}" title="Copy username">
                <i class="fa fa-copy"></i>
              </button>
            ` : ''}
          </div>

          <div class="password-info-row">
            <div class="password-info-icon">
              <i class="fa fa-key"></i>
            </div>
            <div class="password-info-content">
              <div class="password-info-label">Password</div>
              <div class="password-info-value hidden">••••••••</div>
            </div>
            <button class="quick-copy-btn" data-copy="password" data-id="${password.DT_RowId}" title="Copy password">
              <i class="fa fa-copy"></i>
            </button>
          </div>

          <div class="password-info-row">
            <div class="password-info-icon">
              <i class="fa fa-link"></i>
            </div>
            <div class="password-info-content">
              <div class="password-info-label">URL</div>
              <div class="password-info-value">${escapeHtml(password.url || 'Not set')}</div>
            </div>
            ${password.url ? `
              <a href="${escapeHtml(password.url)}" target="_blank" class="quick-copy-btn" title="Open URL">
                <i class="fa fa-external-link"></i>
              </a>
            ` : ''}
          </div>
        </div>

        <div class="password-strength">
          <div class="password-strength-label">
            <span>Password Strength</span>
            <span class="password-strength-text ${strength.level}">${strength.label}</span>
          </div>
          <div class="password-strength-bar">
            <div class="password-strength-fill ${strength.level}"></div>
          </div>
        </div>

        <div class="password-card-actions">
          <a href="/passwords/${password.DT_RowId}" class="password-card-btn password-card-btn-primary">
            <i class="fa fa-eye"></i>
            <span>View</span>
          </a>
          <a href="/passwords/${password.DT_RowId}/edit" class="password-card-btn password-card-btn-success">
            <i class="fa fa-edit"></i>
            <span>Edit</span>
          </a>
          <a href="/passwords/${password.DT_RowId}" data-method="delete" data-confirm-swal="Are you sure?" class="password-card-btn password-card-btn-danger">
            <i class="fa fa-trash"></i>
            <span>Delete</span>
          </a>
        </div>
      </div>
    `;
  }

  function calculatePasswordStrength(password) {
    // Simple password strength calculation
    // In production, you might want to fetch this from the server
    const length = 8; // Default assumption
    let score = 0;

    // This is a simplified version - adjust based on your needs
    if (length >= 8) score += 1;
    if (length >= 12) score += 1;
    if (length >= 16) score += 1;

    // Default to medium since we can't check actual password
    if (score >= 2) {
      return { level: 'strong', label: 'Strong' };
    } else if (score >= 1) {
      return { level: 'medium', label: 'Medium' };
    } else {
      return { level: 'weak', label: 'Weak' };
    }
  }

  function getPasswordStatus(password) {
    // Extract status from the HTML or use password data
    if (typeof password.status === 'string') {
      // If status is HTML, extract text
      const tempDiv = $('<div>').html(password.status);
      return tempDiv.text().trim();
    }
    return password.status || 'Active';
  }

  function getLogoHtml(password) {
    if (password.logo) {
      // Extract img tag from logo HTML
      const tempDiv = $('<div>').html(password.logo);
      const img = tempDiv.find('img');
      if (img.length) {
        return `<img src="${img.attr('src')}" alt="${escapeHtml(password.name)}">`;
      }
    }
    // Default icon
    return '<i class="fa fa-lock"></i>';
  }

  function handleQuickCopy(e) {
    e.preventDefault();
    const $btn = $(this);
    const copyData = $btn.data('copy');

    if (copyData === 'password') {
      // For password, we need to make an AJAX call to get the actual password
      // For now, show a message
      $.notify.autoHideNotify('info', 'top right', 'Info', 'Password copy feature requires backend integration');
      return;
    }

    // Copy to clipboard
    if (navigator.clipboard && navigator.clipboard.writeText) {
      navigator.clipboard.writeText(copyData).then(function() {
        showCopySuccess($btn);
      }).catch(function(err) {
        console.error('Failed to copy:', err);
      });
    } else {
      // Fallback for older browsers
      const textArea = document.createElement('textarea');
      textArea.value = copyData;
      textArea.style.position = 'fixed';
      textArea.style.left = '-999999px';
      document.body.appendChild(textArea);
      textArea.select();
      try {
        document.execCommand('copy');
        showCopySuccess($btn);
      } catch (err) {
        console.error('Failed to copy:', err);
      }
      document.body.removeChild(textArea);
    }
  }

  function showCopySuccess($btn) {
    const originalHtml = $btn.html();
    $btn.addClass('copied');
    $btn.html('<i class="fa fa-check"></i>');

    setTimeout(function() {
      $btn.removeClass('copied');
      $btn.html(originalHtml);
    }, 2000);

    $.notify.autoHideNotify('success', 'top right', 'Copied!', 'Text copied to clipboard');
  }

  function showEmptyState(message) {
    const container = $('#passwords-container');
    const emptyMessage = message || 'No passwords found';

    container.html(`
      <div class="passwords-empty-state">
        <div class="passwords-empty-icon">
          <i class="fa fa-key"></i>
        </div>
        <h3 class="passwords-empty-title">No Passwords Yet</h3>
        <p class="passwords-empty-text">${emptyMessage}</p>
        <a href="/passwords/new" class="btn btn-primary btn-lg">
          <i class="fa fa-plus margin-r-5"></i>
          Add Your First Password
        </a>
      </div>
    `);
  }

  function initializeClipboard() {
    // Initialize any clipboard-related functionality
    // This is called after cards are rendered
  }

  function escapeHtml(text) {
    if (!text) return '';
    const map = {
      '&': '&amp;',
      '<': '&lt;',
      '>': '&gt;',
      '"': '&quot;',
      "'": '&#039;'
    };
    return String(text).replace(/[&<>"']/g, function(m) { return map[m]; });
  }

  $.password_cards = {
    init: initCards,
    loadPasswords: loadPasswords
  };

})(jQuery);
