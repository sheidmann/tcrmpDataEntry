$(document).ready(function() {

	// Prevent loading this script on every page
	if(!EA.onRailsPage('coral_healths', ['edit', 'new'])) {
    return;
  };

  // Stop enter from submitting form
  $(document).bind("keypress", function(e){
    if (e.keyCode ==13){
      e.preventDefault();
    };
  });

  // First Section (Metadata)
  // Implement dropdown with textbox for site and observer
  $(".metaSelect").select2();
  //$("#fish_transect_user_id").select2();
  // Trigger validation on close (select2 does not trigger focusout)
  $(".metaSelect").on("close", function (e) {  
    $(this).valid(); 
  });

  // Format the datepicker
  $("#coral_health_date_completed").datepicker({
    format: 'yyyy-mm-dd',
    autoclose: true
    // We cannot prevent focusout event from firing when selecting a date.
    // The code below acts as a workaround. 
    // On focus, ignore the validation.
    // On hide, remove the ignored validation and validate.
  }).on("hide",function(){ 
      $(".new_coral_health, .edit_coral_health").data("validator").settings.ignore="";
      $(this).valid();
  }).on("focus",function(){
      $(".new_coral_health, .edit_coral_health").data("validator").settings.ignore="#coral_health_date_completed, :hidden";
  });

	// Create validation rules
	$(".new_coral_health, .edit_coral_health").validate( {
		ignore: [], // enable hidden field validation for select2
		// Trigger validation on focusout
  	onfocusout: function(element) {
        this.element(element);
    },

  	// List the rules
  	rules: {
			"coral_health[manager_id]": { required: true },
      "coral_health[site_id]": { required: true },
      "coral_health[user_id]": { required: true },
			"coral_health[date_completed]": { required: true },
      "coral_health[rep]": { required: true,
        number: true,
        min: 1,
        max: 6 }
  	},

  	// List the error messages
  	messages: {
      "coral_health[manager_id]": { required: "Required" },
      "coral_health[site_id]": { required: "Required" },
      "coral_health[user_id]": { required: "Required" },
      "coral_health[date_completed]": { required: "Required" },
      "coral_health[rep]": { required: "Required",
        number: "Must be a number",
        min: "Must be between 1 and 6",
        max: "Must be between 1 and 6" }
    },

    // Set error positions
    errorPlacement: function (error, element) {
      // Select2 dropdowns will put error on new line
      if (element.hasClass("speciesSelect")){
        error.insertAfter($(element).parent().parent().parent('div'));
      } else {
        // default for rest is immediately after
        error.insertAfter($(element));
      }
    }
  });

  // Second Section (Coral)
  // Hitting enter while in coral section adds new coral
  // $("#corals:not(#interactions)").bind("keypress", function(e){
  //   if (e.keyCode ==13){
  //     e.preventDefault();
  //     $(".addCoral").trigger("click");
  //   };
  //   $('.speciesSelect').last().focus();
  // });
  // Hitting enter while in interaction section adds new interaction
  // $("#interactions").bind("keypress", function(e){
  //   if (e.keyCode ==13){
  //     e.preventDefault();
  //     $(this).closest(".addInteraction").trigger("click");
  //   };
  //   $('.speciesSelect').last().focus();
  // });

  // Implement dropdown with textbox for species
  $(".speciesSelect").select2();
  // Validate on closing event (focusout not triggered)
  $(".speciesSelect").on("close", function (e) {  
    $(this).valid(); 
  });

  // Numbers must be integers (no decimals)
  $.validator.addMethod(
    "isInteger", function(value, element) {
      if(value.toString()==""){
        return true; // PASS validation if empty box
      }
      return /^[1-9][0-9]*$/.test(value.toString()) // otherwise check if integer with regex
    },
    "Must be an integer"
  );

  
  // Add properties to nested fields when added
  $('#corals, #interactions').on('cocoon:after-insert', function() {
    $(".speciesSelect").last().select2(); // convert to select2
    $('.speciesSelect').last().select2('open'); // focus and open dropdown
    $(".speciesSelect").on("close", function (e) {  
      $(this).valid(); // validate on close
    });
  });
  
  // Add validations for all nested station fields
  function validate_fields() {
    $('[name*="length_cm"]').each(function(){
      $(this).rules('add', {
        required: true,
        number: true,
        min: 0
      });
    });
    $('[name*="width_cm"]').each(function(){
      $(this).rules('add', {
        required: true,
        number: true,
        min: 0
      });
    });
    $('[name*="height_cm"]').each(function(){
      $(this).rules('add', {
        required: true,
        number: true,
        min: 0
      });
    });
    $('[name*="coral_code_id"]').each(function(){
      $(this).rules('add', {
        required: true
      });
    });
    $('[name*="value"]').each(function(){
      $(this).rules('add', {
        required: true,
        isInteger: true,
        min: 0,
        max: 100
      });
    });
  };

  // Trigger validation for nested coral fields
  validate_fields();

  // Add validation behavior to added nested fields
  $(document).delegate(".add_fields", "click", function(){ 
    // Trigger validation
    validate_fields();
  });
});