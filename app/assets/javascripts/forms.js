// Forms - converted to vanilla JS
// Input masks are now handled by input_mask_controller.js
// Selectize is replaced with native select or can use a Stimulus controller

window.applyFormControls = function() {
  // Selectize replacement - use native select or enhance with Stimulus
  // For now, we'll just ensure selects are styled properly
  document.querySelectorAll('.selectize-single').forEach(function(select) {
    // Add Bootstrap classes if needed
    if (!select.classList.contains('form-select')) {
      select.classList.add('form-select');
    }
  });

  // Text editor - if wysihtml5 is needed, consider using a modern alternative
  // For now, we'll skip this as it requires a rich text editor library
  // document.querySelectorAll(".texteditor").forEach(function(editor) {
  //   // Rich text editor initialization would go here
  // });

  // Input masks are handled by input_mask_controller.js
  // The masks are applied automatically via event listeners
};

document.addEventListener('DOMContentLoaded', function() {
  applyFormControls();
});
