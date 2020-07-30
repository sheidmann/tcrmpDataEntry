$(document).ready(function() {

	// Create alert if time is too early or late
	function alert24HourClock() {
    $("#boatlog_begin_time").on("focusout", function(){
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

  // Add validation method to check format of time
  jQuery.validator.addMethod("timeformat", function(value, element) {
    return this.optional(element) || /^([0-9]|0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$/.test(value);
  }, "Enter as HH:MM (24 hr clock)");

	// Create validation rules
	$(".new_boatlog, .edit_boatlog").validate( {
		debug:true,
		// Trigger validation on focusout
  	onfocusout: function(element) {
        this.element(element);
    },

  	// List the rules
  	rules: {
			"boatlog[site_id]": { required: true },
			"boatlog[date_completed]": { required: true },
			"boatlog[begin_time]": { required: true, timeformat: true },
			"boatlog[manager_id]": { required: true }
  	},

  	// List the error messages
  	messages: {
      "boatlog[site_id]": { required: "Required" },
      "boatlog[date_completed]": { required: "Required" },
      "boatlog[begin_time]": { required: "Required" },
      "boatlog[manager_id]": { required: "Required" }
    }
  });

  // Format the datepicker
  $("#boatlog_date_completed").datepicker({
    format: 'yyyy-mm-dd',
    autoclose: true
    // We cannot prevent focusout event from firing when selecting a date.
    // The code below acts as a workaround. 
	  // On focus, ignore the validation.
	  // On hide, remove the ignored validation and validate.
  }).on("hide",function(){ 
      $(".new_boatlog, .edit_boatlog").data("validator").settings.ignore="";
      $(this).valid();
  }).on("focus",function(){
      $(".new_boatlog, edit_boatlog").data("validator").settings.ignore="#boatlog_date_completed, :hidden";
  });

	// Add validations for nested station fields
  function validate_fields() {
    $('[name*="user_id"]').each(function(){
      $(this).rules('add', {
        required: true
      });
    });
    $('[name*="survey_type_id"]').each(function(){
      $(this).rules('add', {
        required: true
      });
    });
    $('[name*="rep"]').each(function(){
      $(this).rules('add', {
        required: true,
        number: true,
        min: 1,
        max: 12
      });
    });
  };

  // Trigger validation for nested station fields
  validate_fields();
  // Trigger validation for added nested station fields
  $(document).delegate(".add_fields", "click", function(){ 
    validate_fields();
  });
});