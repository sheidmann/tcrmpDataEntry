$(document).ready(function() {

	// Prevent loading this script on every page
	if(!EA.onRailsPage('e_boatlogs', ['edit', 'new'])) {
    return;
  };

  // Trigger select2 opening on focus
  // on first focus (bubbles up to document), open the menu
  $(document).on('focus', '.select2-selection.select2-selection--single', function (e) {
    $(this).closest(".select2-container").siblings('select:enabled').select2('open');
  });
  // steal focus during close - only capture once and stop propogation
  $('select.select2').on('select2:closing', function (e) {
    $(e.target).data("select2").$selection.one('focus focusin', function (e) {
      e.stopPropagation();
    });
  });

	// Create alert if time is too early or late
	function alert24HourClock() {
    $("#e_boatlog_begin_time").on("focusout", function(){
      var $time = $(this).val();
      var b = ($time.split(":")[0]) + ($time.split(":")[1]);
      var $time2 = parseInt(b, 10);
      if ( $time2 <= "800" || $time2 >= "1800" ){
	      alert("Why are you diving in the dark?");
      } else {  }
    });
  };
  // Trigger the alert
  alert24HourClock();

  // Format the datepicker
  $("#e_boatlog_date_completed").datepicker({
    format: 'yyyy-mm-dd',
    autoclose: true
    // We cannot prevent focusout event from firing when selecting a date.
    // The code below acts as a workaround. 
	  // On focus, ignore the validation.
	  // On hide, remove the ignored validation and validate.
  }).on("hide",function(){ 
      $(".new_e_boatlog, .edit_e_boatlog").data("validator").settings.ignore="";
      $(this).valid();
  }).on("focus",function(){
      $(".new_e_boatlog, .edit_e_boatlog").data("validator").settings.ignore="#e_boatlog_date_completed, :hidden";
  });

  // Fix calendar arrows disappearing
  $('.prev i').removeClass();
  $('.prev i').addClass("fa fa-chevron-left");

  $('.next i').removeClass();
  $('.next i').addClass("fa fa-chevron-right");

  // Implement dropdown with textbox for observer
  $(".observerSelect").select2();
  // Validate on closing event (focusout not triggered)
  $(".observerSelect").on("close", function (e) {  
    $(this).valid(); 
  });
  // Create dropdown for each nested field added
  $('#boatlog_teams').on('cocoon:after-insert', function() {
    $(".observerSelect").last().select2(); // convert to select2
    // $('.observerSelect').last().select2('open'); // focus and open dropdown
    $(".observerSelect").on("close", function (e) {  
      $(this).valid(); // validate on close
    });
  });

  // Hitting enter while in diver section adds new diver
  $("#boatlog_teams").bind("keypress", function(e){
    if (e.keyCode ==13){
      e.preventDefault();
      $(".addDiver").trigger("click");
    };
  });
});