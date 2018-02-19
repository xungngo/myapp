$("#delete_avatar").on("click", function() {
    $("#alert_div").show( "600", function() {
    });
});

$("#delete_avatar_no").on("click", function() {
    $("#alert_div").hide( "600", function() {
    });
});

$("#delete_avatar_yes").on("click", function() {
    $("#alert_div").hide( "600", function() {
        window.location = "user_preferences_avatar_delete";
    });
});