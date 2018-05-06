  $('.event_status').click(function(e) {
    var event_status_href = $(this).attr('href');
    var event_status_post_type = $(this).attr('data-post-type');
    var event_status_id = '#modal-window';
    $(event_status_id).load(event_status_href).dialog({
        resizable: false,
        height: "auto",
        width: 600,
        modal: true,
        buttons: {
          "ChangeButton" : {
            id: "change_button",
            text: event_status_post_type,
            click: function() {
              jqxhr(event_status_href, event_status_post_type, event_status_id)
            }
          },
          "CancelButton" : {
            id: "cancel_button",
            text: "Cancel",
            click: function() {
              $(this).dialog("close");
            }
          }
        }
      });
      e.preventDefault();
  });

  function jqxhr(event_status_href, event_status_post_type, event_status_id) {
    $.post(event_status_href+'_'+event_status_post_type.toLowerCase(), function(data) {
      $("#change_button").prop("disabled", true).addClass("ui-state-disabled");
      $("#cancel_button").prop("disabled", true).addClass("ui-state-disabled");
      $(event_status_id).html(data);
    })
      .done(function() {
        console.log( "done msg" );
      })
      .fail(function() {
        console.log( "fail msg" );
      })
      .always(function() {
        setTimeout(function(){$(event_status_id).dialog("close");location.reload(true);}, 2000);
      });
  };