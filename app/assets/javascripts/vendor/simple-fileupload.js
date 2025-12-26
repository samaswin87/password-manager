// Simple replacement for jquery-fileupload
// Provides a jQuery plugin API similar to jquery-fileupload for backward compatibility
(function($) {
  $.fn.fileupload = function(options) {
    var $input = this;
    var settings = $.extend({
      url: '/upload',
      formData: {},
      maxNumberOfFiles: 1,
      add: function() {},
      done: function() {},
      fail: function() {}
    }, options);

    $input.on('change', function(e) {
      var files = e.target.files;
      if (files.length === 0) return;

      var file = files[0];
      var data = {
        files: [file],
        submit: function() {
          var formData = new FormData();
          formData.append('file', file);

          // Add additional form data
          for (var key in settings.formData) {
            formData.append(key, settings.formData[key]);
          }

          $.ajax({
            url: settings.url,
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            headers: {
              'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
            },
            success: function(response) {
              data.result = response;
              $input.trigger('fileuploaddone', [data]);
            },
            error: function(jqXHR, textStatus, errorThrown) {
              data.jqXHR = jqXHR;
              data.textStatus = textStatus;
              data.errorThrown = errorThrown;
              $input.trigger('fileuploadfail', [data]);
            }
          });
        }
      };

      // Call the add callback
      settings.add.call(this, e, data);
    });

    return this;
  };
})(jQuery);
