
document.addEventListener('DOMContentLoaded', function() {
    // open
    const burger = document.querySelectorAll('.navbar-burger');
    const menu = document.querySelectorAll('.navbar-menu');

    if (burger.length && menu.length) {
        for (var i = 0; i < burger.length; i++) {
            burger[i].addEventListener('click', function() {
                for (var j = 0; j < menu.length; j++) {
                    menu[j].classList.toggle('hidden');
                }
            });
        }
    }

    // close
    const close = document.querySelectorAll('.navbar-close');
    const backdrop = document.querySelectorAll('.navbar-backdrop');

    if (close.length) {
        for (var i = 0; i < close.length; i++) {
            close[i].addEventListener('click', function() {
                for (var j = 0; j < menu.length; j++) {
                    menu[j].classList.toggle('hidden');
                }
            });
        }
    }

    if (backdrop.length) {
        for (var i = 0; i < backdrop.length; i++) {
            backdrop[i].addEventListener('click', function() {
                for (var j = 0; j < menu.length; j++) {
                    menu[j].classList.toggle('hidden');
                }
            });
        }
    }
});

// Submit User Profile
$('#profile-form').submit( function (e) {
  
  let isFormValid = $('#profile-form').valid();
  
  // Return If Form is invalid
  if (! isFormValid) {
    return
  }
  
  e.preventDefault();

  let request;

  if ( request ) {
    request.abort();          // Abort previous or pending requests
  }

  let form = getFormSerialize('#profile-form');

  request = getAjaxRequest(form);
  
  request.done( function ( response, textStatus, jqXHR ) {
    console.log(response);
  });

  request.fail( function ( jqXHR, textStatus, errorThrown ) {
     /** Log error to console*/
    console.error(  "The following error occurred: " + textStatus, errorThrown );
  });

  /** Enable inputs again */
  request.always(function () {
    form['inputs'].prop("disabled", false);
  });

});

/** 
* Global function to serialize the form values
*/
function getFormSerialize(id) {
  let form = $(id);

  let data = form.serialize();

  let $inputs = form.find("input");

  /** Disable inputs for the duration of the Ajax request. */
  $inputs.prop("disabled", true);                 

  return {
    'data': data, 
    'action': $(form).attr('action'),
    'method': $(form).attr('method'),
    'inputs': $inputs
  };
}

// Create Ajax Request
function getAjaxRequest (form) {
  let request = $.ajax({
    type: form['method'],
    url: form['action'],
    data: form['data']
  });

  return request
}
