
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
    let html = ( response.status != 200 ) ? getHtmlResponse(response.message, 1) : getHtmlResponse(response.message);
    $('#response-message').html(html);
  });

  request.fail( function ( jqXHR, textStatus, errorThrown ) {
     /** Log error to console*/
    console.error(  "The following error occurred: " + textStatus, errorThrown );
    let html = getHtmlResponse(textStatus, 1);
    $('#response-message').html(html);
  });

  /** Enable inputs again */
  request.always(function () {
    form['inputs'].prop("disabled", false);
  });

});

// Submit change password
$('#change-password-form').submit( function (e) {
  
  let isFormValid = $('#change-password-form').valid();
  
  // Return If Form is invalid
  if (! isFormValid) {
    return
  }
  
  e.preventDefault();

  let request;

  if ( request ) {
    request.abort();          // Abort previous or pending requests
  }

  let form = getFormSerialize('#change-password-form');

  request = getAjaxRequest(form);
  
  request.done( function ( response, textStatus, jqXHR ) {
    let html = ( response.status != 200 ) ? getHtmlResponse(response.message, 1) : getHtmlResponse(response.message);
    $('#response-message').html(html);
  });

  request.fail( function ( jqXHR, textStatus, errorThrown ) {
     /** Log error to console*/
    console.error(  "The following error occurred: " + textStatus, errorThrown );
    let html = getHtmlResponse(textStatus, 1);
    $('#response-message').html(html);
  });

  /** Enable inputs again */
  request.always(function () {
    form['inputs'].prop("disabled", false);
  });

});

/** 
* Submit Form Function
*/
function generalFormSubmit ( formId ) {
  
  $('#' + formId).one('submit', function (e) {
    let isFormValid = $('#' + formId).valid();
  
    // Return If Form is invalid
    if (! isFormValid) {
      return
    }
    
    e.preventDefault();

    let request;

    if ( request ) {
      request.abort();          // Abort previous or pending requests
    }

    let form = getFormSerialize('#' + formId);

    request = getAjaxRequest(form);
    
    request.done( function ( response, textStatus, jqXHR ) {
      let html = ( response.status != 200 ) ? getHtmlResponse(response.error, 1) : getHtmlResponse(response.message);
      $('#' + formId + '-response-message').html(html);
    });

    request.fail( function ( jqXHR, textStatus, errorThrown ) {
      /** Log error to console*/
      console.error(  "The following error occurred: " + textStatus, errorThrown );
      let html = getHtmlResponse(errorThrown, 1);
      $('#' + formId + '-response-message').html(html);
    });

    /** Enable inputs again */
    request.always(function () {
      form['inputs'].prop("disabled", false);
    });

  });
}


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

// Return Alert HTML
function getHtmlResponse ( message, alert ) {
  let alertClass = 'text-green-800';
  let alertBorderClass = 'border-green-500';
  if ( alert === 1 ) {
    alertClass = 'text-red-800';
    alertBorderClass = 'border-red-500';
  }
  return `<div class="py-8 px-6">
        <div class="p-6 bg-white border-l-4 ` + alertBorderClass + ` shadow-md rounded-r-lg">
          <div class="flex items-center">
            <h3 class="`+ alertClass + ` font-medium">` + message + `</h3>
            <button class="ml-auto remove-alert">
              <svg class="` + alertClass + ` remove-alert" width="12" height="12" viewBox="0 0 12 12" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M6.93341 6.00008L11.1334 1.80008C11.4001 1.53341 11.4001 1.13341 11.1334 0.866748C10.8667 0.600081 10.4667 0.600081 10.2001 0.866748L6.00008 5.06675L1.80008 0.866748C1.53341 0.600081 1.13341 0.600081 0.866748 0.866748C0.600082 1.13341 0.600082 1.53341 0.866748 1.80008L5.06675 6.00008L0.866748 10.2001C0.733415 10.3334 0.666748 10.4667 0.666748 10.6667C0.666748 11.0667 0.933415 11.3334 1.33341 11.3334C1.53341 11.3334 1.66675 11.2667 1.80008 11.1334L6.00008 6.93341L10.2001 11.1334C10.3334 11.2667 10.4667 11.3334 10.6667 11.3334C10.8667 11.3334 11.0001 11.2667 11.1334 11.1334C11.4001 10.8667 11.4001 10.4667 11.1334 10.2001L6.93341 6.00008Z" fill="currentColor" class="remove-alert"></path>
              </svg>
            </button>
          </div>
        </div>
      </div>`;
}

// Delete response message when remove-alert class is clicked
$( document ).on( 'click', ".remove-alert", function() {
  $('#response-message').html('');
  $('#company-signup-form-response-message').html('');
}); 


/**
* Name: updateTaskStatus
* Desc: Update the status of the task. 
*/
function updateTaskStatus(task, status) {

  let path = window.location.pathname;

  let request;

  if ( request ) {
    request.abort();          // Abort previous or pending requests
  }

  request = $.ajax({
    type: 'POST',
    url: path + '/task/update?status=' + status + '&task=' + task
  });

  request.done( function ( response, textStatus, jqXHR ) {
      if ( response.status === 200 ) {
        successDialog();  
        $('#' + task).text(status);
      }
      else {
        failedDialog();  
      }
    });

    request.fail( function ( jqXHR, textStatus, errorThrown ) {
      /** Log error to console*/
      console.error(  "The following error occurred: " + textStatus, errorThrown );
      let html = getHtmlResponse(errorThrown, 1);
      $('#' + task + '-response-message').html(html);
    });
}

function successDialog () {
  $( "#dialog-message" ).dialog({
    width: 500,
    modal: true,
    buttons: [
      {
        text: "Close",
        click: function() {
          $( this ).dialog( "close" );
        }
      }
    ]
  });
  
  $(".ui-dialog-buttonpane button:contains('Close')")
    .attr('style','background-color: rgba(6, 182, 212); color: white; position: relative; right: 200px;');
}

function failedDialog () {
  $( "#dialog-message-failed" ).dialog({
    width: 500,
    modal: true,
    buttons: [
      {
        text: "Close",
        click: function() {
          $( this ).dialog( "close" );
        }
      }
    ]
  });

  $(".ui-dialog-buttonpane button:contains('Close')")
    .attr('style','background-color: #d34747; color: white; position: relative; right: 200px;');
}

