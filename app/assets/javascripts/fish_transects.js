$(document).ready(function() {

	// Prevent loading this script on every page
	if(!EA.onRailsPage('fish_transects', ['edit', 'new'])) {
    return;
  };

  // Implement dropdown with textbox for site and observer
  $("#fish_transect_site_id").select2();
  $("#fish_transect_user_id").select2();
  // Trigger validation on close (select2 does not trigger focusout)
  $("select").on("select2:close", function (e) {  
    $(this).valid(); 
  });

  // Format the datepicker
  $("#fish_transect_date_completed").datepicker({
    format: 'yyyy-mm-dd',
    autoclose: true
    // We cannot prevent focusout event from firing when selecting a date.
    // The code below acts as a workaround. 
    // On focus, ignore the validation.
    // On hide, remove the ignored validation and validate.
  }).on("hide",function(){ 
      $(".new_fish_transect, .edit_fish_transect").data("validator").settings.ignore="";
      $(this).valid();
  }).on("focus",function(){
      $(".new_fish_transect, .edit_fish_transect").data("validator").settings.ignore="#fish_transect_date_completed, :hidden";
  });

	// Create alert if time is too early or late
	function alert24HourClock() {
    $("#fish_transect_begin_time").on("focusout", function(){
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

  // Create alert if length is less than a full transect
  function alert25Meters() {
    $("#fish_transect_completed_m").on("focusout", function(){
      var $m = $(this).val();
      if ( $m < 25 ){
        alert("Are you sure you did less than a full transect (25 m)?");
      } else {  }
    });
  };
  // Trigger the alert
  alert25Meters();

  // Add validation method to check format of time
  jQuery.validator.addMethod("timeformat", function(value, element) {
    return this.optional(element) || /^([0-9]|0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$/.test(value);
  }, "Enter as HH:MM (24 hr clock)");

	// Create validation rules
	$(".new_fish_transect, .edit_fish_transect").validate( {
		ignore: [], // enable hidden field validation for select2
		// Trigger validation on focusout
  	onfocusout: function(element) {
        this.element(element);
    },

  	// List the rules
  	rules: {
			"fish_transect[manager_id]": { required: true },
      "fish_transect[site_id]": { required: true },
      "fish_transect[user_id]": { required: true },
			"fish_transect[date_completed]": { required: true },
			"fish_transect[begin_time]": { required: true, timeformat: true },
      "fish_transect[oc_cc]": { required: true },
      "fish_transect[rep]": { required: true,
        number: true,
        min: 1,
        max: 9 },
      "fish_transect[completed_m]": { required: true,
        number: true,
        min: 1,
        max: 25 }
			
  	},

  	// List the error messages
  	messages: {
      "fish_transect[manager_id]": { required: "Required" },
      "fish_transect[site_id]": { required: "Required" },
      "fish_transect[user_id]": { required: "Required" },
      "fish_transect[date_completed]": { required: "Required" },
      "fish_transect[begin_time]": { required: "Required" },
      "fish_transect[oc_cc]": { required: "Required" },
      "fish_transect[rep]": { required: "Required",
        number: "Must be a number",
        min: "Must be between 1 and 9",
        max: "Must be between 1 and 9" },
      "fish_transect[completed_m]": { 
        required: "Required",
        number: "Must be a number",
        min: "Must be between 1 and 25",
        max: "Must be between 1 and 25" }
    }
  });

  

  // Implement dropdown with textbox for species
  $(".speciesSelect").select2();
  // Create dropdown for each nested field added
  $('#fishes').on('cocoon:after-insert', function() {
    $(".speciesSelect").last().select2();
  });

	// Add validations for nested station fields
  function validate_fields() {
    $('[name*="test_size_cm"]').each(function(){
      $(this).rules('add', {
        required: true
      });
    });
    $('[name*="fish_id"]').each(function(){
      $(this).rules('add', {
        required: true
      });
    });
    $('.sizeBinField').each(function(){
      $(this).rules('add', {
        required: true
      });
    });
  };

  // Trigger validation for nested diadema and fish fields
  validate_fields();
  // Trigger validation for added nested station fields
  $(document).delegate(".add_fields", "click", function(){ 
    //$('.sizeBinField').val(0); // This line turns entered numbers to 0 when fields added
    validate_fields();
  });
});