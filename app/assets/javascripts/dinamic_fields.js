function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  //$(link).prev("input[type=hidden]").attr("required",false);
  $(link).closest(".fields").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g");

  $('.table_fields').append(content.replace(regexp, new_id));
  //$(link).closest('.table_fields').before(content.replace(regexp, new_id));
}