$( document ).ready(function() {
  $("#form-search-room-admin").submit(function(e) {
    var start_price = $("#start_price").val();
    var end_price = $("#end_price").val();
    if (isNaN(start_price) || isNaN(end_price)) {
      alert(I18n.t("admins.err_price"))
      return false;
    } else {
      if(parseFloat(start_price) > parseFloat(end_price)) {
        alert(I18n.t("admins.err_price2"))
        return false;
      }
    }
  });
});
