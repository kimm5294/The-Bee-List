// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function() {

  $(".add-goal-link").on("click", function(event) {
    event.preventDefault();
    var $this = this;
    $.ajax({

    })
    .done(function(res) {
      $($this).remove();
    })
  })
});

$(function(){
  $('#profiletabs ul li a').on('click', function(e){
    e.preventDefault();
    var newcontent = $(this).attr('href');

    $('#profiletabs ul li a').removeClass('sel');
    $(this).addClass('sel');

    $('#content section').each(function(){
      if(!$(this).hasClass('hidden')) { $(this).addClass('hidden'); }
    });

    $(newcontent).removeClass('hidden');
  });

  $(".friends-search-form").on("submit", function(event) {
    event.preventDefault();

    var data = $(this).serialize();
    var url = $(this).attr("action")
    var method = $(this).attr("method")

    $.ajax({
      url: url,
      method: method,
      data: data
    })
    .done(function(response) {
      $(".friends-search-results-div").html(response);
    })
  })






});
