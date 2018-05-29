//JQUERY MODAL
$('.organization_status').click(function(e) {
  var organization_status_update_href = $(this).attr('href');
  var organization_status_href = organization_status_update_href.replace('status_update', 'status');
  var organization_status_post_type = $(this).attr('data-post-type');
  var organization_status_id = '#modal-window';
  $(organization_status_id).load(organization_status_href).dialog({
      resizable: false,
      height: "auto",
      width: 600,
      modal: true,
      buttons: {
        "ChangeButton" : {
          id: "change_button",
          text: organization_status_post_type,
          click: function() {
            jqxhr(organization_status_update_href, organization_status_id)
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

function jqxhr(organization_status_update_href, organization_status_id) {
  $.post(organization_status_update_href, function(data) {
    $("#change_button").prop("disabled", true).addClass("ui-state-disabled");
    $("#cancel_button").prop("disabled", true).addClass("ui-state-disabled");
    $(organization_status_id).html(data);
  })
    .done(function() {
      console.log( "done msg" );
    })
    .fail(function() {
      console.log( "fail msg" );
    })
    .always(function() {
      setTimeout(function(){$(organization_status_id).dialog("close");location.reload(true);}, 2000);
    });
};