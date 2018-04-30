  $('.event_status').click(function(e) {
    var event_status_href = $(this).attr('href');
    $("#modal-window").load(event_status_href).dialog({
        resizable: false,
        height: "auto",
        width: 600,
        modal: true,
        buttons: {
          "Deactivate": function() {
            $(this).dialog("close");
          },
          Cancel: function() {
            $(this).dialog("close");
          }
        }
      });
      e.preventDefault();
  });