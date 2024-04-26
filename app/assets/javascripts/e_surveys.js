$(document).ready(function() {

	// Prevent loading this script on every page
	if(!EA.onRailsPage('e_surveys', ['edit', 'new'])) {
    return;
  };

  // Stop enter from submitting form
  $(document).bind("keypress", function(e){
    if (e.keyCode ==13){
      e.preventDefault();
    };
  });

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

  // First Section (Metadata)
  // Implement dropdown with textbox for observer
  $(".metaSelect").select2();
  // Trigger validation on close (select2 does not trigger focusout)
  $(".metaSelect").on("close", function (e) {  
    $(this).valid(); 
  });

  // Format the datepicker
  $("#e_survey_date_completed").datepicker({
    format: 'yyyy-mm-dd',
    autoclose: true
    // We cannot prevent focusout event from firing when selecting a date.
    // The code below acts as a workaround. 
    // On focus, ignore the validation.
    // On hide, remove the ignored validation and validate.
  }).on("hide",function(){ 
      $(".new_e_survey, .edit_e_survey").data("validator").settings.ignore="";
      $(this).valid();
  }).on("focus",function(){
      $(".new_e_survey, .edit_e_survey").data("validator").settings.ignore="#e_survey_date_completed, :hidden";
  });

  // Fix calendar arrows disappearing
  $('.prev i').removeClass();
  $('.prev i').addClass("fa fa-chevron-left");

  $('.next i').removeClass();
  $('.next i').addClass("fa fa-chevron-right");

  // Implement dropdown with textbox for species
  $(".speciesSelect").select2();


  // Add properties to nested fields when added
  $('#plotcorals').on('cocoon:after-insert', function() {
    $(".speciesSelect").last().select2(); // convert to select2
    $('.speciesSelect').last().select2('open'); // focus and open dropdown
    $(".speciesSelect").on("close", function (e) {  
      $(this).valid(); // validate on close
    });
  });
});