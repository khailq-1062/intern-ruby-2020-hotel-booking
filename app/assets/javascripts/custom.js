//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require turbolinks
//= require manage_order.js

$(document).on('turbolinks:load', function() {
  const OPEN_STATUS = 'open';
  const CLOSE_STATUS = 'close';
  var origin_path = window.location.origin;
  var url_check_room = origin_path + '/check_room';
  var login_url = origin_path + '/login';

  $('#btn-check-room').click(function(){
    let date_start = convert_date($('#input_date_start_check').val());
    let date_end = convert_date($('#input_date_end_check').val());
    let room_id = parseInt($('#room_id').val());
    $.ajax({
      url: url_check_room,
      method: 'post',
      dataType: 'json',
      data: {
        room_id: room_id,
        date_start: date_start,
        date_end: date_end
      },
      complete: function(data){
        if(data['responseText'] == OPEN_STATUS){
          $('#result-check-room').text(I18n.t('open'));
          $('#status-room').css('backgroundColor', '#85ab00');
          $('#btn-bookroom').css('display', 'block');
        } else {
          $('#result-check-room').text(I18n.t('close'));
          $('#status-room').css('backgroundColor', 'red');
          $('#btn-bookroom').css('display', 'none');
        }
        $('#status-room').css('display', 'block');
      }
    });
  });

  $('#btn-bookroom').click(function(){
    let url_form_order = $('#form_book_room').val();
    if(url_form_order == ''){
      alert(I18n.t("must_login"));
      window.location.href = login_url;
    }else{
      let date_start = convert_date($('#input_date_start_check').val());
      let date_end = convert_date($('#input_date_end_check').val());
      let room_id = parseInt($('#room_id').val());
      let quantity_person = parseInt($('#quantity-person').html());
      $.ajax({
        url: url_form_order,
        method: 'get',
        data: {
          room_id: room_id,
          date_start: date_start,
          date_end: date_end,
          quantity_person: quantity_person
        },
        complete: function(data){
          let modal = $('#exampleModal');
          modal.css('opacity','1');
          modal.css('padding-top','100px');
          $('#body-modal-confirm').html(data['responseText']);
          modal.modal('show');
        }
      });
    }
  });

  $('#btn-sub-person').click(function(){
    let quantity_person = $('#quantity-person').html();
    let quantity_person_new;
    if(quantity_person > 0){
      quantity_person_new = parseInt(quantity_person) - 1;
    }else{
      quantity_person_new = 0;
    }
    $('#quantity-person').text(quantity_person_new);
    $('#hidden_quantity_person').val(quantity_person_new);
  });

  $('#btn-add-person').click(function(){
    let max_person = parseInt($('#maxperson').html());
    let quantity_person = $('#quantity-person').html();
    let quantity_person_new = parseInt(quantity_person) + 1;
    if(quantity_person_new > parseInt(max_person)){
      alert(I18n.t('max_person_for_this_room'));
    }else{
      $('#quantity-person').text(quantity_person_new);
      $('#hidden_quantity_person').val(quantity_person_new);
    }
  });

  function convert_date(date){
    return date.split('/').reverse().join('-');
  }

  $(document).on('change',function(){
    $('#warning-room-booked').hide();
  });

  $(document).on('change', '#input_date_start', function(){
    let date_start = convert_date($('#input_date_start').val());
    let date_end = convert_date($('#input_date_end').val());
    let room_id = parseInt($('#room_id').val());
    $.ajax({
      url: url_check_room,
      method: 'post',
      dataType: 'json',
      data: {
        room_id: room_id,
        date_start: date_start,
        date_end: date_end
      },
      complete: function(data){
        if(data['responseText'] == OPEN_STATUS){
          calculate_total_pay(date_start, date_end);
        }else{
          hide_button_booking();
        }
      }
    });
  });

  $(document).on('change', '#input_date_end', function(){
    let date_start = convert_date($('#input_date_start').val());
    let date_end = convert_date($('#input_date_end').val());
    let room_id = parseInt($('#room_id').val());
    $.ajax({
      url: url_check_room,
      method: 'post',
      dataType: 'json',
      data: {
        room_id: room_id,
        date_start: date_start,
        date_end: date_end
      },
      complete: function(data){
        if(data['responseText'] == OPEN_STATUS){
          calculate_total_pay(date_start, date_end);
        }else{
          hide_button_booking();
        }
      }
    });
  });

  function hide_button_booking(){
    $('#btn-submit-booking').hide();
    $('#warning-room-booked').css('color','red');
    $('#warning-room-booked').show();
  }

  function calculate_total_pay(date_start, date_end){
    let unit_price = parseFloat($('#order_price').val());
    let date1 = new Date(convert_date(date_start));
    let date2 = new Date(convert_date(date_end));
    let total_day = parseInt(((date2.getTime() - date1.getTime())) / (1000 * 3600 * 24)) + 1;
    let total_pay =  total_day * unit_price;
    $('#input_total_pay').val(total_pay);
    $('#btn-submit-booking').show();
  }
});
