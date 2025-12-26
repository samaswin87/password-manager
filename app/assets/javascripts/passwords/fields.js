(function ($) {
  let params = {};
  let url = {};
  let isAdmin = true;

  function init(_params, _url){
    params = _params;
    url = _url;
    isAdmin = params.isAdmin;
  }

  Array.prototype.remove = function (v) {
    if (this.indexOf(v) != -1) {
        this.splice(this.indexOf(v), 1);
        return true;
    }
    return false;
  }

  let fileArray = [];

  genPassword = function(e) {
    $("#password_text_password").val(generatePassword(true, true, true, false, 20));
  };

  $('#file_upload').click(function(e) {
    e.preventDefault();
    var formData = new FormData();
    for (var i = 0; i < fileArray.length; i++) {
      formData.append("attachments[]", fileArray[i]);
    }
    putFiles('uploads', formData).then(data => {
      location.reload();
    });
  });

  $('#file_attachments').change(function(e) {
    let filesArray = $.merge(fileArray, e.target.files);

    $('.template-upload').remove();
    filesArray.forEach( function(element, index) {
      const row = '<tr class="template-upload">'+
      '  <td>'+
      '    <p class="id">'+(index + 1)+
      '    </p>'+
      '  </td>'+
      '  <td>'+
      '    <p class="name">'+element.name+
      '    </p>'+
      '    <strong class="error text-danger"></strong>'+
      '  </td>'+
      '  <td>'+
      '    <button class="btn btn-warning cancel pull-right remove-file" id="remove_'+index+'">'+
      '        <i class="fa fa-minus-circle"></i>'+
      '    </button>'+
      '  </td>'+
      '</tr>';
      $('#files_preview > tbody').append(row);
      $('#remove_'+index).click(function(e) {
        e.preventDefault();
        fileArray.remove(element);
        $(this).parent().parent().remove();
      });
    });
  });

  $('.eye-btn').click(function() {
    $(this).toggleClass("fa-eye fa-eye-slash");
    var $pwd = $("#copy-text_password");
    if ($pwd.attr('type') === undefined) {
      $pwd = $("#password_text_password");
    }
    if ($pwd.attr('type') === 'password') {
      $pwd.attr('type', 'text');
    } else {
      $pwd.attr('type', 'password');
    }
  });

  $('#password_status').click(function() {
    var url = window.location.pathname;
    var id = url.substring(url.lastIndexOf('/') + 1);
    $.ajax({
        type: "PUT",
        url: id+'/status',
        dataType: 'JSON',
        complete: function() {
          location.reload();
        }
    });
  });


  $.password = {
    init: init,
  }

})(jQuery);
