  //autocomplete map
  function initAutoComplete() {
    var form_field = document.getElementById(auto_complete_id);
    new google.maps.places.Autocomplete(form_field);

    //enter key to select not submit
    google.maps.event.addDomListener(form_field, 'keydown', function(event) {
        if (event.keyCode === 13) {
            event.preventDefault();
        }
    });
  };