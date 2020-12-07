$(document).ready(function(){
  $('#btn-sub-person').click(function(){
    let quantity_person = $('#quantity-person').html();
    let quantity_person_new;
    if(quantity_person > 0){
      quantity_person_new = convert(quantity_person) - 1;
    } else {
      quantity_person_new = 0;
    }
    $('#quantity-person').text(quantity_person_new);
    $('#hidden_quantity_person').val(quantity_person_new);
  });

  $('#btn-add-person').click(function(){
    let max_person = $('#maxperson').value;
    let quantity_person = $('#quantity-person').html();
    let quantity_person_new = convert(quantity_person) + 1;
    if(quantity_person_new > parseInt($('#maxperson').value)){
      alert('max_person_for_this_room');
    } else {
      $('#quantity-person').text(quantity_person_new);
      $('#hidden_quantity_person').val(quantity_person_new);
    }
  });
});

function convert(data){
  return parseInt(data);
}
