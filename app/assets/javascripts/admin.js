// Admin Dashboard JavaScript (Replacing AdminLTE functionality) - Vanilla JS

document.addEventListener('DOMContentLoaded', function() {
  const body = document.body;

  // ========================================
  // Sidebar Toggle Functionality
  // ========================================
  const sidebarToggle = document.querySelector('.sidebar-toggle');
  if (sidebarToggle) {
    sidebarToggle.addEventListener('click', function(e) {
      e.preventDefault();

      // Different behavior for mobile vs desktop
      if (window.innerWidth <= 768) {
        // On mobile: toggle sidebar-open class (sidebar hidden by default)
        body.classList.toggle('sidebar-open');
        // Ensure sidebar-collapse is set on mobile (for CSS targeting)
        body.classList.add('sidebar-collapse');
      } else {
        // On desktop: toggle sidebar-collapse class (sidebar visible by default)
        body.classList.toggle('sidebar-collapse');

        // Store sidebar state in localStorage (desktop only)
        if (body.classList.contains('sidebar-collapse')) {
          localStorage.setItem('sidebar-state', 'collapsed');
        } else {
          localStorage.setItem('sidebar-state', 'expanded');
        }
      }
    });
  }

  // Restore sidebar state from localStorage (desktop only)
  if (window.innerWidth > 768) {
    const sidebarState = localStorage.getItem('sidebar-state');
    if (sidebarState === 'collapsed') {
      body.classList.add('sidebar-collapse');
    }
  }

  // ========================================
  // Sidebar Menu Tree (Treeview)
  // ========================================
  const treeviewLinks = document.querySelectorAll('.sidebar-menu .treeview > a');
  treeviewLinks.forEach(function(link) {
    link.addEventListener('click', function(e) {
      e.preventDefault();
      const parent = this.parentElement;
      const isActive = parent.classList.contains('active');
      const menu = parent.querySelector('> .treeview-menu');

      // Close all other treeview menus
      document.querySelectorAll('.sidebar-menu .treeview').forEach(function(item) {
        if (item !== parent) {
          item.classList.remove('active');
          const otherMenu = item.querySelector('> .treeview-menu');
          if (otherMenu) {
            otherMenu.style.display = 'none';
          }
        }
      });

      // Toggle current menu
      if (!isActive) {
        parent.classList.add('active');
        if (menu) {
          menu.style.display = 'block';
        }
      } else {
        parent.classList.remove('active');
        if (menu) {
          menu.style.display = 'none';
        }
      }
    });
  });

  // Keep active menu item open on page load
  document.querySelectorAll('.sidebar-menu .treeview.active > .treeview-menu').forEach(function(menu) {
    menu.style.display = 'block';
  });

  // ========================================
  // Bootstrap 5 Compatibility
  // ========================================

  // Convert data-toggle to data-bs-toggle for Bootstrap 5
  document.querySelectorAll('[data-toggle="dropdown"]').forEach(function(el) {
    el.setAttribute('data-bs-toggle', 'dropdown');
  });

  document.querySelectorAll('[data-toggle="modal"]').forEach(function(el) {
    el.setAttribute('data-bs-toggle', 'modal');
  });

  document.querySelectorAll('[data-toggle="collapse"]').forEach(function(el) {
    el.setAttribute('data-bs-toggle', 'collapse');
  });

  // Convert data-dismiss to data-bs-dismiss for Bootstrap 5
  document.querySelectorAll('[data-dismiss="modal"]').forEach(function(el) {
    el.setAttribute('data-bs-dismiss', 'modal');
  });

  document.querySelectorAll('[data-dismiss="alert"]').forEach(function(el) {
    el.setAttribute('data-bs-dismiss', 'alert');
  });

  // Initialize Bootstrap tooltips
  if (typeof bootstrap !== 'undefined' && bootstrap.Tooltip) {
    const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-toggle="tooltip"], [data-bs-toggle="tooltip"]'));
    tooltipTriggerList.forEach(function(tooltipTriggerEl) {
      return new bootstrap.Tooltip(tooltipTriggerEl);
    });
  }

  // ========================================
  // Responsive Sidebar for Mobile
  // ========================================
  function handleMobileInit() {
    if (window.innerWidth <= 768) {
      body.classList.add('sidebar-collapse');
      body.classList.remove('sidebar-open');
    }
  }

  // Initialize on page load
  handleMobileInit();

  // Re-initialize on window resize
  let resizeTimeout;
  window.addEventListener('resize', function() {
    clearTimeout(resizeTimeout);
    resizeTimeout = setTimeout(handleMobileInit, 100);
  });

  // Close sidebar on mobile when clicking outside
  document.addEventListener('click', function(e) {
    if (window.innerWidth <= 768) {
      const sidebar = document.querySelector('.main-sidebar');
      const isClickInsideSidebar = sidebar && sidebar.contains(e.target);
      const isClickOnToggle = sidebarToggle && sidebarToggle.contains(e.target);

      if (!isClickInsideSidebar && !isClickOnToggle) {
        body.classList.remove('sidebar-open');
      }
    }
  });

  // Close sidebar when clicking the overlay (body::before pseudo-element area)
  const contentWrapper = document.querySelector('.content-wrapper');
  if (contentWrapper) {
    contentWrapper.addEventListener('click', function() {
      if (window.innerWidth <= 768 && body.classList.contains('sidebar-open')) {
        body.classList.remove('sidebar-open');
      }
    });
  }

  // ========================================
  // Nav Tabs
  // ========================================
  document.querySelectorAll('.nav-tabs > li').forEach(function(tab) {
    tab.addEventListener('click', function(e) {
      document.querySelectorAll('.nav-tabs > li').forEach(function(t) {
        t.classList.remove('active');
      });
      this.classList.add('active');
    });
  });

  // ========================================
  // User Dropdown Menu - Bootstrap 5
  // ========================================
  // Bootstrap 5 dropdowns are initialized automatically, no need for manual init
});
