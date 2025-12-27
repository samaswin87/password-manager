// Admin Dashboard JavaScript (Replacing AdminLTE functionality)

$(document).ready(function(){

  // ========================================
  // Sidebar Toggle Functionality
  // ========================================
  $('.sidebar-toggle').on('click', function(e){
    e.preventDefault();

    // Different behavior for mobile vs desktop
    if($(window).width() <= 768) {
      // On mobile: toggle sidebar-open class (sidebar hidden by default)
      $('body').toggleClass('sidebar-open');
      // Ensure sidebar-collapse is set on mobile (for CSS targeting)
      $('body').addClass('sidebar-collapse');
    } else {
      // On desktop: toggle sidebar-collapse class (sidebar visible by default)
      $('body').toggleClass('sidebar-collapse');

      // Store sidebar state in localStorage (desktop only)
      if($('body').hasClass('sidebar-collapse')) {
        localStorage.setItem('sidebar-state', 'collapsed');
      } else {
        localStorage.setItem('sidebar-state', 'expanded');
      }
    }
  });

  // Restore sidebar state from localStorage (desktop only)
  if($(window).width() > 768) {
    var sidebarState = localStorage.getItem('sidebar-state');
    if(sidebarState === 'collapsed') {
      $('body').addClass('sidebar-collapse');
    }
  }

  // ========================================
  // Sidebar Menu Tree (Treeview)
  // ========================================
  $('.sidebar-menu .treeview > a').on('click', function(e){
    var parent = $(this).parent();
    var isActive = parent.hasClass('active');

    // Close all other treeview menus
    $('.sidebar-menu .treeview').not(parent).removeClass('active');
    $('.sidebar-menu .treeview-menu').not(parent.find('.treeview-menu')).slideUp();

    // Toggle current menu
    if(!isActive) {
      parent.addClass('active');
      parent.find('> .treeview-menu').slideDown();
    } else {
      parent.removeClass('active');
      parent.find('> .treeview-menu').slideUp();
    }

    e.preventDefault();
  });

  // Keep active menu item open on page load
  $('.sidebar-menu .treeview.active > .treeview-menu').show();

  // ========================================
  // Bootstrap 5 Compatibility
  // ========================================

  // Convert data-toggle to data-bs-toggle for Bootstrap 5
  $('[data-toggle="dropdown"]').each(function(){
    $(this).attr('data-bs-toggle', 'dropdown');
  });

  $('[data-toggle="modal"]').each(function(){
    $(this).attr('data-bs-toggle', 'modal');
  });

  $('[data-toggle="collapse"]').each(function(){
    $(this).attr('data-bs-toggle', 'collapse');
  });

  // Convert data-dismiss to data-bs-dismiss for Bootstrap 5
  $('[data-dismiss="modal"]').each(function(){
    $(this).attr('data-bs-dismiss', 'modal');
  });

  $('[data-dismiss="alert"]').each(function(){
    $(this).attr('data-bs-dismiss', 'alert');
  });

  // Initialize Bootstrap tooltips
  if(typeof bootstrap !== 'undefined' && bootstrap.Tooltip) {
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-toggle="tooltip"], [data-bs-toggle="tooltip"]'));
    tooltipTriggerList.map(function (tooltipTriggerEl) {
      return new bootstrap.Tooltip(tooltipTriggerEl);
    });
  }

  // ========================================
  // Responsive Sidebar for Mobile
  // ========================================
  function handleMobileInit() {
    if($(window).width() <= 768) {
      $('body').addClass('sidebar-collapse');
      $('body').removeClass('sidebar-open');
    }
  }

  // Initialize on page load
  handleMobileInit();

  // Re-initialize on window resize
  $(window).on('resize', function(){
    handleMobileInit();
  });

  // Close sidebar on mobile when clicking outside
  $(document).on('click', function(e){
    if($(window).width() <= 768) {
      if(!$(e.target).closest('.main-sidebar, .sidebar-toggle').length) {
        $('body').removeClass('sidebar-open');
      }
    }
  });

  // Close sidebar when clicking the overlay (body::before pseudo-element area)
  $(document).on('click', '.content-wrapper', function(_e){
    if($(window).width() <= 768 && $('body').hasClass('sidebar-open')) {
      $('body').removeClass('sidebar-open');
    }
  });

  // ========================================
  // User Dropdown Menu - Bootstrap 5
  // ========================================
  // Bootstrap 5 dropdowns are initialized automatically, no need for manual init

});
