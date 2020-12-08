//= require i18n
//= require i18n.js
//= require i18n/translations

$( document ).ready(function() {
  var start_price = $("#start_price").val();
  var end_price = $("#end_price").val();
  if (isNaN(start_price) || isNaN(end_price)) {
    alert(I18n.t("admins.err_price"))
  } else {
    if(parseFloat(start_price) > parseFloat(end_price)) {
      alert(I18n.t("admins.err_price2"))
    }
  }
});
