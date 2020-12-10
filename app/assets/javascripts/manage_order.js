$(document).ready(function(){
  $('.tr-order').click(function(){
    let link = $(this).data('link');
    window.location.href = link;
  });
});
