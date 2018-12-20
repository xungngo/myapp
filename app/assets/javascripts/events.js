

  var auto_complete_id = "event_address"; //global var for initAutoComplete()

  //jquery dialog
  $('.event_schedule').click(function(e) {
    var event_schedule_load_href = $(this).attr('href');
    var event_schedule_post_href = event_schedule_load_href.replace('/new?', '?');
    var event_schedule_post_type = $(this).attr('data-post-type');
    var event_schedule_id = '#modal-window';
    $(event_schedule_id).load(event_schedule_load_href).dialog({
        resizable: false,
        height: "auto",
        width: "65%",
        modal: true,
        buttons: {
          "PostButton" : {
            id: "post_button",
            text: event_schedule_post_type,
            click: function() {
              jqxhr(event_schedule_post_href, event_schedule_id)
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

  function jqxhr(event_schedule_post_href, event_schedule_id) {
    params = $('#new_schedule').serialize(); alert(params);
    $.post(event_schedule_post_href, params, function(data) {
      $("#post_button").prop("disabled", true).addClass("ui-state-disabled");
      $("#cancel_button").prop("disabled", true).addClass("ui-state-disabled");
      $(event_schedule_id).html(data);
    })
      .done(function() {
        console.log( "done msg" );
      })
      .fail(function() {
        console.log( "fail msg" );
      })
      .always(function() {
        setTimeout(function(){$(event_schedule_id).dialog("close");location.reload(true);}, 2000);
      });
  };